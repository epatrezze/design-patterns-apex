/**
 * Padrao: Bridge
 * Uso: quando deseja variar abstracao e implementacao de forma independente.
 * Resolucao: separa notificacao (abstracao) do canal (implementacao).
 * Contexto: notificacoes de Case enviadas por email ou Chatter.
 */
public with sharing class BridgePattern {
    /**
     * Executa um fluxo demonstrativo da ponte entre notificacao e canal.
     * @return Nao retorna valor.
     */
    public static void demo() {
        // Exemplo simples do padrao com objetos padrao do Salesforce.
        NotificationChannel email = new EmailChannel();
        SupportNotification notification = new CaseNotification(email);
        notification.notify('Case 000123');

        NotificationChannel chatter = new ChatterChannel();
        SupportNotification notification2 = new CaseNotification(chatter);
        notification2.notify('Case 000124');
    }

    public interface NotificationChannel {
        /**
         * Envia a mensagem usando o canal concreto.
         * @param subject Assunto da mensagem.
         * @param body Corpo da mensagem.
         * @return Nao retorna valor.
         */
        void send(String subject, String body);
    }

    public class EmailChannel implements NotificationChannel {
        /**
         * Envia a mensagem simulando o canal de email.
         * @param subject Assunto da mensagem.
         * @param body Corpo da mensagem.
         * @return Nao retorna valor.
         */
        public void send(String subject, String body) {
            System.debug('Email: ' + subject + ' - ' + body);
        }
    }

    public class ChatterChannel implements NotificationChannel {
        /**
         * Envia a mensagem simulando o canal do Chatter.
         * @param subject Assunto da mensagem.
         * @param body Corpo da mensagem.
         * @return Nao retorna valor.
         */
        public void send(String subject, String body) {
            System.debug('Chatter: ' + subject + ' - ' + body);
        }
    }

    public abstract class SupportNotification {
        protected final NotificationChannel channel;

        /**
         * Inicializa a notificacao com o canal a ser usado.
         * @param channel Implementacao do canal de envio.
         * @return Nao retorna valor.
         */
        protected SupportNotification(NotificationChannel channel) {
            this.channel = channel;
        }

        /**
         * Dispara a notificacao de acordo com a abstracao concreta.
         * @param reference Identificador do registro relacionado.
         * @return Nao retorna valor.
         */
        public abstract void notify(String reference);
    }

    public class CaseNotification extends SupportNotification {
        /**
         * Inicializa a notificacao de Case com o canal desejado.
         * @param channel Implementacao do canal de envio.
         * @return Nao retorna valor.
         */
        public CaseNotification(NotificationChannel channel) {
            super(channel);
        }

        /**
         * Envia uma notificacao sobre atualizacao do Case.
         * @param reference Referencia do Case.
         * @return Nao retorna valor.
         */
        public override void notify(String reference) {
            channel.send('Atualizacao de Case', 'Status atualizado para ' + reference);
        }
    }
}
