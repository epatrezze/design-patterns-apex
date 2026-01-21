/**
 * Padrao: Singleton
 * Uso: quando precisa de uma unica instancia compartilhada de configuracao ou cache.
 * Resolucao: garante um ponto unico de acesso e instancia unica.
 * Contexto: cache simples de configuracoes de org para uso em servicos.
 */
public with sharing class SingletonPattern {
    /**
     * Executa um fluxo demonstrativo do singleton de configuracao.
     * @return Nao retorna valor.
     */
    public static void demo() {
        // Exemplo simples do padrao com objetos padrao do Salesforce.
        OrgSettings settings = OrgSettings.getInstance();
        System.debug(settings.getDefaultCasePriority());
    }

    public class OrgSettings {
        private static OrgSettings instance;
        private final Map<String, String> values = new Map<String, String>();

        /**
         * Inicializa as configuracoes padrao em memoria.
         * @return Nao retorna valor.
         */
        private OrgSettings() {
            values.put('casePriority', 'Medium');
            values.put('defaultOwner', UserInfo.getUserId());
        }

        /**
         * Retorna a instancia unica, criando se necessario.
         * @return Instancia singleton de configuracao.
         */
        public static OrgSettings getInstance() {
            if (instance == null) {
                instance = new OrgSettings();
            }
            return instance;
        }

        /**
         * Recupera a prioridade padrao de Case.
         * @return Prioridade padrao configurada.
         */
        public String getDefaultCasePriority() {
            return values.get('casePriority');
        }
    }
}
