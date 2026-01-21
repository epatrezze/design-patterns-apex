/**
 * Padrao: Factory Method
 * Uso: quando uma classe precisa delegar a criacao de um objeto para subclasses.
 * Resolucao: isola a logica de criacao de registros (ex.: Case) em criadores especializados.
 * Contexto: criacao de Cases conforme canal de atendimento (Email ou Phone).
 */
public with sharing class FactoryMethodPattern {
    /**
     * Executa um fluxo demonstrativo de criacao de Cases por canal.
     * @return Nao retorna valor.
     */
    public static void demo() {
        // Exemplo simples do padrao com objetos padrao do Salesforce.
        SupportCaseCreator creator = new EmailSupportCreator();
        Case c = creator.createCase('Senha expirada', null);
        System.debug(c);

        creator = new PhoneSupportCreator();
        Case c2 = creator.createCase('Falha no login', null);
        System.debug(c2);
    }

    public abstract class SupportCaseCreator {
        /**
         * Cria um Case base e aplica a origem definida na subclasse.
         * @param subject Assunto do Case.
         * @param accountId Id da conta relacionada, se houver.
         * @return Case configurado em memoria.
         */
        public Case createCase(String subject, Id accountId) {
            Case c = buildBaseCase(subject, accountId);
            c.Origin = getOrigin();
            c.Status = 'New';
            return c;
        }

        /**
         * Informa a origem do Case para o criador concreto.
         * @return Valor de origem (ex.: Email, Phone).
         */
        protected abstract String getOrigin();

        /**
         * Cria um Case com campos basicos padrao.
         * @param subject Assunto do Case.
         * @param accountId Id da conta relacionada, se houver.
         * @return Case configurado em memoria.
         */
        private Case buildBaseCase(String subject, Id accountId) {
            Case c = new Case();
            c.Subject = subject;
            c.AccountId = accountId;
            c.Priority = 'Medium';
            return c;
        }
    }

    public class EmailSupportCreator extends SupportCaseCreator {
        /**
         * Define a origem como Email.
         * @return Origem do Case.
         */
        protected override String getOrigin() {
            return 'Email';
        }
    }

    public class PhoneSupportCreator extends SupportCaseCreator {
        /**
         * Define a origem como Phone.
         * @return Origem do Case.
         */
        protected override String getOrigin() {
            return 'Phone';
        }
    }
}
