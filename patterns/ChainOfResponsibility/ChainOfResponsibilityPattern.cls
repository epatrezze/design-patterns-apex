/**
 * Padrao: Chain of Responsibility
 * Uso: quando uma solicitacao pode ser tratada por varios niveis.
 * Resolucao: encadeia aprovadores de desconto em oportunidades.
 * Contexto: aprovacao de desconto seguindo niveis de lideranca.
 */
public with sharing class ChainOfResponsibilityPattern {
    /**
     * Executa um fluxo demonstrativo de aprovacao encadeada.
     * @return Nao retorna valor.
     */
    public static void demo() {
        // Exemplo simples do padrao com objetos padrao do Salesforce.
        ApprovalHandler handler = buildChain();
        DiscountRequest request = new DiscountRequest(0.12, 'Oportunidade 001');
        System.debug(handler.handle(request));
    }

    /**
     * Monta a cadeia de aprovadores em ordem.
     * @return Primeiro handler da cadeia.
     */
    private static ApprovalHandler buildChain() {
        ApprovalHandler lead = new TeamLeadApproval(0.05);
        ApprovalHandler manager = new ManagerApproval(0.10);
        ApprovalHandler director = new DirectorApproval(0.20);
        lead.setNext(manager);
        manager.setNext(director);
        return lead;
    }

    public class DiscountRequest {
        public Decimal discountPercent;
        public String opportunityRef;

        /**
         * Cria uma solicitacao de desconto.
         * @param discountPercent Percentual solicitado.
         * @param opportunityRef Referencia da oportunidade.
         * @return Nao retorna valor.
         */
        public DiscountRequest(Decimal discountPercent, String opportunityRef) {
            this.discountPercent = discountPercent;
            this.opportunityRef = opportunityRef;
        }
    }

    public abstract class ApprovalHandler {
        protected ApprovalHandler nextHandler;

        /**
         * Define o proximo handler da cadeia.
         * @param nextHandler Proximo aprovador.
         * @return Nao retorna valor.
         */
        public void setNext(ApprovalHandler nextHandler) {
            this.nextHandler = nextHandler;
        }

        /**
         * Tenta aprovar ou delega para o proximo handler.
         * @param request Solicitacao de desconto.
         * @return Mensagem de aprovacao ou falha.
         */
        public String handle(DiscountRequest request) {
            if (canApprove(request)) {
                return getApproverLabel() + ' aprovou ' + request.discountPercent;
            }
            if (nextHandler != null) {
                return nextHandler.handle(request);
            }
            return 'Sem aprovador para ' + request.discountPercent;
        }

        /**
         * Verifica se o handler pode aprovar a solicitacao.
         * @param request Solicitacao de desconto.
         * @return True se puder aprovar.
         */
        protected abstract Boolean canApprove(DiscountRequest request);
        /**
         * Retorna o rotulo do aprovador.
         * @return Nome do aprovador.
         */
        protected abstract String getApproverLabel();
    }

    public class TeamLeadApproval extends ApprovalHandler {
        private final Decimal max;

        /**
         * Inicializa o limite de aprovacao do team lead.
         * @param max Percentual maximo permitido.
         * @return Nao retorna valor.
         */
        public TeamLeadApproval(Decimal max) {
            this.max = max;
        }

        /**
         * Verifica se o desconto esta dentro do limite do team lead.
         * @param request Solicitacao de desconto.
         * @return True se puder aprovar.
         */
        protected override Boolean canApprove(DiscountRequest request) {
            return request.discountPercent <= max;
        }

        /**
         * Retorna o rotulo do aprovador team lead.
         * @return Nome do aprovador.
         */
        protected override String getApproverLabel() {
            return 'Team Lead';
        }
    }

    public class ManagerApproval extends ApprovalHandler {
        private final Decimal max;

        /**
         * Inicializa o limite de aprovacao do manager.
         * @param max Percentual maximo permitido.
         * @return Nao retorna valor.
         */
        public ManagerApproval(Decimal max) {
            this.max = max;
        }

        /**
         * Verifica se o desconto esta dentro do limite do manager.
         * @param request Solicitacao de desconto.
         * @return True se puder aprovar.
         */
        protected override Boolean canApprove(DiscountRequest request) {
            return request.discountPercent <= max;
        }

        /**
         * Retorna o rotulo do aprovador manager.
         * @return Nome do aprovador.
         */
        protected override String getApproverLabel() {
            return 'Manager';
        }
    }

    public class DirectorApproval extends ApprovalHandler {
        private final Decimal max;

        /**
         * Inicializa o limite de aprovacao do director.
         * @param max Percentual maximo permitido.
         * @return Nao retorna valor.
         */
        public DirectorApproval(Decimal max) {
            this.max = max;
        }

        /**
         * Verifica se o desconto esta dentro do limite do director.
         * @param request Solicitacao de desconto.
         * @return True se puder aprovar.
         */
        protected override Boolean canApprove(DiscountRequest request) {
            return request.discountPercent <= max;
        }

        /**
         * Retorna o rotulo do aprovador director.
         * @return Nome do aprovador.
         */
        protected override String getApproverLabel() {
            return 'Director';
        }
    }
}
