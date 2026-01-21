/**
 * Padrao: Adapter
 * Uso: quando precisa integrar um formato legado com um objeto Salesforce.
 * Resolucao: adapta dados externos para um Lead sem mudar o legado.
 * Contexto: integracao de prospects vindos de um sistema legado para Lead.
 */
public with sharing class AdapterPattern {
    /**
     * Executa um fluxo demonstrativo de adaptacao do prospect legado.
     * @return Nao retorna valor.
     */
    public static void demo() {
        // Exemplo simples do padrao com objetos padrao do Salesforce.
        LegacyProspect legacy = new LegacyProspect('Maria Souza', 'maria@empresa.com', 'Empresa X', 'WEB');
        ProspectAdapter adapter = new LegacyProspectToLeadAdapter(legacy);
        Lead lead = adapter.toLead();
        System.debug(lead);
    }

    public interface ProspectAdapter {
        /**
         * Converte o prospect legado em um Lead.
         * @return Lead configurado em memoria.
         */
        Lead toLead();
    }

    public class LegacyProspect {
        public String fullName;
        public String email;
        public String company;
        public String sourceCode;

        /**
         * Cria um prospect legado com os dados recebidos.
         * @param fullName Nome completo do prospect.
         * @param email Email do prospect.
         * @param company Empresa associada.
         * @param sourceCode Codigo da origem.
         * @return Nao retorna valor.
         */
        public LegacyProspect(String fullName, String email, String company, String sourceCode) {
            this.fullName = fullName;
            this.email = email;
            this.company = company;
            this.sourceCode = sourceCode;
        }
    }

    public class LegacyProspectToLeadAdapter implements ProspectAdapter {
        private final LegacyProspect legacy;

        /**
         * Inicializa o adapter com o prospect legado.
         * @param legacy Dados legados de entrada.
         * @return Nao retorna valor.
         */
        public LegacyProspectToLeadAdapter(LegacyProspect legacy) {
            this.legacy = legacy;
        }

        /**
         * Converte os dados legados em um Lead padrao do Salesforce.
         * @return Lead configurado em memoria.
         */
        public Lead toLead() {
            String[] parts = legacy.fullName.split(' ');
            String lastName = parts.isEmpty() ? 'Prospect' : parts[parts.size() - 1];
            Lead lead = new Lead(
                Company = legacy.company,
                LastName = lastName,
                Email = legacy.email,
                LeadSource = mapSource(legacy.sourceCode)
            );
            return lead;
        }

        /**
         * Mapeia o codigo legado para o valor de origem do Lead.
         * @param code Codigo de origem legado.
         * @return Nome da origem do Lead.
         */
        private String mapSource(String code) {
            if (code == 'WEB') {
                return 'Web';
            }
            if (code == 'EVENT') {
                return 'Partner';
            }
            return 'Other';
        }
    }
}
