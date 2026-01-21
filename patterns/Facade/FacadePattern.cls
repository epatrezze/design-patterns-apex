/**
 * Padrao: Facade
 * Uso: quando precisa simplificar um conjunto de operacoes complexas.
 * Resolucao: expor um metodo unico para onboarding de cliente.
 * Contexto: centralizar a criacao de registros para onboarding de clientes.
 */
public with sharing class FacadePattern {
    /**
     * Executa um fluxo demonstrativo da fachada de onboarding.
     * @return Nao retorna valor.
     */
    public static void demo() {
        // Exemplo simples do padrao com objetos padrao do Salesforce.
        CustomerOnboardingFacade facade = new CustomerOnboardingFacade();
        OnboardingPack pack = facade.buildPack('Gamma SA', 'contato@gamma.com');
        System.debug(pack);
    }

    public class OnboardingPack {
        public Account account;
        public Contact contact;
        public Task kickoffTask;
    }

    public class CustomerOnboardingFacade {
        /**
         * Monta um pacote de onboarding com registros essenciais.
         * @param accountName Nome da conta.
         * @param contactEmail Email do contato principal.
         * @return Pacote com Account, Contact e Task de kickoff.
         */
        public OnboardingPack buildPack(String accountName, String contactEmail) {
            OnboardingPack pack = new OnboardingPack();
            pack.account = new Account(Name = accountName, Type = 'Customer');

            pack.contact = new Contact(LastName = 'Responsavel', Email = contactEmail);

            pack.kickoffTask = new Task(
                Subject = 'Agendar kickoff',
                Status = 'Not Started',
                Priority = 'High'
            );

            return pack;
        }
    }
}
