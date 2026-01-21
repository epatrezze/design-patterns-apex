# Design Patterns em Apex (Salesforce)

Repositorio com os 22 padroes implementados em Apex, com exemplos praticos e alinhados ao dia a dia de quem desenvolve em Salesforce (Sales/Service Cloud). Cada padrao possui uma classe com cabecalho contextual e metodos documentados em nivel de projeto.

## O que voce encontra aqui
- 22 padrões em Apex, organizados por pasta.
- `demo()` em cada classe para execucao rapida no Execute Anonymous.
- Exemplos com objetos padrao (Account, Case, Opportunity, Lead, Contact, Task).
- Comentarios em cada metodo (o que faz, entradas e retornos).

## Estrutura do repositorio
```
patterns/<NomeDoPadrao>/<NomeDoPadrao>Pattern.cls
```

## Cenarios de uso (por padrao)
| Categoria | Padrao | Quando usar em Salesforce |
| --- | --- | --- |
| Criacional | Factory Method | Criacao de Cases variando por canal (Email, Phone, Web). |
| Criacional | Abstract Factory | Onboarding de clientes com familias de registros (Sales vs Service). |
| Criacional | Builder | Montagem de pacotes com Account, Contact, Opportunity e Tasks. |
| Criacional | Prototype | Criar Leads a partir de template pre-configurado. |
| Criacional | Singleton | Cache local de configuracoes da org. |
| Estrutural | Adapter | Integrar payload legado para Lead sem mudar o legado. |
| Estrutural | Bridge | Notificacoes desacopladas do canal (Email/Chatter). |
| Estrutural | Composite | Consolidar receita em hierarquias de contas. |
| Estrutural | Decorator | Enriquecer descricao de Case com camadas (SLA, compliance). |
| Estrutural | Facade | Simplificar onboarding com um unico metodo. |
| Estrutural | Flyweight | Reaproveitar templates de Task para reduzir memoria. |
| Estrutural | Proxy | Controle de acesso e cache para repositorios. |
| Comportamental | Chain of Responsibility | Aprovacao de desconto por niveis. |
| Comportamental | Command | Encapsular acoes para fila e reexecucao. |
| Comportamental | Iterator | Percorrer colecoes com filtro encapsulado. |
| Comportamental | Mediator | Coordenar eventos entre Opportunity e Task. |
| Comportamental | Memento | Salvar e restaurar estado de Case. |
| Comportamental | Observer | Reagir a mudancas de status do Case. |
| Comportamental | State | Variar comportamento conforme estado do Case. |
| Comportamental | Strategy | Trocar regras de atribuicao de Lead. |
| Comportamental | Template Method | Definir fluxo de relatorio com filtros customizaveis. |
| Comportamental | Visitor | Executar operacoes novas sobre Account e Opportunity. |


## Indice rapido (links diretos)
Criacionais
- [Factory Method](patterns/FactoryMethod/FactoryMethodPattern.cls)
- [Abstract Factory](patterns/AbstractFactory/AbstractFactoryPattern.cls)
- [Builder](patterns/Builder/BuilderPattern.cls)
- [Prototype](patterns/Prototype/PrototypePattern.cls)
- [Singleton](patterns/Singleton/SingletonPattern.cls)

Estruturais
- [Adapter](patterns/Adapter/AdapterPattern.cls)
- [Bridge](patterns/Bridge/BridgePattern.cls)
- [Composite](patterns/Composite/CompositePattern.cls)
- [Decorator](patterns/Decorator/DecoratorPattern.cls)
- [Facade](patterns/Facade/FacadePattern.cls)
- [Flyweight](patterns/Flyweight/FlyweightPattern.cls)
- [Proxy](patterns/Proxy/ProxyPattern.cls)

Comportamentais
- [Chain of Responsibility](patterns/ChainOfResponsibility/ChainOfResponsibilityPattern.cls)
- [Command](patterns/Command/CommandPattern.cls)
- [Iterator](patterns/Iterator/IteratorPattern.cls)
- [Mediator](patterns/Mediator/MediatorPattern.cls)
- [Memento](patterns/Memento/MementoPattern.cls)
- [Observer](patterns/Observer/ObserverPattern.cls)
- [State](patterns/State/StatePattern.cls)
- [Strategy](patterns/Strategy/StrategyPattern.cls)
- [Template Method](patterns/TemplateMethod/TemplateMethodPattern.cls)
- [Visitor](patterns/Visitor/VisitorPattern.cls)

## Como executar um exemplo
No Developer Console ou no VS Code (Execute Anonymous), rode:
```apex
FactoryMethodPattern.demo();
```

## Exemplos de execucao por categoria
Criacionais
```apex
FactoryMethodPattern.demo();
AbstractFactoryPattern.demo();
BuilderPattern.demo();
PrototypePattern.demo();
SingletonPattern.demo();
```

Estruturais
```apex
AdapterPattern.demo();
BridgePattern.demo();
CompositePattern.demo();
DecoratorPattern.demo();
FacadePattern.demo();
FlyweightPattern.demo();
ProxyPattern.demo();
```

Comportamentais
```apex
ChainOfResponsibilityPattern.demo();
CommandPattern.demo();
IteratorPattern.demo();
MediatorPattern.demo();
MementoPattern.demo();
ObserverPattern.demo();
StatePattern.demo();
StrategyPattern.demo();
TemplateMethodPattern.demo();
VisitorPattern.demo();
```

## Boas praticas Apex aplicadas
- `with sharing` nas classes para respeitar regras de compartilhamento.
- Foco em objetos padrao e cenarios reais de negocio.
- Sem DML no `demo()` para facilitar o estudo sem efeitos colaterais.
- Comentarios claros para uso didatico e onboarding de equipe.

## Observacoes importantes
- `ProxyPattern` executa SOQL real; use um Id valido no seu ambiente.
- Os exemplos sao intencionais e didaticos, visando clareza e extensibilidade.

