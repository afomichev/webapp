﻿using System;
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
    public class ClientsController : Controller
    {
        private BanksFOSystemEntities1 db = new BanksFOSystemEntities1();

        // GET: /Clients/
        public ActionResult Index()
        {
            var bs_clients = db.bs_Clients.Include(b => b.bs_SectorBank).Include(b => b.bs_SectorOKVED);
            return View(bs_clients.ToList());
        }

        // GET: /Clients/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            bs_Clients bs_clients = db.bs_Clients.Find(id);
            if (bs_clients == null)
            {
                return HttpNotFound();
            }
            return View(bs_clients);
        }

        // GET: /Clients/Create
        public ActionResult Create()
        {
            ViewBag.SectorBankID = new SelectList(db.bs_SectorBank, "SectorBankID", "SectorBankName");
            ViewBag.SectorOKVEDID = new SelectList(db.bs_SectorOKVED, "SectorOKVEDID", "SectorOKVEDName");
            return View();
        }

        // POST: /Clients/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="ClientID,Name,Address,PrimaryContact,CountryOfRiskID,GICSSubIndustryID,SectorBankID,SectorOKVEDID,CategoryID")] bs_Clients bs_clients)
        {
            if (ModelState.IsValid)
            {
                db.bs_Clients.Add(bs_clients);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.SectorBankID = new SelectList(db.bs_SectorBank, "SectorBankID", "SectorBankName", bs_clients.SectorBankID);
            ViewBag.SectorOKVEDID = new SelectList(db.bs_SectorOKVED, "SectorOKVEDID", "SectorOKVEDName", bs_clients.SectorOKVEDID);
            return View(bs_clients);
        }

        // GET: /Clients/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            bs_Clients bs_clients = db.bs_Clients.Find(id);
            if (bs_clients == null)
            {
                return HttpNotFound();
            }
            ViewBag.SectorBankID = new SelectList(db.bs_SectorBank, "SectorBankID", "SectorBankName", bs_clients.SectorBankID);
            ViewBag.SectorOKVEDID = new SelectList(db.bs_SectorOKVED, "SectorOKVEDID", "SectorOKVEDName", bs_clients.SectorOKVEDID);
            return View(bs_clients);
        }

        // POST: /Clients/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="ClientID,Name,Address,PrimaryContact,CountryOfRiskID,GICSSubIndustryID,SectorBankID,SectorOKVEDID,CategoryID")] bs_Clients bs_clients)
        {
            if (ModelState.IsValid)
            {
                db.Entry(bs_clients).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.SectorBankID = new SelectList(db.bs_SectorBank, "SectorBankID", "SectorBankName", bs_clients.SectorBankID);
            ViewBag.SectorOKVEDID = new SelectList(db.bs_SectorOKVED, "SectorOKVEDID", "SectorOKVEDName", bs_clients.SectorOKVEDID);
            return View(bs_clients);
        }

        // GET: /Clients/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            bs_Clients bs_clients = db.bs_Clients.Find(id);
            if (bs_clients == null)
            {
                return HttpNotFound();
            }
            return View(bs_clients);
        }

        // POST: /Clients/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            bs_Clients bs_clients = db.bs_Clients.Find(id);
            db.bs_Clients.Remove(bs_clients);
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
