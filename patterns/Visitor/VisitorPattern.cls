/**
 * Padrao: Visitor
 * Uso: quando precisa executar novas operacoes sobre uma estrutura sem mudar as classes.
 * Resolucao: calcula metricas em Accounts e Opportunities via visitor.
 * Contexto: consolidacao de receita cruzando Accounts e Opportunities.
 */
public with sharing class VisitorPattern {
    /**
     * Executa um fluxo demonstrativo de visita a registros.
     * @return Nao retorna valor.
     */
    public static void demo() {
        // Exemplo simples do padrao com objetos padrao do Salesforce.
        List<RecordElement> records = new List<RecordElement>{
            new AccountElement(new Account(Name = 'Acme', AnnualRevenue = 120000)),
            new OpportunityElement(new Opportunity(Name = 'Opp A', Amount = 50000))
        };

        RevenueVisitor visitor = new RevenueVisitor();
        for (RecordElement element : records) {
            element.accept(visitor);
        }
        System.debug('Total: ' + visitor.total);
    }

    public interface RecordElement {
        /**
         * Aceita um visitor para processar o elemento.
         * @param visitor Visitor que executa a operacao.
         * @return Nao retorna valor.
         */
        void accept(RecordVisitor visitor);
    }

    public interface RecordVisitor {
        /**
         * Visita um Account para aplicar a regra.
         * @param account Conta a ser processada.
         * @return Nao retorna valor.
         */
        void visitAccount(Account account);
        /**
         * Visita uma Opportunity para aplicar a regra.
         * @param opportunity Oportunidade a ser processada.
         * @return Nao retorna valor.
         */
        void visitOpportunity(Opportunity opportunity);
    }

    public class AccountElement implements RecordElement {
        private final Account account;

        /**
         * Inicializa o elemento com a conta.
         * @param account Conta a ser visitada.
         * @return Nao retorna valor.
         */
        public AccountElement(Account account) {
            this.account = account;
        }

        /**
         * Encaminha a conta para o visitor.
         * @param visitor Visitor que executa a operacao.
         * @return Nao retorna valor.
         */
        public void accept(RecordVisitor visitor) {
            visitor.visitAccount(account);
        }
    }

    public class OpportunityElement implements RecordElement {
        private final Opportunity opportunity;

        /**
         * Inicializa o elemento com a oportunidade.
         * @param opportunity Oportunidade a ser visitada.
         * @return Nao retorna valor.
         */
        public OpportunityElement(Opportunity opportunity) {
            this.opportunity = opportunity;
        }

        /**
         * Encaminha a oportunidade para o visitor.
         * @param visitor Visitor que executa a operacao.
         * @return Nao retorna valor.
         */
        public void accept(RecordVisitor visitor) {
            visitor.visitOpportunity(opportunity);
        }
    }

    public class RevenueVisitor implements RecordVisitor {
        public Decimal total = 0;

        /**
         * Soma a receita anual do Account ao total.
         * @param account Conta a ser processada.
         * @return Nao retorna valor.
         */
        public void visitAccount(Account account) {
            total += account.AnnualRevenue == null ? 0 : account.AnnualRevenue;
        }

        /**
         * Soma o valor da Opportunity ao total.
         * @param opportunity Oportunidade a ser processada.
         * @return Nao retorna valor.
         */
        public void visitOpportunity(Opportunity opportunity) {
            total += opportunity.Amount == null ? 0 : opportunity.Amount;
        }
    }
}
