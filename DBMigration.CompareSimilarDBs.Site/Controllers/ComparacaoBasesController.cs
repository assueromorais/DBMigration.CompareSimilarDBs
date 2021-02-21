using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using DBMigration.CompareSimilarDBs.Data;
using System;
using Microsoft.Extensions.Configuration;
using System.Threading;
using Micracao.ComparadorBasesLegadas.Helpers;
using ClosedXML.Excel;
using System.Collections.Generic;

namespace Micracao.ComparadorBasesLegadas.Controllers
{
    public class ComparacaoBasesController : Controller
    {
        DBMigrationCompareSimilarDBsContext _context;
        IConfiguration configuration;

        public ComparacaoBasesController(DBMigrationCompareSimilarDBsContext context, IConfiguration configuration)
        {
            context.Database.SetCommandTimeout(6000);
            _context = context;
            this.configuration = configuration;
        }

        // GET: ComparacaoBases
        public async Task<IActionResult> Index(string sortOrder)
        {

            ViewBag.FonteSortParm = sortOrder == "fonte" ? "fonte_desc" : "fonte";
            ViewBag.AlvoSortParm = sortOrder == "alvo" ? "alvo_desc" : "alvo";
            ViewBag.StatusSortParm = sortOrder == "status" ? "status_desc" : "status";
            var comparacaoBases = await _context.ComparacaoBases.Include(c => c.BaseAlvoNavigation).Include(c => c.BaseFonteNavigation).ToListAsync();
            ViewBag.TotalNaoIniciada = comparacaoBases.Where(cb => cb.StatusComparacao == StatusComparacao.NaoIniciada).Count();
            ViewBag.TotalEmAndamento = comparacaoBases.Where(cb => cb.StatusComparacao == StatusComparacao.EmAndamento).Count();
            ViewBag.TotalSucesso = comparacaoBases.Where(cb => cb.StatusComparacao == StatusComparacao.Concluida).Count();
            ViewBag.TotalFalha = comparacaoBases.Where(cb => cb.StatusComparacao == StatusComparacao.Falha).Count();
            switch (sortOrder)
            {
                case "fonte":
                    comparacaoBases = comparacaoBases.OrderBy(cb => cb.BaseFonteNavigation.Nome).ToList();
                    break;
                case "fonte_desc":
                    comparacaoBases = comparacaoBases.OrderByDescending(cb => cb.BaseFonteNavigation.Nome).ToList();
                    break;
                case "status":
                    comparacaoBases = comparacaoBases.OrderBy(cb => cb.StatusComparacao).ToList();
                    break;
                case "status_desc":
                    comparacaoBases = comparacaoBases.OrderByDescending(cb => cb.StatusComparacao).ToList();
                    break;
                case "alvo_desc":
                    comparacaoBases = comparacaoBases.OrderByDescending(cb => cb.BaseAlvoNavigation.Nome).ToList();
                    break;
                default:
                    comparacaoBases = comparacaoBases.OrderBy(bl => bl.BaseAlvoNavigation.Nome).ToList();
                    break;
            }
            //// Trecho abaixo limpa comparações quebradas, ou seja, que iniciaram à mais de 2 horas e ainda estão em andamento.
            //Parallel.Invoke(() =>
            //{
            //    var comparacoesQuebradas = _context.ComparacaoBases.Where(cb => (cb.DataComparacao - DateTime.Now).TotalHours > 2 && cb.StatusComparacao == StatusComparacao.EmAndamento).ToList();
            //    _context.ComparacaoBases.RemoveRange(comparacoesQuebradas);
            //    _context.SaveChanges();
            //});
            return View("Index", comparacaoBases);
        }

        // GET: ComparacaoBases/Details/5
        public async Task<IActionResult> Details(long? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var comparacaoBases = await _context.ComparacaoBases
                .Include(c => c.BaseAlvoNavigation)
                .Include(c => c.BaseFonteNavigation)
                .FirstOrDefaultAsync(m => m.Id == id);
            if (comparacaoBases == null)
            {
                return NotFound();
            }
            CarregarEstatisticasNaViewBag(comparacaoBases.Id);
            return View(comparacaoBases);
        }

        // GET: ComparacaoBases/Create
        public IActionResult Create()
        {
            ViewData["BaseAlvo"] = new SelectList(_context.BaseLegada, "Id", "Nome");
            ViewData["BaseFonte"] = new SelectList(_context.BaseLegada, "Id", "Nome");
            return View();
        }

        // GET: ComparacaoBases/Create
        public async Task<IActionResult> CompareAllCombinations()
        {
            int combinacoesComparacaCount = new ComparadorBasesEmLote(configuration).ExecuteAsync(new CancellationToken());
            if (combinacoesComparacaCount > 0)
                TempData["MensagemSucesso"] = $"Encontrada(s) {combinacoesComparacaCount} combinação(ões), comparações foram criadas e estão em andamento.";
            else
                TempData["MensagemSucesso"] = "Todas as combinações de comparações já foram criadas, se necessário refaça a(s) comparação(ões).";

            return await Index("");
        }

        // POST: ComparacaoBases/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Create([Bind("Id,BaseAlvo,BaseFonte")] ComparacaoBases comparacaoBases)
        {
            if (comparacaoBases.BaseFonte == comparacaoBases.BaseAlvo)
            {
                ModelState.AddModelError("Mesma base", "Você deve informar bases diferentes.");
            }
            else
            {
                var comparacaoBasesJaExistente = _context.ComparacaoBases.FirstOrDefault(cb => (cb.BaseAlvo == comparacaoBases.BaseAlvo && cb.BaseFonte == comparacaoBases.BaseFonte) || (cb.BaseAlvo == comparacaoBases.BaseFonte && cb.BaseFonte == comparacaoBases.BaseAlvo));
                if (comparacaoBasesJaExistente != null)
                {
                    ModelState.AddModelError("Duplicado", "Já existe uma comparação com essa combinação de bases");
                }
                if (_context.BaseLegada.Find(comparacaoBases.BaseAlvo).BaseLegadaGrupo != _context.BaseLegada.Find(comparacaoBases.BaseFonte).BaseLegadaGrupo)
                    ModelState.AddModelError("Grupo diferente", "Bases precisam ser do mesmo grupo.");
            }
            if (ModelState.IsValid)
            {
                comparacaoBases.DataComparacao = DateTime.Now;
                comparacaoBases.StatusComparacao = StatusComparacao.EmAndamento;
                _context.ComparacaoBases.Add(comparacaoBases);
                _context.SaveChanges();
                new ComparadorBases(configuration).ExecuteAsync(new CancellationToken(), comparacaoBases);
                return RedirectToAction(nameof(Index));
            }
            ViewData["BaseAlvo"] = new SelectList(_context.BaseLegada, "Id", "Nome", comparacaoBases.BaseAlvo);
            ViewData["BaseFonte"] = new SelectList(_context.BaseLegada, "Id", "Nome", comparacaoBases.BaseFonte);

            return View(comparacaoBases);
        }

        // GET: BaseLegadas/Create
        public IActionResult RefazerComparacao(long? id)
        {
            ComparacaoBases comparacaoBases = _context.ComparacaoBases.Find(id);
            if (comparacaoBases != null)
            {
                comparacaoBases.StatusComparacao = StatusComparacao.EmAndamento;
                _context.ComparacaoBases.Update(comparacaoBases);
                _context.SaveChanges();
                new ComparadorBases(configuration).ExecuteAsync(new CancellationToken(), comparacaoBases);
            }
            return RedirectToAction(nameof(Index));
        }

        // GET: ComparacaoBases/Edit/5
        public async Task<IActionResult> Edit(long? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var comparacaoBases = await _context.ComparacaoBases.FindAsync(id);
            if (comparacaoBases == null)
            {
                return NotFound();
            }
            ViewData["BaseAlvo"] = new SelectList(_context.BaseLegada, "Id", "Nome", comparacaoBases.BaseAlvo);
            ViewData["BaseFonte"] = new SelectList(_context.BaseLegada, "Id", "Nome", comparacaoBases.BaseFonte);
            return View(comparacaoBases);
        }

        // POST: ComparacaoBases/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(long id, [Bind("Id,BaseAlvo,BaseFonte")] ComparacaoBases comparacaoBases)
        {
            if (id != comparacaoBases.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(comparacaoBases);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!ComparacaoBasesExists(comparacaoBases.Id))
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
            ViewData["BaseAlvo"] = new SelectList(_context.BaseLegada, "Id", "Nome", comparacaoBases.BaseAlvo);
            ViewData["BaseFonte"] = new SelectList(_context.BaseLegada, "Id", "Nome", comparacaoBases.BaseFonte);

            return View(comparacaoBases);
        }

        // GET: ComparacaoBases/Delete/5
        public async Task<IActionResult> Delete(long? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var comparacaoBases = await _context.ComparacaoBases
                .Include(c => c.BaseAlvoNavigation)
                .Include(c => c.BaseFonteNavigation)
                .FirstOrDefaultAsync(m => m.Id == id);
            if (comparacaoBases == null)
            {
                return NotFound();
            }
            return View(comparacaoBases);
        }

        public async Task<IActionResult> GerarRelatorioTabelas(long? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var comparacaoBases = await _context.ComparacaoBases
                .Include(c => c.BaseAlvoNavigation)
                .Include(c => c.BaseFonteNavigation)
                .FirstOrDefaultAsync(m => m.Id == id);
            if (comparacaoBases == null)
            {
                return NotFound();
            }

            System.IO.MemoryStream streamFile = GerarRelatorioComparacaoEmStreamPeloID(id);
            return File(streamFile.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", $"Compara_{comparacaoBases.BaseFonteNavigation.Nome}_{comparacaoBases.BaseAlvoNavigation.Nome}_Tabelas.xlsx");
        }

        private System.IO.MemoryStream GerarRelatorioComparacaoEmStreamPeloID(long? id)
        {
            List<ComparacaoBasesElemento> relatorioTabelas = _context.ComparacaoBasesElementos.Where(cbe => cbe.ComparacaoBases == id && cbe.TipoElemento == 'T'.ToString()).OrderBy(rt => rt.TipoOcorrencia).ToList();
            List<ComparacaoBasesElemento> relatorioColunas = _context.ComparacaoBasesElementos.Where(cbe => cbe.ComparacaoBases == id && cbe.TipoElemento == 'C'.ToString()).Include(cbe => cbe.ElementoPaiNavigation).OrderBy(rt => rt.TipoOcorrencia).ToList();

            var streamFile = new System.IO.MemoryStream();
            using (var workbook = new XLWorkbook())
            {
                var worksheet = workbook.Worksheets.Add("Tabelas");
                worksheet.Cell("A1").Value = "Tabela";
                worksheet.Cell("B1").Value = "Ocorrência";
                worksheet.Cells("A1:B1").Style.Font.SetBold(true);
                for (int i = 0; i < relatorioTabelas.Count; i++)
                {
                    worksheet.Cell($"A{i + 2}").Value = relatorioTabelas[i].Nome;
                    worksheet.Cell($"B{i + 2}").Value = ConvertTipoOcorrenciaParaDescricao(relatorioTabelas[i].TipoOcorrencia);
                }
                worksheet.Cells("A1:B" + relatorioTabelas.Count + 1).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                worksheet = workbook.Worksheets.Add("Colunas");
                worksheet.Cell("A1").Value = "Tabela";
                worksheet.Cell("B1").Value = "Campo";
                worksheet.Cell("C1").Value = "Ocorrência";
                worksheet.Cells("A1:C1").Style.Font.SetBold(true);
                for (int i = 0; i < relatorioColunas.Count; i++)
                {
                    worksheet.Cell($"A{i + 2}").Value = relatorioColunas[i].ElementoPaiNavigation.Nome;
                    worksheet.Cell($"B{i + 2}").Value = relatorioColunas[i].Nome;
                    worksheet.Cell($"C{i + 2}").Value = ConvertTipoOcorrenciaParaDescricao(relatorioColunas[i].TipoOcorrencia);
                }
                worksheet.Cells("A1:C" + relatorioColunas.Count + 1).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                workbook.SaveAs(streamFile);
            }
            return streamFile;
        }

        private string ConvertTipoOcorrenciaParaDescricao(string tipoOcorrencia)
        {
            switch (tipoOcorrencia)
            {
                case "A":
                    return "Alterada";
                case "E":
                    return "Nova";
                case "I":
                    return "Inexistente";
            }
            return null;
        }

        private void CarregarEstatisticasNaViewBag(long comparacaoBasesId)
        {
            var agrupadoTabelasOcorrencias = _context.ComparacaoBasesElementos.Where(cbe => cbe.ComparacaoBases == comparacaoBasesId).GroupBy(cbe => new { cbe.TipoOcorrencia, cbe.TipoElemento }).Select(cbe => new { Ocorrencia = cbe.Key.TipoOcorrencia, TipoElemento = cbe.Key.TipoElemento, Total = cbe.Count() });
            var agrupadoTabelas = agrupadoTabelasOcorrencias.Where(cbe => cbe.TipoElemento == "T");
            var agrupadoColunas = agrupadoTabelasOcorrencias.Where(cbe => cbe.TipoElemento == "C");
            // Tabelas excluídas = Tabelas que existem na fonte mas não existem na base alvo
            ViewData["TabelasExcluidas"] = agrupadoTabelas.FirstOrDefault(ag => ag.Ocorrencia == "E")?.Total;
            // Tabelas adicionadas = Tabelas que existem no alvo mas não existem na base fonte
            ViewData["TabelasAdicionadas"] = agrupadoTabelas.FirstOrDefault(ag => ag.Ocorrencia == "I")?.Total;
            // Tabelas alteradas = Tabelas possuem diferença de colunas (colunas excluídas ou adicionadas)
            ViewData["TabelasAlteradas"] = agrupadoTabelas.FirstOrDefault(ag => ag.Ocorrencia == "A")?.Total;
            // Colunas excluídas = colunas que existem na fonte mas não na base alvos
            ViewData["ColunasExcluidas"] = agrupadoColunas.FirstOrDefault(ag => ag.Ocorrencia == "E")?.Total;
            // Colunas adicionadas = colunas que existem no alvofonte mas não na base fonte
            ViewData["ColunasAdicionadas"] = agrupadoColunas.FirstOrDefault(ag => ag.Ocorrencia == "I")?.Total;
        }

        // POST: ComparacaoBases/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(long id)
        {
            var comparacaoBases = await _context.ComparacaoBases.FindAsync(id);
            _context.ComparacaoBasesElementos.RemoveRange(_context.ComparacaoBasesElementos.Where(cbe => cbe.ComparacaoBases == id).ToList());
            _context.ComparacaoBases.Remove(comparacaoBases);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool ComparacaoBasesExists(long id)
        {
            return _context.ComparacaoBases.Any(e => e.Id == id);
        }
    }
}
