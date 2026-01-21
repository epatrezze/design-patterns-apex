/**
 * Padrao: Flyweight
 * Uso: quando precisa reduzir custo de memoria ao repetir dados imutaveis.
 * Resolucao: compartilha templates de tarefas para criacao rapida.
 * Contexto: reaproveitamento de templates de Task para follow-up e renovacao.
 */
public with sharing class FlyweightPattern {
    /**
     * Executa um fluxo demonstrativo de criacao de tarefas via flyweight.
     * @return Nao retorna valor.
     */
    public static void demo() {
        // Exemplo simples do padrao com objetos padrao do Salesforce.
        TaskTemplateFactory factory = new TaskTemplateFactory();
        Task followUp = factory.createTask('FOLLOW_UP', null);
        Task renewal = factory.createTask('RENEWAL', null);
        System.debug(followUp);
        System.debug(renewal);
    }

    public class TaskTemplate {
        public String subject;
        public String status;
        public String priority;

        /**
         * Inicializa o template de tarefa.
         * @param subject Assunto padrao.
         * @param status Status padrao.
         * @param priority Prioridade padrao.
         * @return Nao retorna valor.
         */
        public TaskTemplate(String subject, String status, String priority) {
            this.subject = subject;
            this.status = status;
            this.priority = priority;
        }
    }

    public class TaskTemplateFactory {
        private final Map<String, TaskTemplate> cache = new Map<String, TaskTemplate>();

        /**
         * Inicializa o cache com templates conhecidos.
         * @return Nao retorna valor.
         */
        public TaskTemplateFactory() {
            cache.put('FOLLOW_UP', new TaskTemplate('Follow up com cliente', 'Not Started', 'Normal'));
            cache.put('RENEWAL', new TaskTemplate('Renovacao de contrato', 'Not Started', 'High'));
        }

        /**
         * Cria uma Task a partir de um template compartilhado.
         * @param templateKey Chave do template desejado.
         * @param whatId Id do registro relacionado (WhatId).
         * @return Task configurada em memoria.
         */
        public Task createTask(String templateKey, Id whatId) {
            TaskTemplate template = cache.get(templateKey);
            if (template == null) {
                template = new TaskTemplate('Tarefa generica', 'Not Started', 'Normal');
                cache.put(templateKey, template);
            }

            Task t = new Task(
                Subject = template.subject,
                Status = template.status,
                Priority = template.priority,
                WhatId = whatId
            );
            return t;
        }
    }
}
