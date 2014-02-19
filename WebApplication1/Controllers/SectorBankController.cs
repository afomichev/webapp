using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    public class SectorBankController : Controller
    {
        private BanksFOSystemEntities1 db = new BanksFOSystemEntities1();

        // GET: /SectorBank/
        public ActionResult Index()
        {
            var bs_sectorbank = db.bs_SectorBank.Include(b => b.bs_SectorOKVED);
            return View(bs_sectorbank.ToList());
        }

        // GET: /SectorBank/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            bs_SectorBank bs_sectorbank = db.bs_SectorBank.Find(id);
            if (bs_sectorbank == null)
            {
                return HttpNotFound();
            }
            return View(bs_sectorbank);
        }

        // GET: /SectorBank/Create
        public ActionResult Create()
        {
            ViewBag.SectorOKVEDID = new SelectList(db.bs_SectorOKVED, "SectorOKVEDID", "SectorOKVEDName");
            return View();
        }

        // POST: /SectorBank/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="SectorBankID,SectorBankName,GICSSubindustryID,SectorOKVEDID")] bs_SectorBank bs_sectorbank)
        {
            if (ModelState.IsValid)
            {
                db.bs_SectorBank.Add(bs_sectorbank);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.SectorOKVEDID = new SelectList(db.bs_SectorOKVED, "SectorOKVEDID", "SectorOKVEDName", bs_sectorbank.SectorOKVEDID);
            return View(bs_sectorbank);
        }

        // GET: /SectorBank/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            bs_SectorBank bs_sectorbank = db.bs_SectorBank.Find(id);
            if (bs_sectorbank == null)
            {
                return HttpNotFound();
            }
            ViewBag.SectorOKVEDID = new SelectList(db.bs_SectorOKVED, "SectorOKVEDID", "SectorOKVEDName", bs_sectorbank.SectorOKVEDID);
            return View(bs_sectorbank);
        }

        // POST: /SectorBank/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="SectorBankID,SectorBankName,GICSSubindustryID,SectorOKVEDID")] bs_SectorBank bs_sectorbank)
        {
            if (ModelState.IsValid)
            {
                db.Entry(bs_sectorbank).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.SectorOKVEDID = new SelectList(db.bs_SectorOKVED, "SectorOKVEDID", "SectorOKVEDName", bs_sectorbank.SectorOKVEDID);
            return View(bs_sectorbank);
        }

        // GET: /SectorBank/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            bs_SectorBank bs_sectorbank = db.bs_SectorBank.Find(id);
            if (bs_sectorbank == null)
            {
                return HttpNotFound();
            }
            return View(bs_sectorbank);
        }

        // POST: /SectorBank/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            bs_SectorBank bs_sectorbank = db.bs_SectorBank.Find(id);
            db.bs_SectorBank.Remove(bs_sectorbank);
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
