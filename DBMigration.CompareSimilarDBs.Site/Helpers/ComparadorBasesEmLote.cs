using DBMigration.CompareSimilarDBs.Data;
using Microsoft.Extensions.Configuration;
using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using System.Collections.Generic;

namespace Micracao.ComparadorBasesLegadas.Helpers
{
    public class ComparadorBasesEmLote
    {
        public IConfiguration configuration { get; }

        public ComparadorBasesEmLote(IConfiguration configuration)
        {
            this.configuration = configuration;
        }
        public int ExecuteAsync(CancellationToken stoppingToken)
        {
            var _context = new DBMigrationCompareSimilarDBsContext();
            // Retorna os nomes das bases sem combinações entre elas.
            // primeira consulta retornará duplicado, com bases em lados diferentes (alvo x fonte, fonte x alvo)
            var combinacoesInexistentes = (from b1 in _context.BaseLegada
                                           from b2 in _context.BaseLegada
                                           where b1.Nome != b2.Nome
                                           && !_context.ComparacaoBases.Any(cb => (cb.BaseAlvo == b1.Id && cb.BaseFonte == b2.Id) || (cb.BaseAlvo == b2.Id && cb.BaseFonte == b1.Id))
                                           && b1.BaseLegadaGrupo == b2.BaseLegadaGrupo
                                           orderby b1.StatusMigracao descending
                                           select new Tuple<BaseLegada, BaseLegada>(new BaseLegada() { Id = b1.Id, Nome = b1.Nome }, new BaseLegada() { Id = b2.Id, Nome = b2.Nome })).ToList();

            combinacoesInexistentes = LimparCombinacoesDuplicadas(combinacoesInexistentes);
            var comparacoesCriadas = new List<ComparacaoBases>();
            foreach (var cb in combinacoesInexistentes)
            {
                if (!stoppingToken.IsCancellationRequested)
                {
                    var comparacaoBases = new ComparacaoBases();
                    comparacaoBases.DataComparacao = DateTime.Now;
                    comparacaoBases.StatusComparacao = StatusComparacao.EmAndamento;
                    //A base fonte é o item 1 devido ordenação priorizando pelo status 'concluído'
                    comparacaoBases.BaseFonte = cb.Item1.Id;
                    comparacaoBases.BaseAlvo = cb.Item2.Id;
                    // Primeiro cria a comparação
                    _context.ComparacaoBases.Add(comparacaoBases);
                    _context.SaveChanges();
                    comparacoesCriadas.Add(comparacaoBases);
                }
            }
            Parallel.ForEach(comparacoesCriadas, new ParallelOptions { MaxDegreeOfParallelism = 1 }, cb =>
            {
                new ComparadorBases(configuration).Execute(cb);
            });

            return combinacoesInexistentes.Count;
        }

        private static List<Tuple<BaseLegada, BaseLegada>> LimparCombinacoesDuplicadas(List<Tuple<BaseLegada, BaseLegada>> combinacoesInexistentes)
        {
            var combinacoesNaoDuplicadas = new List<Tuple<BaseLegada, BaseLegada>>();

            combinacoesInexistentes.ForEach(ci =>
            {
                if (!combinacoesNaoDuplicadas.Any(cnd => (cnd.Item1.Nome.Equals(ci.Item1.Nome) && cnd.Item2.Nome.Equals(ci.Item2.Nome)) || (cnd.Item1.Nome.Equals(ci.Item2.Nome) && cnd.Item2.Nome.Equals(ci.Item1.Nome))))
                    combinacoesNaoDuplicadas.Add(ci);
            }
            );
            return combinacoesNaoDuplicadas;
        }

    }
}
