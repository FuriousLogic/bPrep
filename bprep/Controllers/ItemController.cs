using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Text;
using System.Web.Mvc;
using BPrep_BL.Model;

namespace BPrep.Controllers
{
    [Authorize]
    public class ItemController : Controller
    {
        private readonly BP_ModelContainer _db = new BP_ModelContainer();

        public void DontShowKitItemTipAgain()
        {
            var currentPrepper = BpFunctions.GetCurrentPrepper(User);
            if (currentPrepper == null) throw new Exception("Cannot find Prepper");

            var db = new BP_ModelContainer();
            var prepper = db.Preppers.Find(currentPrepper.Id);
            if (prepper == null) throw new Exception("Cannot find Prepper");

            prepper.ShowTipKitItems = false;
            db.SaveChanges();
        }
        
        public void ChangeStatus(int itemId, int statusId)
        {
            var item = _db.Items.Find(itemId);
            if (item == null) throw new Exception(string.Format("Cannot find item [{0}]", itemId));

            var itemStatus = _db.ItemStatus.Find(statusId);
            if (itemStatus == null) throw new Exception(string.Format("Cannot find Item Status [{0}]", statusId));

            if (itemStatus.Name.Equals(BpFunctions.ItemStatuses.Positioned.ToString(), StringComparison.InvariantCultureIgnoreCase))
            {
                if (item.SampleItemId != null)
                {
                    var sampleItem = _db.SampleItems.Find(item.SampleItemId);
                    if (sampleItem != null && sampleItem.DaysShelfLife > 0)
                        item.ReplaceBy = DateTime.Today.AddDays(sampleItem.DaysShelfLife);
                }
            }
            else
                item.ReplaceBy = null;

            item.ItemStatusId = statusId;
            _db.SaveChanges();
        }

        public void UpdateItem(int itemId, int quantity, int daysWarning, int replaceByYear, int replaceByMonth, int replaceByDay)
        {
            var item = _db.Items.Find(itemId);
            if(item==null)throw new Exception(string.Format("Cannot find Item [{0}]", itemId));

            item.Quantity = quantity;
            item.DaysWarningOfReplacement = daysWarning;
            if (replaceByYear > 0)
            {
                var replaceBy = new DateTime(replaceByYear, replaceByMonth, replaceByDay);
                item.ReplaceBy = replaceBy;
            }
            else
            {
                if (item.DaysWarningOfReplacement > 0)
                    item.ReplaceBy = DateTime.Today.AddDays(item.DaysWarningOfReplacement + 1);
            }
            _db.SaveChanges();
        }

        public string GetItems(int kitId)
        {
            var builder = new StringBuilder();
            var items = (from i in _db.Items where i.KitId == kitId select i).ToList();
            foreach (var item in items)
            {
                //Status html
                var statusHtml = "";
                foreach (var status in _db.ItemStatus.ToList().OrderBy(i => i.Id))
                {
                    if (statusHtml.Length > 0) statusHtml += "|";
                    if (status.Id != item.ItemStatusId)
                        statusHtml += @"<a class='KitItemAction' onClick='ChangeStatus(" + item.Id + "," + status.Id + ")' class='statusChange'>" + status.Name + "</a>";
                    else
                        statusHtml += "<b>" + status.Name + "</b>";
                }

                //ReplaceBy
                var replaceby = "";
                if (item.ReplaceBy != null)
                    replaceby = ((DateTime)item.ReplaceBy).ToString("dd/MMM/yyyy");

                //Actions
                var replaceBy = 0;
                if(item.ReplaceBy!=null)
                {
                    var dtReplaceBy = (DateTime) item.ReplaceBy;
                    replaceBy = (dtReplaceBy.Year*10000) + (dtReplaceBy.Month*100) + dtReplaceBy.Day;
                }
                var actionHtml = string.Format("<a class='KitItemAction' onClick='EditItem({0},\"{1}\",{2},{3},{4});'>edit</a>&nbsp<a class='KitItemAction' onClick='DeleteItem({0}, \"{1}\");'>delete</a>", item.Id, item.Name, item.Quantity, replaceBy, item.DaysWarningOfReplacement);

                //Row html
                builder.Append("<tr>");
                if (item.SampleItemId == null)
                    builder.Append("<td><div>");
                else
                {
                    var sampleItem = _db.SampleItems.Find(item.SampleItemId);
                    if(sampleItem==null)throw new Exception(string.Format("Cannot find SampleItem [{0}]", item.SampleItemId));

                    builder.Append(string.Format("<td><div title='{0}'>", sampleItem.Description));
                }
                builder.Append(item.Name);
                builder.Append("</div></td>");
                builder.Append("<td>");
                builder.Append(item.Quantity);
                builder.Append("</td>");
                builder.Append("<td>");
                builder.Append(replaceby);
                builder.Append("</td>");
                builder.Append("<td>");
                builder.Append(item.DaysWarningOfReplacement);
                builder.Append("</td>");
                builder.Append("<td>");
                builder.Append(statusHtml);
                builder.Append("</td>");
                builder.Append("<td>");
                builder.Append(actionHtml);
                builder.Append("</td>");
                builder.Append("</tr>");
            }

            return builder.ToString();
        }
        // GET: /Item/
        public ActionResult Index(int? id)
        {
            if (id == null)
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);

            //Kit
            var kit = _db.Kits.Find(id);
            if (kit == null) throw new Exception(string.Format("Cannot find Kit [{0}]", id));
            ViewBag.Kit = kit;

            //Ads
            ViewBag.Ads = GetAds((int) id);

            var currentPrepper = BpFunctions.GetCurrentPrepper(User);
            return View(currentPrepper);
        }

        private List<string> GetAds(int kitId)
        {
            var kit = _db.Kits.Find(kitId);
            if (kit == null) throw new Exception(string.Format("Cannot find Kit [{0}]", kitId));

            var plannedSampleItemsWithAd = new List<SampleItem>();
            var otherSampleItemsWithAd = new List<SampleItem>();
            var items = (from i in kit.Items where i.SampleItemId != null select i).ToList();

            //Planned Items
            foreach (var item in items)
            {
                if (item.ItemStatus.Name.Equals("Planned", StringComparison.InvariantCultureIgnoreCase))
                {
                    var sampleItem = _db.SampleItems.Find(item.SampleItemId);
                    if (sampleItem.AmazonWidget != null)
                        plannedSampleItemsWithAd.Add(sampleItem);
                }
            }

            //Have we enough?
            var val = BpFunctions.GetParameterValue(BpFunctions.ParameterName.TotalAdsOnScreen);
            int totalAdsOnScreen;
            if(!int.TryParse(val,out totalAdsOnScreen))
                throw new Exception("Invalid value for TotalAdsOnScreen");
            if (plannedSampleItemsWithAd.Count < totalAdsOnScreen)
            {
                //Get all OTHER sample items with Ads
                otherSampleItemsWithAd = (from si in _db.SampleItems where si.AmazonWidget!=null select si).ToList();
                foreach (var item in plannedSampleItemsWithAd)
                    otherSampleItemsWithAd.Remove(item);
            }

            //Randomise planned & other lists to final ad list
            var shuffledPlannedSampleItemsWithAd = plannedSampleItemsWithAd.OrderBy(a => Guid.NewGuid()).ToList();
            var shuffledOtherSampleItemsWithAd = otherSampleItemsWithAd.OrderBy(a => Guid.NewGuid()).ToList();

            //Form one list
            var finalList = shuffledPlannedSampleItemsWithAd.Select(item => item.AmazonWidget).ToList();
            finalList.AddRange(shuffledOtherSampleItemsWithAd.Select(i => i.AmazonWidget).ToList());

            return finalList.Count <= totalAdsOnScreen ? finalList : finalList.GetRange(0, totalAdsOnScreen);
        }

        // GET: /Item/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);

            Item item = _db.Items.Find(id);
            if (item == null)
            {
                return HttpNotFound();
            }
            return View(item);
        }

        // GET: /Item/Create
        public ActionResult Create()
        {
            ViewBag.KitId = new SelectList(_db.Kits, "Id", "Name");
            return View();
        }

        // POST: /Item/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id,Name,ReplaceBy,DaysWarningOfReplacement,KitId")] Item item)
        {
            if (ModelState.IsValid)
            {
                var itemStatus = (from s in _db.ItemStatus orderby s.Id ascending select s).FirstOrDefault();
                if (itemStatus == null) throw new Exception("Cannot find default item status");
                item.ItemStatusId = itemStatus.Id;

                _db.Items.Add(item);
                _db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.KitId = new SelectList(_db.Kits, "Id", "Name", item.KitId);
            return View(item);
        }

        //// GET: /Item/Edit/5
        //public ActionResult Edit(int? id)
        //{
        //    if (id == null)
        //    {
        //        return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
        //    }
        //    Item item = _db.Items.Find(id);
        //    if (item == null)
        //    {
        //        return HttpNotFound();
        //    }
        //    ViewBag.KitId = new SelectList(_db.Kits, "Id", "Name", item.KitId);
        //    return View(item);
        //}

        //// POST: /Item/Edit/5
        //// To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        //// more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        //[HttpPost]
        //[ValidateAntiForgeryToken]
        //public ActionResult Edit([Bind(Include = "Id,Name,ReplaceBy,DaysWarningOfReplacement,KitId")] Item item)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        if (item.ReplaceBy == null && item.DaysWarningOfReplacement > 0)
        //            item.ReplaceBy = DateTime.Today.AddDays(item.DaysWarningOfReplacement + 1);

        //        _db.Entry(item).State = EntityState.Modified;
        //        _db.SaveChanges();
        //        return RedirectToAction("Index");
        //    }
        //    ViewBag.KitId = new SelectList(_db.Kits, "Id", "Name", item.KitId);
        //    return View(item);
        //}

        public void DeleteItem(int itemId)
        {
            var item = _db.Items.Find(itemId);
            if (item == null) throw new Exception(string.Format("Cannot find Item [{0}]", itemId));

            _db.Items.Remove(item);
            _db.SaveChanges();
        }

        // GET: /Item/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Item item = _db.Items.Find(id);
            if (item == null)
            {
                return HttpNotFound();
            }
            return View(item);
        }

        // POST: /Item/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Item item = _db.Items.Find(id);
            _db.Items.Remove(item);
            _db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                _db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
