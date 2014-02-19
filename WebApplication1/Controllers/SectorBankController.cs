using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using WebApplication1;

namespace WebApplication1.Controllers
{
    public class SectorBankController : Controller
    {
        private ActivitiesEntities db = new ActivitiesEntities();

        // GET: /SectorBank/
        public ActionResult Index()
        {
            return View(db.bs_SectorBank.ToList());
        }

        // GET: /SectorBank/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Sector_Bank sector_bank = db.bs_SectorBank.Find(id);
            if (sector_bank == null)
            {
                return HttpNotFound();
            }
            return View(sector_bank);
        }

        // GET: /SectorBank/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: /SectorBank/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="SectorBankID,SectorBankName,GICSSubindustryID,SectorOKVEDID")] Sector_Bank sector_bank)
        {
            if (ModelState.IsValid)
            {
                db.bs_SectorBank.Add(sector_bank);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(sector_bank);
        }

        // GET: /SectorBank/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Sector_Bank sector_bank = db.bs_SectorBank.Find(id);
            if (sector_bank == null)
            {
                return HttpNotFound();
            }
            return View(sector_bank);
        }

        // POST: /SectorBank/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="SectorBankID,SectorBankName,GICSSubindustryID,SectorOKVEDID")] Sector_Bank sector_bank)
        {
            if (ModelState.IsValid)
            {
                db.Entry(sector_bank).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(sector_bank);
        }

        // GET: /SectorBank/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Sector_Bank sector_bank = db.bs_SectorBank.Find(id);
            if (sector_bank == null)
            {
                return HttpNotFound();
            }
            return View(sector_bank);
        }

        // POST: /SectorBank/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Sector_Bank sector_bank = db.bs_SectorBank.Find(id);
            db.bs_SectorBank.Remove(sector_bank);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
