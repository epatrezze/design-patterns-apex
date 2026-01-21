/**
 * Padrao: Prototype
 * Uso: quando criar novos objetos a partir de copias configuradas e barato.
 * Resolucao: clona um prototipo e ajusta apenas o necessario.
 * Contexto: criar Leads semelhantes a partir de um template pre-configurado.
 */
public with sharing class PrototypePattern {
    /**
     * Executa um fluxo demonstrativo de clonagem de Lead.
     * @return Nao retorna valor.
     */
    public static void demo() {
        // Exemplo simples do padrao com objetos padrao do Salesforce.
        Lead template = new Lead(
            Company = 'Empresa modelo',
            LastName = 'Prospect',
            LeadSource = 'Web',
            Status = 'Open - Not Contacted'
        );

        Lead newLead = (Lead) template.clone(false, true, false, false);
        newLead.FirstName = 'Carlos';
        newLead.Email = 'carlos@exemplo.com';

        System.debug(newLead);
    }
}
