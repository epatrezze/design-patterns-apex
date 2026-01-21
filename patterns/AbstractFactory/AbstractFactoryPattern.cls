/**
 * Padrao: Abstract Factory
 * Uso: quando precisa criar familias de objetos relacionados sem acoplar as classes concretas.
 * Resolucao: fornece uma fabrica para cada contexto (vendas vs servico).
 * Contexto: onboarding de cliente com fluxos distintos para vendas e servico.
 */
public with sharing class AbstractFactoryPattern {
    /**
     * Executa um fluxo demonstrativo criando objetos de vendas e servico.
     * @return Nao retorna valor.
     */
    public static void demo() {
        // Exemplo simples do padrao com objetos padrao do Salesforce.
        CustomerContextFactory salesFactory = new SalesContextFactory();
        CustomerContext sales = new CustomerContext(salesFactory);
        CustomerContextResult salesResult = sales.create('Acme LTDA');
        System.debug(salesResult);

        CustomerContextFactory serviceFactory = new ServiceContextFactory();
        CustomerContext service = new CustomerContext(serviceFactory);
        CustomerContextResult serviceResult = service.create('Beta SA');
        System.debug(serviceResult);
    }

    public interface CustomerContextFactory {
        /**
         * Cria a conta base para o contexto.
         * @param name Nome da conta.
         * @return Account configurada em memoria.
         */
        Account createAccount(String name);
        /**
         * Cria o registro primario do contexto (ex.: Opportunity ou Case).
         * @param accountId Id da conta relacionada.
         * @return Registro primario como SObject.
         */
        SObject createPrimaryRecord(Id accountId);
    }

    public class SalesContextFactory implements CustomerContextFactory {
        /**
         * Cria uma conta com dados tipicos de vendas.
         * @param name Nome da conta.
         * @return Account configurada em memoria.
         */
        public Account createAccount(String name) {
            return new Account(Name = name, Industry = 'Technology');
        }

        /**
         * Cria uma oportunidade inicial relacionada a conta.
         * @param accountId Id da conta relacionada.
         * @return Opportunity configurada em memoria.
         */
        public SObject createPrimaryRecord(Id accountId) {
            Opportunity opp = new Opportunity(
                Name = 'Primeira venda',
                StageName = 'Prospecting',
                CloseDate = Date.today().addDays(30),
                AccountId = accountId
            );
            return opp;
        }
    }

    public class ServiceContextFactory implements CustomerContextFactory {
        /**
         * Cria uma conta com dados tipicos de servico.
         * @param name Nome da conta.
         * @return Account configurada em memoria.
         */
        public Account createAccount(String name) {
            return new Account(Name = name, Type = 'Customer');
        }

        /**
         * Cria um Case de onboarding relacionado a conta.
         * @param accountId Id da conta relacionada.
         * @return Case configurado em memoria.
         */
        public SObject createPrimaryRecord(Id accountId) {
            Case c = new Case(
                Subject = 'Onboarding',
                Status = 'New',
                Origin = 'Web',
                AccountId = accountId
            );
            return c;
        }
    }

    public class CustomerContext {
        private final CustomerContextFactory factory;

        /**
         * Inicializa o contexto com a fabrica concreta.
         * @param factory Implementacao da fabrica para o contexto.
         * @return Nao retorna valor.
         */
        public CustomerContext(CustomerContextFactory factory) {
            this.factory = factory;
        }

        /**
         * Cria os registros do contexto e retorna o resultado agregado.
         * @param accountName Nome da conta.
         * @return Resultado contendo a conta e o registro primario.
         */
        public CustomerContextResult create(String accountName) {
            Account account = factory.createAccount(accountName);
            // Id ficticio para demonstrar o relacionamento sem inserir no banco.
            account.Id = Id.valueOf('001000000000001AAA');
            SObject primary = factory.createPrimaryRecord(account.Id);
            return new CustomerContextResult(account, primary);
        }
    }

    public class CustomerContextResult {
        public final Account account;
        public final SObject primaryRecord;

        /**
         * Agrupa a conta e o registro primario criados.
         * @param account Conta criada.
         * @param primaryRecord Registro primario criado.
         * @return Nao retorna valor.
         */
        public CustomerContextResult(Account account, SObject primaryRecord) {
            this.account = account;
            this.primaryRecord = primaryRecord;
        }
    }
}
