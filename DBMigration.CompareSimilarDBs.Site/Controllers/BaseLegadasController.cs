using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using DBMigration.CompareSimilarDBs.Data;
using System.Collections.Generic;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using Micracao.ComparadorBasesLegadas.Helpers;

namespace Micracao.ComparadorBasesLegadas.Controllers
{
    public class BaseLegadasController : Controller
    {
        private readonly DBMigrationCompareSimilarDBsContext _context;
        readonly IConfiguration configuration;

        public BaseLegadasController(DBMigrationCompareSimilarDBsContext context, IConfiguration configuration)
        {
            _context = context;
            this.configuration = configuration;
        }

        // GET: BaseLegadas
        public async Task<IActionResult> Index()
        {
            var grupoBases = _context.BaseLegadaGrupos.Include(blg => blg.BaseLegada).ToList();
            foreach (BaseLegadaGrupo grupo in grupoBases)
            {
                grupo.BaseLegada = grupo.BaseLegada.OrderBy(bl => bl.StatusMigracao).ThenBy(bl => bl.Nome).ToList();
            }
            return View(grupoBases);
        }

        // GET: BaseLegadas/Details/5
        public async Task<IActionResult> Details(long? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var baseLegada = await _context.BaseLegada.FirstOrDefaultAsync(m => m.Id == id);
            if (baseLegada == null)
            {
                return NotFound();
            }
            ViewBag.TotalComparacoes = _context.ComparacaoBases.Count(cb => cb.BaseAlvo == id || cb.BaseFonte == id);
            return View(baseLegada);
        }

        public object MelhorCorrespondencia(long? id)
        {
            // Efetua contagem das tabelas de cada comparação.
            List<ComparacaoBases> comparacoes = _context.ComparacaoBases.Where(cb => cb.BaseAlvo == id || cb.BaseFonte == id).ToList();
            var comparacaoComMenorQuantidadeDeTabelas = (from cb in comparacoes
                                                         from cbe in _context.ComparacaoBasesElementos
                                                         where cb.Id == cbe.ComparacaoBases
                                                         && cbe.TipoElemento == "T"
                                                         group cb by new { ID = cb.Id, Alvo = cb.BaseAlvo, Fonte = cb.BaseFonte } into grp
                                                         orderby grp.Count()
                                                         select new { Id = grp.Key.ID, grp.Key.Alvo, grp.Key.Fonte, Count = grp.Count() }).FirstOrDefault();
            if (comparacaoComMenorQuantidadeDeTabelas != null)
            {
                long idBaseComparada = comparacaoComMenorQuantidadeDeTabelas.Fonte != id ? comparacaoComMenorQuantidadeDeTabelas.Fonte : comparacaoComMenorQuantidadeDeTabelas.Alvo;
                // Consulta a base com melhor correspondência
                var baseCorrespondente = _context.BaseLegada.Find(idBaseComparada);
                return new { ComparacaoBaseID = comparacaoComMenorQuantidadeDeTabelas.Id, BaseNome = baseCorrespondente.Nome, BaseID = baseCorrespondente.Id };
            }
            else
            {
                return new { ComparacaoBaseID = 0, BaseNome = "", BaseID = 0 };
            }
        }

        // GET: BaseLegadas
        public IActionResult Search()
        {
            _context.BaseLegadaGrupos.ToList().ForEach(blg => BuscarEAtualizarBasesNaoGerenciadasPorGrupo(blg));
            var grupoBases = _context.BaseLegadaGrupos.Include(blg => blg.BaseLegada).ToList();
            foreach (BaseLegadaGrupo grupo in grupoBases)
            {
                grupo.BaseLegada = grupo.BaseLegada.OrderBy(bl => bl.StatusMigracao).ThenBy(bl => bl.Nome).ToList();
            }
            return View("Index", grupoBases);
        }

        // GET: BaseLegadas
        public IActionResult GenDacPacs()
        {
            List<BaseLegada> basesLegadas = _context.BaseLegada.Include(bl => bl.BaseLegadaGrupoNavigation).ToList();
            Parallel.ForEach(basesLegadas, (bn) =>
            {
                new DACPACGerador(configuration).GerarArquivoDacPacDeBase(bn.Nome, bn.BaseLegadaGrupoNavigation.ConnectionStringLegadas);
            });
            TempData["MensagemSucesso"] = $"Geração dos arquivos DACPACs iniciada para as {basesLegadas.Count} bases!";
            return View("Index", _context.BaseLegada.OrderByDescending(bl => bl.StatusMigracao).ThenBy(bl => bl.Nome).ToList());
        }

        private void BuscarEAtualizarBasesNaoGerenciadasPorGrupo(BaseLegadaGrupo grupo)
        {
            var basesGerenciadas = new List<BaseLegada>();
            var basesEncontradas = new List<BaseLegada>();
            var basesEncontradasNaoGerenciadas = new List<BaseLegada>();
            string queryConsultarBasesLegadas = $@"SELECT dt.Name, 
            row_size_mb = CAST(SUM(CASE WHEN type_desc = 'ROWS' THEN size END) * 8. / 1024 AS DECIMAL(8,2)) 
            FROM SYS.DATABASES as dt
            INNER JOIN sys.master_files AS mf ON MF.database_id =  dt.database_id
            WHERE dt.NAME LIKE '{grupo.PrefixoNomeBaseLegadas}%'
            GROUP BY dt.Name, mf.database_id";
            try
            {
                using var connection = new SqlConnection(grupo.ConnectionStringLegadas);
                connection.Open();
                using var command = new SqlCommand(queryConsultarBasesLegadas, connection);
                using SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                    basesEncontradas.Add(new BaseLegada() { Nome = reader.GetString(0), Tamanho = (double)reader.GetDecimal(1), BaseLegadaGrupo = grupo.Id });

                basesGerenciadas = _context.BaseLegada.Where(bl => bl.BaseLegadaGrupo == grupo.Id).ToList();
                basesEncontradasNaoGerenciadas = basesEncontradas.Where(be => !basesGerenciadas.Exists(bg => bg.Nome.Equals(be.Nome))).ToList();

                _context.BaseLegada.AddRange(basesEncontradasNaoGerenciadas.ToArray());
                basesGerenciadas.ForEach(bg =>
                {
                    var baseEncontrada = basesEncontradas.FirstOrDefault(be => be.Nome.Equals(bg.Nome));
                    if (baseEncontrada?.Tamanho > 0)
                        bg.Tamanho = baseEncontrada.Tamanho;
                });
                // Cria o dacpac (arquivo de estrutura do schema do BD).
                Parallel.ForEach(basesEncontradas, (bn) =>
                 {
                     new DACPACGerador(configuration).GerarArquivoDacPacDeBase(bn.Nome, grupo.ConnectionStringLegadas);
                 });
                _context.BaseLegada.UpdateRange(basesGerenciadas.ToArray());
                _context.SaveChanges();
                TempData["MensagemSucesso"] += $"<p>Busca concluída para as bases do grupo {grupo.NomeGrupo}! {basesEncontradasNaoGerenciadas.Count} nova(s) base(s) encontrada(s)!</p>";
            }
            catch (Exception ex)
            {
                TempData["MensagemFalha"] += $"<p>Falha na busca das bases do grupo {grupo.NomeGrupo}! Verifique sua conexão.</p>";
            }
        }

        // GET: BaseLegadas/Edit/5
        public async Task<IActionResult> Edit(long? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var baseLegada = await _context.BaseLegada.FindAsync(id);
            if (baseLegada == null)
            {
                return NotFound();
            }
            ViewData["StatusMigracao"] = new SelectList(_context.StatusMigracaos, "Id", "Nome");
            return View(baseLegada);
        }

        // POST: BaseLegadas/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(long id, [Bind("Id,Nome,StatusMigracao,LinkRespostorio,Tamanho,DataUltimaEstatistica")] BaseLegada baseLegadaView)
        {
            if (id != baseLegadaView.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    BaseLegada baseLegada = _context.BaseLegada.Find(id);
                    baseLegada.StatusMigracao = baseLegadaView.StatusMigracao;
                    baseLegada.LinkRespostorio = baseLegadaView.LinkRespostorio;
                    _context.Update(baseLegada);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!BaseLegadaExists(baseLegadaView.Id))
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
            return View(baseLegadaView);
        }

        // GET: BaseLegadas/Delete/5
        public async Task<IActionResult> Delete(long? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var baseLegada = await _context.BaseLegada
                .FirstOrDefaultAsync(m => m.Id == id);
            if (baseLegada == null)
            {
                return NotFound();
            }
            ViewData["PossuiComparacoes"] = _context.ComparacaoBases.Count(cb => cb.BaseAlvo == id || cb.BaseFonte == id);
            return View(baseLegada);
        }

        // POST: BaseLegadas/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(long id)
        {
            var baseLegada = await _context.BaseLegada.FindAsync(id);

            List<ComparacaoBases> comparacaoBases = _context.ComparacaoBases.Where(cb => cb.BaseFonte == id || cb.BaseAlvo == id).ToList();
            List<ComparacaoBasesElemento> comparacaoBasesElementos = _context.ComparacaoBasesElementos.Include(cbe => cbe.ComparacaoBasesNavigation).Where(cbe => comparacaoBases.Contains(cbe.ComparacaoBasesNavigation)).ToList();
            _context.ComparacaoBasesElementos.RemoveRange(comparacaoBasesElementos);
            _context.ComparacaoBases.RemoveRange(comparacaoBases);
            _context.BaseLegada.Remove(baseLegada);
            await _context.SaveChangesAsync();
            TempData["MensagemSucesso"] = "Base legada excluída com sucesso!";
            return RedirectToAction(nameof(Index));
        }

        private bool BaseLegadaExists(long id)
        {
            return _context.BaseLegada.Any(e => e.Id == id);
        }
    }
}
