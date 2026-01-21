/**
 * Padrao: Decorator
 * Uso: quando precisa adicionar responsabilidades dinamicamente sem heranca.
 * Resolucao: adiciona informacoes a descricao do Case em camadas.
 * Contexto: enriquecimento progressivo da descricao de um Case com SLA e compliance.
 */
public with sharing class DecoratorPattern {
    /**
     * Executa um fluxo demonstrativo de decoracao de descricao.
     * @return Nao retorna valor.
     */
    public static void demo() {
        // Exemplo simples do padrao com objetos padrao do Salesforce.
        Case c = new Case(Subject = 'Erro no faturamento', Description = 'Cliente reportou divergencia');
        CaseDescription baseDesc = new BaseCaseDescription(c);
        CaseDescription withSla = new SlaDecorator(baseDesc, 'Gold');
        CaseDescription withCompliance = new ComplianceDecorator(withSla, 'LGPD');
        System.debug(withCompliance.render());
    }

    public interface CaseDescription {
        /**
         * Renderiza a descricao com os detalhes atuais.
         * @return Texto final da descricao.
         */
        String render();
    }

    public class BaseCaseDescription implements CaseDescription {
        private final Case c;

        /**
         * Inicializa a descricao base com o Case.
         * @param c Case usado como base.
         * @return Nao retorna valor.
         */
        public BaseCaseDescription(Case c) {
            this.c = c;
        }

        /**
         * Monta a descricao base do Case.
         * @return Texto base com assunto e descricao.
         */
        public String render() {
            return c.Subject + ' - ' + c.Description;
        }
    }

    public abstract class CaseDescriptionDecorator implements CaseDescription {
        protected final CaseDescription inner;

        /**
         * Inicializa o decorator com o componente interno.
         * @param inner Descricao a ser decorada.
         * @return Nao retorna valor.
         */
        protected CaseDescriptionDecorator(CaseDescription inner) {
            this.inner = inner;
        }
    }

    public class SlaDecorator extends CaseDescriptionDecorator {
        private final String tier;

        /**
         * Inicializa o decorator de SLA.
         * @param inner Descricao a ser decorada.
         * @param tier Nivel de SLA.
         * @return Nao retorna valor.
         */
        public SlaDecorator(CaseDescription inner, String tier) {
            super(inner);
            this.tier = tier;
        }

        /**
         * Adiciona informacao de SLA a descricao.
         * @return Texto com informacao de SLA.
         */
        public String render() {
            return inner.render() + ' | SLA: ' + tier;
        }
    }

    public class ComplianceDecorator extends CaseDescriptionDecorator {
        private final String policy;

        /**
         * Inicializa o decorator de compliance.
         * @param inner Descricao a ser decorada.
         * @param policy Politica aplicada.
         * @return Nao retorna valor.
         */
        public ComplianceDecorator(CaseDescription inner, String policy) {
            super(inner);
            this.policy = policy;
        }

        /**
         * Adiciona informacao de compliance a descricao.
         * @return Texto com informacao de compliance.
         */
        public String render() {
            return inner.render() + ' | Politica: ' + policy;
        }
    }
}
