/**
 * Padrao: Template Method
 * Uso: quando um algoritmo tem passos fixos com variacoes controladas.
 * Resolucao: define o fluxo de gerar relatorios e deixa filtros customizados.
 * Contexto: geracao de relatorio de pipeline com regras de filtro fixas.
 */
public with sharing class TemplateMethodPattern {
    /**
     * Executa um fluxo demonstrativo de geracao de relatorio.
     * @return Nao retorna valor.
     */
    public static void demo() {
        // Exemplo simples do padrao com objetos padrao do Salesforce.
        ReportGenerator report = new PipelineReport();
        System.debug(report.generate());
    }

    public abstract class ReportGenerator {
        /**
         * Executa o algoritmo padrao de geracao do relatorio.
         * @return Relatorio formatado como string.
         */
        public String generate() {
            List<Opportunity> data = loadData();
            List<Opportunity> filtered = filterData(data);
            return formatData(filtered);
        }

        /**
         * Carrega os dados base do relatorio.
         * @return Lista de oportunidades a processar.
         */
        protected virtual List<Opportunity> loadData() {
            return new List<Opportunity>{
                new Opportunity(Name = 'Opp A', StageName = 'Prospecting', CloseDate = Date.today().addDays(10)),
                new Opportunity(Name = 'Opp B', StageName = 'Closed Won', CloseDate = Date.today().addDays(-2))
            };
        }

        /**
         * Aplica o filtro especifico do relatorio.
         * @param data Lista base de oportunidades.
         * @return Lista filtrada de oportunidades.
         */
        protected abstract List<Opportunity> filterData(List<Opportunity> data);

        /**
         * Formata os dados filtrados em uma string.
         * @param data Lista filtrada de oportunidades.
         * @return Relatorio formatado como string.
         */
        protected virtual String formatData(List<Opportunity> data) {
            List<String> lines = new List<String>();
            for (Opportunity o : data) {
                lines.add(o.Name + ' - ' + o.StageName);
            }
            return String.join(lines, '\n');
        }
    }

    public class PipelineReport extends ReportGenerator {
        /**
         * Filtra oportunidades removendo as encerradas.
         * @param data Lista base de oportunidades.
         * @return Lista apenas com oportunidades em aberto.
         */
        protected override List<Opportunity> filterData(List<Opportunity> data) {
            List<Opportunity> result = new List<Opportunity>();
            for (Opportunity o : data) {
                if (o.StageName != 'Closed Won' && o.StageName != 'Closed Lost') {
                    result.add(o);
                }
            }
            return result;
        }
    }
}
