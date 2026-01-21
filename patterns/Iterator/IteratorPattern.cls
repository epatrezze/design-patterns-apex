/**
 * Padrao: Iterator
 * Uso: quando precisa percorrer uma colecao sem expor sua representacao interna.
 * Resolucao: iterator filtra contatos por dominio de email.
 * Contexto: percorrer contatos filtrando por dominio corporativo.
 */
public with sharing class IteratorPattern {
    /**
     * Executa um fluxo demonstrativo de iteracao filtrada.
     * @return Nao retorna valor.
     */
    public static void demo() {
        // Exemplo simples do padrao com objetos padrao do Salesforce.
        List<Contact> contacts = new List<Contact>{
            new Contact(LastName = 'Silva', Email = 'ana@acme.com'),
            new Contact(LastName = 'Souza', Email = 'joao@outro.com')
        };
        ContactCollection collection = new ContactCollection(contacts, 'acme.com');
        for (Contact c : collection) {
            System.debug(c);
        }
    }

    public class ContactCollection implements Iterable<Contact> {
        private final List<Contact> contacts;
        private final String domain;

        /**
         * Inicializa a colecao com contatos e dominio alvo.
         * @param contacts Lista de contatos.
         * @param domain Dominio de email para filtro.
         * @return Nao retorna valor.
         */
        public ContactCollection(List<Contact> contacts, String domain) {
            this.contacts = contacts == null ? new List<Contact>() : contacts;
            this.domain = domain;
        }

        /**
         * Retorna o iterator configurado com a lista e o dominio.
         * @return Iterator de contatos filtrados.
         */
        public Iterator<Contact> iterator() {
            return new ContactIterator(contacts, domain);
        }
    }

    public class ContactIterator implements Iterator<Contact> {
        private final List<Contact> contacts;
        private final String domain;
        private Integer position = 0;

        /**
         * Inicializa o iterator com contatos e dominio.
         * @param contacts Lista de contatos.
         * @param domain Dominio de email para filtro.
         * @return Nao retorna valor.
         */
        public ContactIterator(List<Contact> contacts, String domain) {
            this.contacts = contacts;
            this.domain = domain;
        }

        /**
         * Verifica se existe proximo contato que atende ao filtro.
         * @return True se existir proximo contato valido.
         */
        public Boolean hasNext() {
            Integer i = position;
            while (i < contacts.size()) {
                Contact c = contacts[i];
                if (matchesDomain(c)) {
                    return true;
                }
                i++;
            }
            return false;
        }

        /**
         * Retorna o proximo contato que atende ao filtro.
         * @return Proximo contato valido ou null se nao houver.
         */
        public Contact next() {
            while (position < contacts.size()) {
                Contact c = contacts[position++];
                if (matchesDomain(c)) {
                    return c;
                }
            }
            return null;
        }

        /**
         * Verifica se o contato possui o dominio desejado.
         * @param c Contato a validar.
         * @return True se o email termina com o dominio alvo.
         */
        private Boolean matchesDomain(Contact c) {
            if (c == null || String.isBlank(c.Email)) {
                return false;
            }
            return c.Email.toLowerCase().endsWith('@' + domain.toLowerCase());
        }
    }
}
