using System;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Runtime.InteropServices;
using System.Security.Principal;
using BPrep_BL.Model;

//Meaningless Change to test Github connection
namespace BPrep.Controllers
{
    public static class BpFunctions
    {
        public enum ItemStatuses
        {
            Planned = 1,
            Ordered = 2,
            Received = 3,
            Positioned = 4
        }
        public enum ParameterName
        {
            TotalAdsOnScreen,
            AdminEmailAddress,
            LastDailyEmailsSent,
            LastWeeklyEmailsSent
        }

        public static Prepper GetCurrentPrepper(IPrincipal user)
        {
            var db = new BP_ModelContainer();
            var prepperName = user.Identity.Name;
            var prepper = (from p in db.Preppers where p.Name == prepperName select p).FirstOrDefault();
            return prepper ?? null;
        }

        public static void SendEmail(string toEmailAddress, string subject, string body, string fromEmailAddress="admin@bprep.net")
        {
            try
            {
                var smtpClient = new SmtpClient
                {
                    Host = "mail.april.arvixe.com",
                    DeliveryMethod = SmtpDeliveryMethod.Network,
                    UseDefaultCredentials = true,
                    Credentials = new NetworkCredential("admin@bprep.net", "fO8qiO5G3ldU")
                };

                var mailMessage = new MailMessage(fromEmailAddress, toEmailAddress)
                {
                    Subject = subject,
                    Body = body
                };

                smtpClient.Send(mailMessage);
            }
            catch (Exception e)
            {
                //todo:handle error
                Console.WriteLine(e);
            }
        }

        internal static string GetParameterValue(ParameterName parameterName)
        {
            var db = new BP_ModelContainer();
            var name = parameterName.ToString();
            var parameter = (from p in db.Parameters where p.Name.Equals(name, StringComparison.InvariantCultureIgnoreCase) select p).FirstOrDefault();
            if (parameter == null)
                throw new Exception(string.Format("Cannot find parameter [{0}]", name));

            return parameter.Value;
        }
    }
}