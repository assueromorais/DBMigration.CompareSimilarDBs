using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using DBMigration.CompareSimilarDBs.Data;
using Microsoft.Extensions.Configuration;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace Micracao.ComparadorBasesLegadas.Controllers
{
    public class BaseLegadaGruposController : Controller
    {
        private readonly DBMigrationCompareSimilarDBsContext _context;
        IConfiguration configuration;

        public BaseLegadaGruposController(DBMigrationCompareSimilarDBsContext context, IConfiguration configuration)
        {
            _context = context;
            this.configuration = configuration;
        }

        // GET: BaseLegadas
        public async Task<IActionResult> Index()
        {
            return View(await _context.BaseLegadaGrupos.OrderByDescending(bl => bl.NomeGrupo).ToListAsync());
        }

        // GET: BaseLegadas/Details/5
        public async Task<IActionResult> Details(long? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var baseLegadaGrupo = await _context.BaseLegadaGrupos.FirstOrDefaultAsync(m => m.Id == id);
            if (baseLegadaGrupo == null)
            {
                return NotFound();
            }

            return View(baseLegadaGrupo);
        }

        // GET: BaseLegadas/Create
        public IActionResult Create()
        {
            ViewData["StatusMigracao"] = new SelectList(_context.StatusMigracaos, "Id", "Nome");
            return View();
        }

        // POST: BaseLegadas/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("NomeGrupo,ConnectionStringLegadas,PrefixoNomeBaseLegadas,RegexNomeTabelasDescartar")] BaseLegadaGrupo baseLegadaGrupo)
        {
            if (ModelState.IsValid)
            {
                _context.Add(baseLegadaGrupo);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(baseLegadaGrupo);
        }

        // GET: BaseLegadas/Edit/5
        public async Task<IActionResult> Edit(long? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var baseLegadaGrupo = await _context.BaseLegadaGrupos.FindAsync(id);
            if (baseLegadaGrupo == null)
            {
                return NotFound();
            }
            ViewData["StatusMigracao"] = new SelectList(_context.StatusMigracaos, "Id", "Nome");
            return View(baseLegadaGrupo);
        }

        // POST: BaseLegadas/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(long id, [Bind("Id, NomeGrupo,ConnectionStringLegadas,PrefixoNomeBaseLegadas,RegexNomeTabelasDescartar")] BaseLegadaGrupo baseLegadaGrupoView)
        {
            if (id != baseLegadaGrupoView.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    BaseLegadaGrupo baseLegadaGrupo = _context.BaseLegadaGrupos.Find(id);
                    baseLegadaGrupo.NomeGrupo= baseLegadaGrupoView.NomeGrupo;
                    baseLegadaGrupo.PrefixoNomeBaseLegadas = baseLegadaGrupoView.PrefixoNomeBaseLegadas;
                    baseLegadaGrupo.RegexNomeTabelasDescartar = baseLegadaGrupoView.RegexNomeTabelasDescartar;
                    baseLegadaGrupo.ConnectionStringLegadas = baseLegadaGrupoView.ConnectionStringLegadas;
                    _context.Update(baseLegadaGrupo);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!BaseLegadaExists(baseLegadaGrupoView.Id))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            return View(baseLegadaGrupoView);
        }

        // GET: BaseLegadas/Delete/5
        public async Task<IActionResult> Delete(long? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var baseLegada = await _context.BaseLegadaGrupos.FirstOrDefaultAsync(m => m.Id == id);
            if (baseLegada == null)
            {
                return NotFound();
            }
            ViewData["PossuiBases"] = _context.BaseLegada.Count(cb => cb.BaseLegadaGrupo == id);
            return View(baseLegada);
        }

        // POST: BaseLegadas/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(long id)
        {
            var baseLegada = await _context.BaseLegadaGrupos.FindAsync(id);
            _context.BaseLegadaGrupos.Remove(baseLegada);
            await _context.SaveChangesAsync();
            TempData["MensagemSucesso"] = "Grupo excluído com sucesso!";
            return RedirectToAction(nameof(Index));
        }

        private bool BaseLegadaExists(long id)
        {
            return _context.BaseLegadaGrupos.Any(e => e.Id == id);
        }
    }
}
