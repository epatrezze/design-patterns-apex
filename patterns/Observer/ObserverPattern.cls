/**
 * Padrao: Observer
 * Uso: quando varios interessados precisam reagir a uma mudanca.
 * Resolucao: observers reagem a mudanca de status do Case.
 * Contexto: acoes automaticas quando um Case muda de status.
 */
public with sharing class ObserverPattern {
    /**
     * Executa um fluxo demonstrativo de notificacao de observers.
     * @return Nao retorna valor.
     */
    public static void demo() {
        // Exemplo simples do padrao com objetos padrao do Salesforce.
        CaseSubject subject = new CaseSubject();
        subject.register(new EmailObserver());
        subject.register(new TaskObserver());

        Case c = new Case(Subject = 'Erro no login', Status = 'New');
        subject.setStatus(c, 'Working');
    }

    public interface CaseObserver {
        /**
         * Atualiza o observer com o Case modificado.
         * @param c Case atualizado.
         * @return Nao retorna valor.
         */
        void update(Case c);
    }

    public class CaseSubject {
        private final List<CaseObserver> observers = new List<CaseObserver>();

        /**
         * Registra um observer para receber atualizacoes.
         * @param observer Observer a registrar.
         * @return Nao retorna valor.
         */
        public void register(CaseObserver observer) {
            observers.add(observer);
        }

        /**
         * Atualiza o status e notifica os observers.
         * @param c Case a ser atualizado.
         * @param status Novo status.
         * @return Nao retorna valor.
         */
        public void setStatus(Case c, String status) {
            c.Status = status;
            notifyObservers(c);
        }

        /**
         * Dispara notificacoes para todos os observers.
         * @param c Case atualizado.
         * @return Nao retorna valor.
         */
        private void notifyObservers(Case c) {
            for (CaseObserver o : observers) {
                o.update(c);
            }
        }
    }

    public class EmailObserver implements CaseObserver {
        /**
         * Simula o envio de email com o novo status.
         * @param c Case atualizado.
         * @return Nao retorna valor.
         */
        public void update(Case c) {
            System.debug('Enviar email: ' + c.CaseNumber + ' status ' + c.Status);
        }
    }

    public class TaskObserver implements CaseObserver {
        /**
         * Simula a criacao de uma tarefa de comunicacao.
         * @param c Case atualizado.
         * @return Nao retorna valor.
         */
        public void update(Case c) {
            Task t = new Task(Subject = 'Atualizar cliente sobre case', Status = 'Not Started');
            System.debug(t);
        }
    }
}
