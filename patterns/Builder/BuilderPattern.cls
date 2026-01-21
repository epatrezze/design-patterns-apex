/**
 * Padrao: Builder
 * Uso: quando a criacao de um objeto complexo tem muitas opcoes e passos.
 * Resolucao: separa a construcao em um builder com passos claros e fluentes.
 * Contexto: montagem de um pacote de vendas com Account, Contact, Opportunity e Tasks.
 */
public with sharing class BuilderPattern {
    /**
     * Executa um fluxo demonstrativo do builder.
     * @return Nao retorna valor.
     */
    public static void demo() {
        // Exemplo simples do padrao com objetos padrao do Salesforce.
        DealBundle bundle = new DealBundleBuilder()
            .withAccount('Acme LTDA')
            .withPrimaryContact('Ana Silva', 'ana@acme.com')
            .withOpportunity('Renovacao anual', 50000)
            .addFollowUpTask('Ligar para validar necessidade')
            .build();
        System.debug(bundle);
    }

    public class DealBundle {
        public Account account;
        public Contact contact;
        public Opportunity opportunity;
        public List<Task> tasks;
    }

    public class DealBundleBuilder {
        private final DealBundle bundle = new DealBundle();
        private final List<Task> pendingTasks = new List<Task>();

        /**
         * Define os dados da conta do pacote.
         * @param name Nome da conta.
         * @return O proprio builder para encadear chamadas.
         */
        public DealBundleBuilder withAccount(String name) {
            bundle.account = new Account(Name = name, Industry = 'Technology');
            return this;
        }

        /**
         * Define o contato principal do pacote.
         * @param fullName Nome completo usado para extrair o sobrenome.
         * @param email Email do contato.
         * @return O proprio builder para encadear chamadas.
         */
        public DealBundleBuilder withPrimaryContact(String fullName, String email) {
            List<String> parts = fullName.split(' ');
            String lastName = parts.isEmpty() ? 'Contato' : parts[parts.size() - 1];
            bundle.contact = new Contact(LastName = lastName, Email = email);
            return this;
        }

        /**
         * Define a oportunidade principal do pacote.
         * @param name Nome da oportunidade.
         * @param amount Valor estimado.
         * @return O proprio builder para encadear chamadas.
         */
        public DealBundleBuilder withOpportunity(String name, Decimal amount) {
            bundle.opportunity = new Opportunity(
                Name = name,
                Amount = amount,
                StageName = 'Prospecting',
                CloseDate = Date.today().addDays(30)
            );
            return this;
        }

        /**
         * Adiciona uma tarefa de follow-up ao pacote.
         * @param subject Assunto da tarefa.
         * @return O proprio builder para encadear chamadas.
         */
        public DealBundleBuilder addFollowUpTask(String subject) {
            Task t = new Task(Subject = subject, Status = 'Not Started', Priority = 'Normal');
            pendingTasks.add(t);
            return this;
        }

        /**
         * Finaliza a construcao e retorna o pacote completo.
         * @return Bundle com todos os registros configurados.
         */
        public DealBundle build() {
            bundle.tasks = pendingTasks;
            return bundle;
        }
    }
}
