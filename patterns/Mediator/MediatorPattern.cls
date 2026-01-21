/**
 * Padrao: Mediator
 * Uso: quando varios objetos precisam se comunicar sem acoplamento direto.
 * Resolucao: mediador coordena mudancas entre oportunidade e tarefas.
 * Contexto: mudanca de etapa da oportunidade dispara tarefa de acompanhamento.
 */
public with sharing class MediatorPattern {
    /**
     * Executa um fluxo demonstrativo com mediacao entre colegas.
     * @return Nao retorna valor.
     */
    public static void demo() {
        // Exemplo simples do padrao com objetos padrao do Salesforce.
        DealMediator mediator = new DealMediator();
        OpportunityColleague opp = new OpportunityColleague(mediator);
        TaskColleague task = new TaskColleague(mediator);
        mediator.registerOpp(opp);
        mediator.registerTask(task);

        opp.updateStage('Negotiation');
    }

    public interface Mediator {
        /**
         * Notifica o mediador sobre um evento disparado por um colega.
         * @param sender Colega que emitiu o evento.
         * @param eventName Nome do evento.
         * @param payload Dados associados ao evento.
         * @return Nao retorna valor.
         */
        void notify(Colleague sender, String eventName, String payload);
    }

    public abstract class Colleague {
        protected final Mediator mediator;

        /**
         * Inicializa o colega com o mediador.
         * @param mediator Mediador responsavel pela comunicacao.
         * @return Nao retorna valor.
         */
        protected Colleague(Mediator mediator) {
            this.mediator = mediator;
        }
    }

    public class OpportunityColleague extends Colleague {
        private String stageName = 'Prospecting';

        /**
         * Inicializa o colega de oportunidade.
         * @param mediator Mediador responsavel pela comunicacao.
         * @return Nao retorna valor.
         */
        public OpportunityColleague(Mediator mediator) {
            super(mediator);
        }

        /**
         * Atualiza a etapa e notifica o mediador.
         * @param newStage Nova etapa da oportunidade.
         * @return Nao retorna valor.
         */
        public void updateStage(String newStage) {
            stageName = newStage;
            mediator.notify(this, 'StageChanged', stageName);
        }
    }

    public class TaskColleague extends Colleague {
        /**
         * Inicializa o colega de tarefas.
         * @param mediator Mediador responsavel pela comunicacao.
         * @return Nao retorna valor.
         */
        public TaskColleague(Mediator mediator) {
            super(mediator);
        }

        /**
         * Cria uma tarefa de follow-up baseada na etapa.
         * @param stageName Etapa da oportunidade.
         * @return Nao retorna valor.
         */
        public void createFollowUp(String stageName) {
            Task t = new Task(
                Subject = 'Acompanhar etapa: ' + stageName,
                Status = 'Not Started',
                Priority = 'Normal'
            );
            System.debug(t);
        }
    }

    public class DealMediator implements Mediator {
        private OpportunityColleague opp;
        private TaskColleague task;

        /**
         * Registra o colega de oportunidade.
         * @param opp Colega de oportunidade.
         * @return Nao retorna valor.
         */
        public void registerOpp(OpportunityColleague opp) {
            this.opp = opp;
        }

        /**
         * Registra o colega de tarefa.
         * @param task Colega de tarefa.
         * @return Nao retorna valor.
         */
        public void registerTask(TaskColleague task) {
            this.task = task;
        }

        /**
         * Trata eventos e aciona acoes em outros colegas.
         * @param sender Colega que emitiu o evento.
         * @param eventName Nome do evento.
         * @param payload Dados associados ao evento.
         * @return Nao retorna valor.
         */
        public void notify(Colleague sender, String eventName, String payload) {
            if (eventName == 'StageChanged' && task != null) {
                task.createFollowUp(payload);
            }
        }
    }
}
