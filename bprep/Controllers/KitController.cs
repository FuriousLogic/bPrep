using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data;
using System.Data.Entity;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;
using BPrep_BL.Model;
using Microsoft.Owin.Security;

namespace BPrep.Controllers
{
    [Authorize]
    public class KitController : Controller
    {
        //private readonly BP_ModelContainer db = new BP_ModelContainer();

        public string Test()
        {
            return "<tr><td>Uno</td><td>Dos</td></tr>";
        }

        public void DontShowKitTipAgain()
        {
            var currentPrepper = BpFunctions.GetCurrentPrepper(User);
            if(currentPrepper==null)throw new Exception("Cannot find Prepper");

            var db = new BP_ModelContainer();
            var prepper = db.Preppers.Find(currentPrepper.Id);
            if (prepper == null) throw new Exception("Cannot find Prepper");

            prepper.ShowTipKit = false;
            db.SaveChanges();
        }

        public string GetKits()
        {
            var db = new BP_ModelContainer();
            var prepperName = User.Identity.Name;
            var prepper = (from p in db.Preppers where p.Name == prepperName select p).FirstOrDefault();
            if (prepper == null) throw new Exception("Cannot find Prepper");

            var kits = (from k in db.Kits where k.PrepperId==prepper.Id select k).ToList();

            var builder = new StringBuilder();
            foreach (var kit in kits)
            {
                builder.Append("<tr>");
                builder.Append("<td>");
                builder.Append(kit.Name);
                builder.Append("</td>");
                builder.Append("<td>");
                builder.Append(kit.Location);
                builder.Append("</td>");
                builder.Append(string.Format("<td><a href='/Item/Index/{0}'>edit</a></td>", kit.Id));
                builder.Append("</tr>");
            }
            var html = builder.ToString();
            return html;
        }

        public void AddKit(string name, string location, int sampleKitId)
        {
            try
            {
                var db = new BP_ModelContainer();
                var prepper = (from p in db.Preppers where p.Name == User.Identity.Name select p).FirstOrDefault();
                if (prepper == null) throw new Exception(string.Format("Cannot find Prepper [{0}]", User.Identity.Name));

                var kit = new Kit
                {
                    Name = name,
                    Location = location,
                    PrepperId = prepper.Id
                };

                if (sampleKitId > 0)
                {
                    var status = (from s in db.ItemStatus where s.Name.Equals("planned", StringComparison.InvariantCultureIgnoreCase) select s).FirstOrDefault();
                    if (status == null) throw new Exception("Cannot find Status");

                    var sampleItems = (from si in db.SampleItems where si.SampleKitId == sampleKitId select si).ToList();
                    foreach (var sampleItem in sampleItems)
                    {
                        kit.Items.Add(new Item
                        {
                            ItemStatusId = status.Id,
                            Name = sampleItem.Name,
                            DaysWarningOfReplacement = sampleItem.DaysWarningOfReplacement,
                            Quantity = sampleItem.Quantity,
                            SampleItemId = sampleItem.Id
                        });
                    }
                }

                db.Kits.Add(kit);
                db.SaveChanges();
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
            }
        }

        // GET: /Kit/
        public ActionResult Index()
        {
            var db = new BP_ModelContainer();
            ViewBag.SampleKits = db.SampleKits.ToList();

            var currentPrepper = BpFunctions.GetCurrentPrepper(User);
            return View(currentPrepper);
        }

        // GET: /Kit/Create
        public ActionResult Create()
        {
            var db = new BP_ModelContainer();
            var sampleKits = db.SampleKits.ToList();
            ViewBag.SampleKits = sampleKits;
            return View();
        }

        // POST: /Kit/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id,Name,Location,PrepperId")] Kit kit)
        {
            var db = new BP_ModelContainer();
            if (ModelState.IsValid)
            {
                var prepper = BpFunctions.GetCurrentPrepper(User);
                kit.PrepperId = prepper.Id;

                db.Kits.Add(kit);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.PrepperId = new SelectList(db.Preppers, "Id", "Name", kit.PrepperId);
            return View(kit);
        }

        // GET: /Kit/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            var db = new BP_ModelContainer();
            Kit kit = db.Kits.Find(id);
            if (kit == null)
            {
                return HttpNotFound();
            }
            ViewBag.PrepperId = new SelectList(db.Preppers, "Id", "Name", kit.PrepperId);
            return View(kit);
        }

        // POST: /Kit/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id,Name,Location,PrepperId")] Kit kit)
        {
            var db = new BP_ModelContainer();
            if (ModelState.IsValid)
            {
                db.Entry(kit).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.PrepperId = new SelectList(db.Preppers, "Id", "Name", kit.PrepperId);
            return View(kit);
        }

        // GET: /Kit/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            var db = new BP_ModelContainer();
            Kit kit = db.Kits.Find(id);
            if (kit == null)
            {
                return HttpNotFound();
            }
            return View(kit);
        }

        // POST: /Kit/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            var db = new BP_ModelContainer();
            Kit kit = db.Kits.Find(id);
            db.Kits.Remove(kit);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                //db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
