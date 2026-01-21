/**
 * Padrao: State
 * Uso: quando o comportamento muda conforme o estado interno.
 * Resolucao: muda regras de transicao do Case conforme estado atual.
 * Contexto: fluxo de estados de atendimento em um Case.
 */
public with sharing class StatePattern {
    /**
     * Executa um fluxo demonstrativo de transicoes de estado.
     * @return Nao retorna valor.
     */
    public static void demo() {
        // Exemplo simples do padrao com objetos padrao do Salesforce.
        CaseContext context = new CaseContext(new NewState());
        context.advance();
        context.advance();
        context.advance();
    }

    public interface CaseState {
        /**
         * Avanca o contexto para o proximo estado.
         * @param context Contexto do Case.
         * @return Nao retorna valor.
         */
        void next(CaseContext context);
        /**
         * Retorna o nome do estado atual.
         * @return Nome do estado.
         */
        String getName();
    }

    public class CaseContext {
        private CaseState state;

        /**
         * Inicializa o contexto com um estado inicial.
         * @param initial Estado inicial.
         * @return Nao retorna valor.
         */
        public CaseContext(CaseState initial) {
            this.state = initial;
            System.debug('Estado inicial: ' + state.getName());
        }

        /**
         * Atualiza o estado atual do contexto.
         * @param state Novo estado.
         * @return Nao retorna valor.
         */
        public void setState(CaseState state) {
            this.state = state;
            System.debug('Estado atual: ' + state.getName());
        }

        /**
         * Solicita a transicao para o proximo estado.
         * @return Nao retorna valor.
         */
        public void advance() {
            state.next(this);
        }
    }

    public class NewState implements CaseState {
        /**
         * Transiciona de New para Working.
         * @param context Contexto do Case.
         * @return Nao retorna valor.
         */
        public void next(CaseContext context) {
            context.setState(new WorkingState());
        }

        /**
         * Retorna o nome do estado.
         * @return Nome do estado.
         */
        public String getName() {
            return 'New';
        }
    }

    public class WorkingState implements CaseState {
        /**
         * Transiciona de Working para Waiting Customer.
         * @param context Contexto do Case.
         * @return Nao retorna valor.
         */
        public void next(CaseContext context) {
            context.setState(new WaitingCustomerState());
        }

        /**
         * Retorna o nome do estado.
         * @return Nome do estado.
         */
        public String getName() {
            return 'Working';
        }
    }

    public class WaitingCustomerState implements CaseState {
        /**
         * Transiciona de Waiting Customer para Closed.
         * @param context Contexto do Case.
         * @return Nao retorna valor.
         */
        public void next(CaseContext context) {
            context.setState(new ClosedState());
        }

        /**
         * Retorna o nome do estado.
         * @return Nome do estado.
         */
        public String getName() {
            return 'Waiting Customer';
        }
    }

    public class ClosedState implements CaseState {
        /**
         * Mantem o estado Closed e informa que nao ha transicao.
         * @param context Contexto do Case.
         * @return Nao retorna valor.
         */
        public void next(CaseContext context) {
            System.debug('Case ja esta fechado');
        }

        /**
         * Retorna o nome do estado.
         * @return Nome do estado.
         */
        public String getName() {
            return 'Closed';
        }
    }
}
