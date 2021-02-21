<h2>Visão Geral</h2>

Sistema de apoio á migração de dados.

O objetivo é facilitar na identificação das bases que possuem schemas (estrutura de tabelas e colunas) mais parecidos entre si.

Sistema em versão BETA, com os seguintes recursos disponíveis:

<ol>
<li>Cadastro de grupos de bases, com configuração da string de conexão e prefixo do nome das bases legadas.</li>
<li>Busca das bases legadas</li>
<li>Compara o schema de todas bases legadas existentes, por grupo</li>
<li>Compara o schema de bases legadas selecionadas, do mesmo grupo</li>
<li>Gera relatório com tabelas e colunas divergentes, identificadas na comparação</li>
</ol>

<h2>Projetos</h2>

<h3>DBMigration.CompareSimilarDBs.Site</h3>
Site do gerenciador de comparação de bases, em ASP.NET MVC e .NET 5.
<h3>DBMigration.CompareSimilarDBs.Data</h3>
Camada de persistência, contendo o contexto e classes modelo.
<h3>DBMigration.CompareSimilarDBs.Impanta</h3>
Projeto vazio do tipo SQL Server Database Project, utilizado na compilação para comparação das bases.
<h3>DBMigration.CompareSimilarDBs.Service</h3>
Projeto do tipo Service, criado para rodar as comparações como serviço do windows, apenas iniciado, sem implementação funcional até o momento.
<br/>
<h2>Dependências principais</h2>

<h4>1 - SQL Package - para geração dos arquivos DACPACs das bases</h4>
Documentação: <br/>
https://docs.microsoft.com/pt-br/sql/tools/sqlpackage/sqlpackage?view=sql-server-ver15: <br/>
https://docs.microsoft.com/pt-br/sql/relational-databases/data-tier-applications/data-tier-applications?view=sql-server-ver15: <br/> <br/>
Link para download: https://docs.microsoft.com/pt-br/sql/tools/sqlpackage/sqlpackage-download?view=sql-server-ver15

<h4>2 - MSBuild - para comparação das bases</h4>
Documentação: https://docs.microsoft.com/en-us/archive/blogs/ssdt/msbuild-support-for-schema-compare-is-available

Link para download: https://visualstudio.microsoft.com/downloads/?q=build+tools

<h4>3 - ClosedXML - Para geração de relatório excel</h4>
Documentação: https://github.com/ClosedXML/ClosedXML

<h4>4 - SQL Server - Banco de dados do gerenciador</h4>

<h2>Implantação</h2>
Na implantação informar no arquivo de configuração (appsettings.json) as seguintes 'tags':
<ol>
<li><b>DirectoryDACPAC</b> - Caminho onde serão armazenados os arquivos DACPACs</li>
<li><b>SchemaCompareProjectCSProjFil</b>e - Caminho para o arquivo de projeto (.csproj) de um SQL Server Database Project que será utilizado na comparação. Pode ser usado o projeto (vazio) DBMigration.CompareSimilarDBs.Impanta deste repositório.</li>
<li><b>MSBuildExeFile</b> - Caminho para o executável do MSBuild, previamenteo instalado no servidor, utilizado para compilar a comparação da bases</li>
<li><b>SqlPackage</b> - Caminho para o executável do SqlPackage previamente instalado no servidor, utilizado para gerar os arquivos DACPACs</li>
</ol>

<h2>Exemplo de uso</h2>
<p>Para atender um cliente Federal, sistema deverá ser instalado em cada uma de suas regionais. </p>
<p>Cada regional possui uma instalação independente de um mesmo sistema legado, mas em versões que podem ser ou não diferentes.</p>
<p>Como não há um padrão de versões das bases, o aproveitamento das migrações existentes se torna complexo.</p>
<p>Neste cenário, a identificação das bases legadas que possuem maior semelhança estrutural (schema de tabelas e colunas), permite aproveitar ao máximo os projetos de migrações.</p>

<h2>Sequência de uso</h2>

A sequência básica de uso do sistema é a seguinte (pendente de prints):
<ol>
<li>Cadastro do grupo de bases</li>
<li>"Buscar novas bases" para que identificação e registro das bases legadas no sistema</li>
<li>Em "Comparação de bases", executar "Comparar todas combinações faltantes", que irá identificar as combinações possíveis e efetuar a comparação das mesmas.</li>
<li>Ao final das comparações, é possível visualizar na base de referência, qual a base com menos diferenças</li>
<li>Gerar relatório com as diferenças (tabelas e colunas) identificadas</li>
</ol>

<h2>Pendências:</h2>

<ol>
<li>Criar comparações ou re-comparar (em caso de falha) a partir de uma base.</li>
<li>Contar registros das tabelas identificadas na comparação e descartar as vazias.</li>
<li>Trabalhar usabilidade.</li>
<li>Ao salvar no modal fechar o mesmo.</li>
<li>Limpeza e organização do código em geral.</li>
<li>Corrigir gerador avulso de DACPACs.</li>
<li>Incluir opção para exclusão de grupos de bases legadas.</li>
<li>Incluir registro de log de alertas e falhas (ex.: Log4Net).</li>
<li>Deslocar javascripts para arquivos independentes.</li>
</ol>
