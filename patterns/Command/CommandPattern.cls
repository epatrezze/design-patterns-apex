/**
 * Padrao: Command
 * Uso: quando precisa encapsular uma acao como objeto e enfileirar ou desfazer.
 * Resolucao: cria comandos para atualizar Case e criar Task.
 * Contexto: fila de acoes operacionais para suporte ao cliente.
 */
public with sharing class CommandPattern {
    /**
     * Executa um fluxo demonstrativo com fila de comandos.
     * @return Nao retorna valor.
     */
    public static void demo() {
        // Exemplo simples do padrao com objetos padrao do Salesforce.
        CommandQueue queue = new CommandQueue();
        queue.add(new UpdateCaseStatusCommand('00001000', 'Working'));
        queue.add(new CreateTaskCommand('Retornar ligacao', 'High'));
        queue.executeAll();
    }

    public interface Command {
        /**
         * Executa a acao encapsulada pelo comando.
         * @return Nao retorna valor.
         */
        void execute();
    }

    public class UpdateCaseStatusCommand implements Command {
        private final String caseNumber;
        private final String status;

        /**
         * Inicializa o comando para atualizar status de Case.
         * @param caseNumber Numero do Case.
         * @param status Novo status.
         * @return Nao retorna valor.
         */
        public UpdateCaseStatusCommand(String caseNumber, String status) {
            this.caseNumber = caseNumber;
            this.status = status;
        }

        /**
         * Executa a atualizacao simulada do Case.
         * @return Nao retorna valor.
         */
        public void execute() {
            System.debug('Atualizar Case ' + caseNumber + ' para ' + status);
        }
    }

    public class CreateTaskCommand implements Command {
        private final String subject;
        private final String priority;

        /**
         * Inicializa o comando para criar uma Task.
         * @param subject Assunto da tarefa.
         * @param priority Prioridade da tarefa.
         * @return Nao retorna valor.
         */
        public CreateTaskCommand(String subject, String priority) {
            this.subject = subject;
            this.priority = priority;
        }

        /**
         * Executa a criacao simulada da Task.
         * @return Nao retorna valor.
         */
        public void execute() {
            Task t = new Task(Subject = subject, Priority = priority, Status = 'Not Started');
            System.debug(t);
        }
    }

    public class CommandQueue {
        private final List<Command> commands = new List<Command>();

        /**
         * Adiciona um comando a fila.
         * @param command Comando a ser executado.
         * @return Nao retorna valor.
         */
        public void add(Command command) {
            commands.add(command);
        }

        /**
         * Executa todos os comandos na ordem.
         * @return Nao retorna valor.
         */
        public void executeAll() {
            for (Command command : commands) {
                command.execute();
            }
        }
    }
}
