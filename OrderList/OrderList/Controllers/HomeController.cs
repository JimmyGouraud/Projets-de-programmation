using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using OrderList.Models;

namespace OrderList.Controllers
{
	public class HomeController : Controller
	{
		private readonly ILogger<HomeController> _logger;

		public HomeController(ILogger<HomeController> logger)
		{
			_logger = logger;
		}

		public IActionResult Index()
		{
			var orderList = CreateOrderList();

			var perm = GetPermutations(orderList, orderList.Count);

			var result = perm.Select(p => p.Select(p1 => p1.Price).Sum()).ToList();//.Where(p => p == 28.26);
			return View();
		}

		public IActionResult Privacy()
		{
			return View();
		}

		[ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
		public IActionResult Error()
		{
			return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
		}

		static IEnumerable<IEnumerable<T>>
			GetPermutations<T>(IEnumerable<T> list, int length)
		{
			if (length == 1) return list.Select(t => new T[] { t });
			return GetPermutations(list, length - 1)
				.SelectMany(t => list.Where(o => !t.Contains(o)),
					(t1, t2) => t1.Concat(new T[] { t2 }));
		}

		private List<Product> CreateOrderList()
		{
			var products = new List<Product>() {
				new Product() { Name = "*LA LAIT. PPC VANILL", Price = 2.89F },
				new Product() { Name = "CAROTTE 1,5KG MMP", Price = 1.99F },
				new Product() { Name = "BOUTON OR CROUT.AIL&", Price = 0.62f },
				new Product() { Name = "BOUTON OR CROUT.AIL&", Price = 0.62f },
				new Product() { Name = "CERISE BARQUETTE 750", Price = 5.49f },
				new Product() { Name = "KERCAD MOELLEUX AUTH", Price = 2.58f },
				new Product() { Name = "SUN TABS LAVE VSL CL" , Price = 6.87f },
				new Product() { Name = "IDS PJ POMME BOCAL 1", Price = 1.95f },
				new Product() { Name = "DELACRE DELICHOC CHO", Price = 1.30f },
				new Product() { Name = "VOLVIC JUICY CITRONNN", Price = 1.18f },
				new Product() { Name = "V. VERTE PUR JUS RAIS", Price = 2.25f },
				new Product() { Name = "ELOI HV EF COUPE BIO", Price = 1.95f },
				new Product() { Name = "SELOI ASPRG POINTE 1", Price = 1.86f },
				new Product() { Name = "SELOI ASPRG POINTE 1", Price = 1.86f },
				new Product() { Name = "TEISSEIRE GRENADINE", Price = 1.99f },
				new Product() { Name = "ST ELOI MACEDOINE LE", Price = 0.95f },
				new Product() { Name = "COCA COLA PET 1.75L", Price = 1.81F },
				new Product() { Name = "IDS BRIOC.TRE.VEND.", Price = 3.78F },
				new Product() { Name = "PAQUITO ABC RAISON B", Price = 1.13F },
				new Product() { Name = "PAQUITO ABC POMME BK", Price = 0.85F },
				new Product() { Name = "NESCAFE 3 EN 1STICKS", Price = 1.97F },
				new Product() { Name = "*DELP.MGRT CDN SO FU", Price = 4.95F },
				new Product() { Name = "*HERTA PATE FLTES T", Price = 2.10F }
			};
			return products;
		}
	}
}
