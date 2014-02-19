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
    public class SectorOKVEDController : Controller
    {
        private BanksFOSystemEntities1 db = new BanksFOSystemEntities1();

        // GET: /SectorOKVED/
        public ActionResult Index()
        {
            return View(db.bs_SectorOKVED.ToList());
        }

        // GET: /SectorOKVED/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            bs_SectorOKVED bs_sectorokved = db.bs_SectorOKVED.Find(id);
            if (bs_sectorokved == null)
            {
                return HttpNotFound();
            }
            return View(bs_sectorokved);
        }

        // GET: /SectorOKVED/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: /SectorOKVED/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="SectorOKVEDID,SectorOKVEDName")] bs_SectorOKVED bs_sectorokved)
        {
            if (ModelState.IsValid)
            {
                db.bs_SectorOKVED.Add(bs_sectorokved);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(bs_sectorokved);
        }

        // GET: /SectorOKVED/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            bs_SectorOKVED bs_sectorokved = db.bs_SectorOKVED.Find(id);
            if (bs_sectorokved == null)
            {
                return HttpNotFound();
            }
            return View(bs_sectorokved);
        }

        // POST: /SectorOKVED/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="SectorOKVEDID,SectorOKVEDName")] bs_SectorOKVED bs_sectorokved)
        {
            if (ModelState.IsValid)
            {
                db.Entry(bs_sectorokved).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(bs_sectorokved);
        }

        // GET: /SectorOKVED/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            bs_SectorOKVED bs_sectorokved = db.bs_SectorOKVED.Find(id);
            if (bs_sectorokved == null)
            {
                return HttpNotFound();
            }
            return View(bs_sectorokved);
        }

        // POST: /SectorOKVED/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            bs_SectorOKVED bs_sectorokved = db.bs_SectorOKVED.Find(id);
            db.bs_SectorOKVED.Remove(bs_sectorokved);
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
