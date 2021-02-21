using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using DBMigration.CompareSimilarDBs.Data;

namespace Micracao.ComparadorBasesLegadas.Controllers
{
    public class ComparacaoBasesElementoesController : Controller
    {
        private readonly DBMigrationCompareSimilarDBsContext _context;

        public ComparacaoBasesElementoesController(DBMigrationCompareSimilarDBsContext context)
        {
            _context = context;
        }

        // GET: ComparacaoBasesElementoes
        public async Task<IActionResult> Index()
        {
            var MigracaoComparadorBasesLegadasContext = _context.ComparacaoBasesElementos.Include(c => c.ComparacaoBasesNavigation).Include(c => c.ElementoPaiNavigation);
            return View(await MigracaoComparadorBasesLegadasContext.ToListAsync());
        }

        // GET: ComparacaoBasesElementoes/Details/5
        public async Task<IActionResult> Details(decimal? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var comparacaoBasesElemento = await _context.ComparacaoBasesElementos
                .Include(c => c.ComparacaoBasesNavigation)
                .Include(c => c.ElementoPaiNavigation)
                .FirstOrDefaultAsync(m => m.Id == id);
            if (comparacaoBasesElemento == null)
            {
                return NotFound();
            }

            return View(comparacaoBasesElemento);
        }

        // GET: ComparacaoBasesElementoes/Create
        public IActionResult Create()
        {
            ViewData["ComparacaoBases"] = new SelectList(_context.ComparacaoBases, "Id", "Id");
            ViewData["ElementoPai"] = new SelectList(_context.ComparacaoBasesElementos, "Id", "TipoElemento");
            return View();
        }

        // POST: ComparacaoBasesElementoes/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Id,TipoElemento,TipoOcorrencia,ElementoPai,ComparacaoBases")] ComparacaoBasesElemento comparacaoBasesElemento)
        {
            if (ModelState.IsValid)
            {
                _context.Add(comparacaoBasesElemento);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["ComparacaoBases"] = new SelectList(_context.ComparacaoBases, "Id", "Id", comparacaoBasesElemento.ComparacaoBases);
            ViewData["ElementoPai"] = new SelectList(_context.ComparacaoBasesElementos, "Id", "TipoElemento", comparacaoBasesElemento.ElementoPai);
            return View(comparacaoBasesElemento);
        }

        // GET: ComparacaoBasesElementoes/Edit/5
        public async Task<IActionResult> Edit(decimal? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var comparacaoBasesElemento = await _context.ComparacaoBasesElementos.FindAsync(id);
            if (comparacaoBasesElemento == null)
            {
                return NotFound();
            }
            ViewData["ComparacaoBases"] = new SelectList(_context.ComparacaoBases, "Id", "Id", comparacaoBasesElemento.ComparacaoBases);
            ViewData["ElementoPai"] = new SelectList(_context.ComparacaoBasesElementos, "Id", "TipoElemento", comparacaoBasesElemento.ElementoPai);
            return View(comparacaoBasesElemento);
        }

        // POST: ComparacaoBasesElementoes/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(decimal id, [Bind("Id,TipoElemento,TipoOcorrencia,ElementoPai,ComparacaoBases")] ComparacaoBasesElemento comparacaoBasesElemento)
        {
            if (id != comparacaoBasesElemento.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(comparacaoBasesElemento);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!ComparacaoBasesElementoExists(comparacaoBasesElemento.Id))
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
            ViewData["ComparacaoBases"] = new SelectList(_context.ComparacaoBases, "Id", "Id", comparacaoBasesElemento.ComparacaoBases);
            ViewData["ElementoPai"] = new SelectList(_context.ComparacaoBasesElementos, "Id", "TipoElemento", comparacaoBasesElemento.ElementoPai);
            return View(comparacaoBasesElemento);
        }

        // GET: ComparacaoBasesElementoes/Delete/5
        public async Task<IActionResult> Delete(decimal? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var comparacaoBasesElemento = await _context.ComparacaoBasesElementos
                .Include(c => c.ComparacaoBasesNavigation)
                .Include(c => c.ElementoPaiNavigation)
                .FirstOrDefaultAsync(m => m.Id == id);
            if (comparacaoBasesElemento == null)
            {
                return NotFound();
            }

            return View(comparacaoBasesElemento);
        }

        // POST: ComparacaoBasesElementoes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(decimal id)
        {
            var comparacaoBasesElemento = await _context.ComparacaoBasesElementos.FindAsync(id);
            _context.ComparacaoBasesElementos.Remove(comparacaoBasesElemento);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool ComparacaoBasesElementoExists(decimal id)
        {
            return _context.ComparacaoBasesElementos.Any(e => e.Id == id);
        }
    }
}
