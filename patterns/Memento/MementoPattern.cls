/**
 * Padrao: Memento
 * Uso: quando precisa salvar e restaurar estado sem expor detalhes internos.
 * Resolucao: guarda o estado do Case antes de alteracoes.
 * Contexto: desfazer mudancas de status em um Case.
 */
public with sharing class MementoPattern {
    /**
     * Executa um fluxo demonstrativo de salvar e restaurar estado.
     * @return Nao retorna valor.
     */
    public static void demo() {
        // Exemplo simples do padrao com objetos padrao do Salesforce.
        CaseEditor editor = new CaseEditor(new Case(Subject = 'Erro', Status = 'New'));
        CaseCaretaker caretaker = new CaseCaretaker();

        caretaker.save(editor.save());
        editor.updateStatus('Working');

        editor.restore(caretaker.last());
        System.debug(editor.getCase());
    }

    public class CaseEditor {
        private Case c;

        /**
         * Inicializa o editor com o Case atual.
         * @param c Case a ser editado.
         * @return Nao retorna valor.
         */
        public CaseEditor(Case c) {
            this.c = c;
        }

        /**
         * Atualiza o status do Case.
         * @param status Novo status.
         * @return Nao retorna valor.
         */
        public void updateStatus(String status) {
            c.Status = status;
        }

        /**
         * Salva o estado atual em um memento.
         * @return Snapshot com campos relevantes do Case.
         */
        public CaseState save() {
            return new CaseState(c.Subject, c.Status, c.Priority, c.Description);
        }

        /**
         * Restaura o estado do Case a partir do memento.
         * @param state Snapshot previamente salvo.
         * @return Nao retorna valor.
         */
        public void restore(CaseState state) {
            if (state == null) {
                return;
            }
            c.Subject = state.subject;
            c.Status = state.status;
            c.Priority = state.priority;
            c.Description = state.description;
        }

        /**
         * Retorna o Case atual em memoria.
         * @return Case atual.
         */
        public Case getCase() {
            return c;
        }
    }

    public class CaseState {
        public final String subject;
        public final String status;
        public final String priority;
        public final String description;

        /**
         * Cria um snapshot do Case.
         * @param subject Assunto do Case.
         * @param status Status do Case.
         * @param priority Prioridade do Case.
         * @param description Descricao do Case.
         * @return Nao retorna valor.
         */
        public CaseState(String subject, String status, String priority, String description) {
            this.subject = subject;
            this.status = status;
            this.priority = priority;
            this.description = description;
        }
    }

    public class CaseCaretaker {
        private final List<CaseState> history = new List<CaseState>();

        /**
         * Salva um memento no historico.
         * @param state Snapshot a armazenar.
         * @return Nao retorna valor.
         */
        public void save(CaseState state) {
            history.add(state);
        }

        /**
         * Retorna o ultimo snapshot salvo.
         * @return Ultimo snapshot ou null se vazio.
         */
        public CaseState last() {
            if (history.isEmpty()) {
                return null;
            }
            return history[history.size() - 1];
        }
    }
}
