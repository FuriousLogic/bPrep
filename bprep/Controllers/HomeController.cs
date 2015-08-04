using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using BPrep_BL.Model;

namespace BPrep.Controllers
{
    public class HomeController : Controller
    {
        public void SendEmailToBPrep(string from, string subject, string body)
        {
            BpFunctions.SendEmail("admin@bPrep.net", subject, body, from);
        }

        public void SendWeeklyEmails()
        {
            var adminEmailAddress = BpFunctions.GetParameterValue(BpFunctions.ParameterName.AdminEmailAddress);
            if (adminEmailAddress == null) throw new Exception(string.Format("Cannot find value for parameter [{0}]", BpFunctions.ParameterName.AdminEmailAddress));

            //Is it time to send the emails?
            var lastWeeklyEmailsSentValue = BpFunctions.GetParameterValue(BpFunctions.ParameterName.LastWeeklyEmailsSent);
            DateTime emailsSent;
            if (!DateTime.TryParse(lastWeeklyEmailsSentValue, out emailsSent))
                emailsSent = new DateTime(1, 1, 1);
            var timeSpan = DateTime.Today - emailsSent;
            if (timeSpan.TotalDays < 7) return;

            var db = new BP_ModelContainer();

            var weeklyEmailSummary = new StringBuilder();
            weeklyEmailSummary.AppendLine(string.Format("bPrep.net Weekly Summary {0}", DateTime.Now.ToString("dd/MMM/yyyy")));

            foreach (var prepper in db.Preppers)
            {
                var prepperWeeklyReport = new StringBuilder();
                foreach (var kit in prepper.Kits)
                {
                    foreach (var item in kit.Items)
                    {
                        //Planned?
                        if (item.ItemStatus.Name.Equals(BpFunctions.ItemStatuses.Planned.ToString()))
                            prepperWeeklyReport.AppendLine(string.Format("Yet to be ordered: Kit [{0}], Item [{1}]", kit.Name, item.Name));

                        //Ordered?
                        if (item.ItemStatus.Name.Equals(BpFunctions.ItemStatuses.Ordered.ToString()))
                            prepperWeeklyReport.AppendLine(string.Format("Waiting for delivery: Kit [{0}], Item [{1}]", kit.Name, item.Name));

                        //Received?
                        if (item.ItemStatus.Name.Equals(BpFunctions.ItemStatuses.Received.ToString()))
                            prepperWeeklyReport.AppendLine(string.Format("Put in place!: Kit [{0}], Item [{1}]", kit.Name, item.Name));

                    }
                }

                //Unsubscribe line
                if (Request.Url != null)
                {
                    var host = Request.Url.Authority.ToLower();
                    var fullLink = string.Format("http://{0}/Account/Unsubscribe?guid={1}", host, prepper.UnsubscribeGuid);
                    prepperWeeklyReport.AppendLine(" ");
                    prepperWeeklyReport.AppendLine(" ");
                    prepperWeeklyReport.AppendLine("To Unsubscribe from bPrep.net click this link; " + fullLink);
                }


                if (prepperWeeklyReport.Length > 0)
                {
                    BpFunctions.SendEmail(prepper.Email, "bPrep.net Weekly Summary Report", prepperWeeklyReport.ToString());

                    weeklyEmailSummary.AppendLine(" ");
                    weeklyEmailSummary.AppendLine(string.Format("Prepper [{0}]", prepper.Name));
                    weeklyEmailSummary.AppendLine(prepperWeeklyReport.ToString());
                }
            }

            //Summary report to me
            BpFunctions.SendEmail(adminEmailAddress, "bPrep.Net Admin Weekly Email Report", weeklyEmailSummary.ToString());

            //Set last sent time to today
            var paramName = BpFunctions.ParameterName.LastWeeklyEmailsSent.ToString();
            var parameter = (from p in db.Parameters where p.Name == paramName select p).FirstOrDefault();
            if (parameter == null) throw new Exception(string.Format("Cannot find parameter [{0}]", BpFunctions.ParameterName.LastWeeklyEmailsSent));
            parameter.Value = DateTime.Today.ToString("dd/MMM/yyyy");
            db.SaveChanges();
        }

        public void SendDailyEmailsIfNecessary()
        {
            var adminEmailAddress = BpFunctions.GetParameterValue(BpFunctions.ParameterName.AdminEmailAddress);
            if (adminEmailAddress == null) throw new Exception(string.Format("Cannot find value for parameter [{0}]", BpFunctions.ParameterName.AdminEmailAddress));

            //Is it time to send the emails?
            var lastDailyEmailsSent = BpFunctions.GetParameterValue(BpFunctions.ParameterName.LastDailyEmailsSent);
            DateTime emailsSent;
            if (!DateTime.TryParse(lastDailyEmailsSent, out emailsSent))
                emailsSent = new DateTime(1, 1, 1);
            var timeSpan = DateTime.Today - emailsSent;
            if (timeSpan.TotalDays < 1) return;

            var db = new BP_ModelContainer();

            var dailyEmailSummary = new StringBuilder();
            dailyEmailSummary.AppendLine(string.Format("bPrep.net Daily Summary {0}", DateTime.Now.ToString("yy-mm-dd/MMM/yyyy")));

            foreach (var prepper in db.Preppers)
            {
                //Get items that need replacing/checking
                var prepperDailyReport = new StringBuilder();
                foreach (var kit in prepper.Kits)
                {
                    foreach (var item in kit.Items)
                    {
                        //Is Positioned?
                        if (!item.ItemStatus.Name.Equals(BpFunctions.ItemStatuses.Positioned.ToString())) continue;
                        if (item.StartWarningForReplacement == null) continue;

                        //Is due for replacement / check
                        var startWarningForReplacement = (DateTime)item.StartWarningForReplacement;
                        if (startWarningForReplacement <= DateTime.Today)
                            prepperDailyReport.AppendLine(string.Format("Kit [{0}], Item [{1}] replace/Check by [{2}]",
                                kit.Name, item.Name, startWarningForReplacement.ToString("dd/MMM/yyyy")));
                    }
                }
                if (prepperDailyReport.Length > 0)
                {
                    BpFunctions.SendEmail(prepper.Email, "bPrep.net  Item Expiery Report", prepperDailyReport.ToString());

                    dailyEmailSummary.AppendLine(" ");
                    dailyEmailSummary.AppendLine(string.Format("Prepper [{0}]", prepper.Name));
                    dailyEmailSummary.AppendLine(prepperDailyReport.ToString());
                }
            }

            //Summary report to me
            BpFunctions.SendEmail(adminEmailAddress, "bPrep.Net Daily Email Report (Admin)", dailyEmailSummary.ToString());

            //Set last sent time to today
            var paramName = BpFunctions.ParameterName.LastDailyEmailsSent.ToString();
            var parameter = (from p in db.Parameters where p.Name == paramName select p).FirstOrDefault();
            if (parameter == null) throw new Exception(string.Format("Cannot find parameter [{0}]", BpFunctions.ParameterName.LastDailyEmailsSent));
            parameter.Value = DateTime.Today.ToString("dd/MMM/yyyy");
            db.SaveChanges();
        }

        public string GetAds()
        {
            var db = new BP_ModelContainer();

            var availableAdds = (from si in db.SampleItems where si.AmazonWidget != null select si.AmazonWidget).ToList();

            const int maxAds = 2;
            var selectedAds = new List<string>();
            while (selectedAds.Count < maxAds)
            {
                var random = new Random();
                var i = random.Next(availableAdds.Count);
                selectedAds.Add(availableAdds[i]);
                availableAdds.RemoveAt(i);
                if (availableAdds.Count == 0) break;
            }

            var adsHtml = "";
            foreach (var ad in selectedAds)
                adsHtml += string.Format("<div>{0}</div>", ad);

            return adsHtml;
        }

        public void KeepNotified(string name, string email)
        {
            //Send email to me
            var adminEmailAddress = BpFunctions.GetParameterValue(BpFunctions.ParameterName.AdminEmailAddress);
            var body = string.Format("Request to be kept notified{0}." +
                                     "From: {1}{0}" +
                                     "Email: {2}", Environment.NewLine, name, email);
            BpFunctions.SendEmail(adminEmailAddress, "bPrep Request For Notification", body);

            //Send confirmation to them
            body = string.Format("{0},{1} Thanks for submitting your name to the bPrep.net developement site.{1}" +
                                        "We'll keep you informed of development & requests for testing & feedback.{1}" +
                                        "Thanks{1}" +
                                        "The bPrep Team", name, Environment.NewLine);
            BpFunctions.SendEmail(email, "bPreb Notification", body);
        }

        public ActionResult Index()
        {
            ViewBag.VersionNumber = System.Reflection.Assembly.GetExecutingAssembly().GetName().Version.ToString();
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Be Prepared!  That's it really...";

            return View();
        }

        public ActionResult Contact()
        {
            var currentPrepper = BpFunctions.GetCurrentPrepper(User);
            return View(currentPrepper);
        }

        public ActionResult GHB()
        {
            return View();
        }

        public ActionResult LBP()
        {
            return View();
        }

        public ActionResult Stores()
        {
            return View();
        }
    }
}