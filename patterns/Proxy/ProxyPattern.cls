/**
 * Padrao: Proxy
 * Uso: quando precisa controlar acesso a um recurso ou adicionar cache.
 * Resolucao: proxy valida acesso e reutiliza contas em memoria.
 * Contexto: acesso a contas via repositorio com validacao e cache.
 */
public with sharing class ProxyPattern {
    /**
     * Executa um fluxo demonstrativo de acesso via proxy.
     * @return Nao retorna valor.
     */
    public static void demo() {
        // Exemplo simples do padrao com objetos padrao do Salesforce.
        AccountRepository repo = new AccountRepositoryProxy(new SoqlAccountRepository());
        Account a = repo.findById(Id.valueOf('001000000000001AAA'));
        System.debug(a);
    }

    public interface AccountRepository {
        /**
         * Busca uma conta pelo Id.
         * @param accountId Id da conta.
         * @return Account encontrada.
         */
        Account findById(Id accountId);
    }

    public class SoqlAccountRepository implements AccountRepository {
        /**
         * Executa a consulta SOQL para buscar a conta.
         * @param accountId Id da conta.
         * @return Account encontrada no banco.
         */
        public Account findById(Id accountId) {
            return [SELECT Id, Name, Industry FROM Account WHERE Id = :accountId LIMIT 1];
        }
    }

    public class AccountRepositoryProxy implements AccountRepository {
        private final AccountRepository target;
        private final Map<Id, Account> cache = new Map<Id, Account>();

        /**
         * Inicializa o proxy com o repositorio real.
         * @param target Repositorio concreto.
         * @return Nao retorna valor.
         */
        public AccountRepositoryProxy(AccountRepository target) {
            this.target = target;
        }

        /**
         * Busca a conta com validacao e cache.
         * @param accountId Id da conta.
         * @return Account encontrada.
         */
        public Account findById(Id accountId) {
            if (!hasAccess(accountId)) {
                throw new SecurityException('Sem acesso a conta');
            }
            if (!cache.containsKey(accountId)) {
                cache.put(accountId, target.findById(accountId));
            }
            return cache.get(accountId);
        }

        /**
         * Verifica se o acesso ao registro e permitido.
         * @param accountId Id da conta.
         * @return True se permitido.
         */
        private Boolean hasAccess(Id accountId) {
            return accountId != null;
        }
    }
}
