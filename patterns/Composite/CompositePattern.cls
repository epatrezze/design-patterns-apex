/**
 * Padrao: Composite
 * Uso: quando precisa tratar objetos individuais e colecoes de forma uniforme.
 * Resolucao: cria uma arvore de contas para somar receita.
 * Contexto: consolidacao de receita anual entre unidades e grupos de contas.
 */
public with sharing class CompositePattern {
    /**
     * Executa um fluxo demonstrativo de composicao de contas.
     * @return Nao retorna valor.
     */
    public static void demo() {
        // Exemplo simples do padrao com objetos padrao do Salesforce.
        Account a1 = new Account(Name = 'Unidade A', AnnualRevenue = 100000);
        Account a2 = new Account(Name = 'Unidade B', AnnualRevenue = 200000);

        RevenueComponent leaf1 = new AccountLeaf(a1);
        RevenueComponent leaf2 = new AccountLeaf(a2);

        AccountGroup group = new AccountGroup('Grupo Regional');
        group.add(leaf1);
        group.add(leaf2);

        System.debug(group.getLabel() + ': ' + group.getAnnualRevenue());
    }

    public interface RevenueComponent {
        /**
         * Retorna a receita anual do componente.
         * @return Receita anual consolidada.
         */
        Decimal getAnnualRevenue();
        /**
         * Retorna o rotulo do componente.
         * @return Nome exibido do componente.
         */
        String getLabel();
    }

    public class AccountLeaf implements RevenueComponent {
        private final Account account;

        /**
         * Inicializa o leaf com a conta base.
         * @param account Conta utilizada como folha.
         * @return Nao retorna valor.
         */
        public AccountLeaf(Account account) {
            this.account = account;
        }

        /**
         * Retorna a receita anual da conta.
         * @return Receita anual, ou zero se nula.
         */
        public Decimal getAnnualRevenue() {
            return account.AnnualRevenue == null ? 0 : account.AnnualRevenue;
        }

        /**
         * Retorna o nome da conta.
         * @return Nome da conta.
         */
        public String getLabel() {
            return account.Name;
        }
    }

    public class AccountGroup implements RevenueComponent {
        private final String label;
        private final List<RevenueComponent> children = new List<RevenueComponent>();

        /**
         * Inicializa o grupo com um rotulo.
         * @param label Nome do grupo.
         * @return Nao retorna valor.
         */
        public AccountGroup(String label) {
            this.label = label;
        }

        /**
         * Adiciona um componente filho ao grupo.
         * @param component Componente a ser adicionado.
         * @return Nao retorna valor.
         */
        public void add(RevenueComponent component) {
            children.add(component);
        }

        /**
         * Soma a receita anual de todos os filhos.
         * @return Receita anual consolidada do grupo.
         */
        public Decimal getAnnualRevenue() {
            Decimal total = 0;
            for (RevenueComponent child : children) {
                total += child.getAnnualRevenue();
            }
            return total;
        }

        /**
         * Retorna o rotulo do grupo.
         * @return Nome do grupo.
         */
        public String getLabel() {
            return label;
        }
    }
}
