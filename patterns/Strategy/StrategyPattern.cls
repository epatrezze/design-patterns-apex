/**
 * Padrao: Strategy
 * Uso: quando precisa trocar um algoritmo sem mudar quem usa.
 * Resolucao: alterna regras de atribuicao de Leads.
 * Contexto: distribuicao de Leads por round-robin ou por regiao.
 */
public with sharing class StrategyPattern {
    /**
     * Executa um fluxo demonstrativo com duas estrategias de atribuicao.
     * @return Nao retorna valor.
     */
    public static void demo() {
        // Exemplo simples do padrao com objetos padrao do Salesforce.
        Lead lead = new Lead(Company = 'Empresa Z', LastName = 'Lima', Country = 'BR');
        List<Id> owners = new List<Id>{
            Id.valueOf('005000000000001AAA'),
            Id.valueOf('005000000000002AAA')
        };

        LeadAssignmentService service = new LeadAssignmentService(new RoundRobinStrategy());
        System.debug(service.assign(lead, owners));

        service = new LeadAssignmentService(new RegionStrategy());
        System.debug(service.assign(lead, owners));
    }

    public interface AssignmentStrategy {
        /**
         * Escolhe o owner ideal para o Lead.
         * @param lead Lead a ser atribuido.
         * @param owners Lista de owners disponiveis.
         * @return Id do owner escolhido.
         */
        Id chooseOwner(Lead lead, List<Id> owners);
    }

    public class RoundRobinStrategy implements AssignmentStrategy {
        private Integer index = 0;

        /**
         * Escolhe o owner seguindo round-robin.
         * @param lead Lead a ser atribuido.
         * @param owners Lista de owners disponiveis.
         * @return Id do owner escolhido.
         */
        public Id chooseOwner(Lead lead, List<Id> owners) {
            if (owners == null || owners.isEmpty()) {
                return null;
            }
            Id selected = owners[index % owners.size()];
            index++;
            return selected;
        }
    }

    public class RegionStrategy implements AssignmentStrategy {
        /**
         * Escolhe o owner baseado na regiao do Lead.
         * @param lead Lead a ser atribuido.
         * @param owners Lista de owners disponiveis.
         * @return Id do owner escolhido.
         */
        public Id chooseOwner(Lead lead, List<Id> owners) {
            if (owners == null || owners.isEmpty()) {
                return null;
            }
            if (lead != null && lead.Country == 'BR') {
                return owners[0];
            }
            return owners.size() > 1 ? owners[1] : owners[0];
        }
    }

    public class LeadAssignmentService {
        private final AssignmentStrategy strategy;

        /**
         * Inicializa o servico com a estrategia desejada.
         * @param strategy Estrategia de atribuicao.
         * @return Nao retorna valor.
         */
        public LeadAssignmentService(AssignmentStrategy strategy) {
            this.strategy = strategy;
        }

        /**
         * Atribui o Lead usando a estrategia configurada.
         * @param lead Lead a ser atribuido.
         * @param owners Lista de owners disponiveis.
         * @return Id do owner escolhido.
         */
        public Id assign(Lead lead, List<Id> owners) {
            return strategy.chooseOwner(lead, owners);
        }
    }
}
