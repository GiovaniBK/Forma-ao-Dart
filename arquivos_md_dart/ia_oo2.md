# IA como apoio – Orientação a Objetos parte 2

Atividade da Lince Tech Academy sobre sobrescrita, getters/setters, classes abstratas, herança, interfaces, enums e métodos estáticos.

---

## 1. O que significa sobrescrever um método em Dart e por que eu faria isso?

**Pergunta feita à IA:**
> O que significa 'sobrescrever' um método em dart e por que eu faria isso?

**Resposta da IA:**

Sobrescrever (override) significa redefinir na classe filha um método que já existe na classe pai, substituindo o comportamento original por um específico para aquela subclasse. Em Dart usa-se a anotação `@override`.

```dart
class Animal {
  void emitirSom() {
    print('...');
  }
}

class Cachorro extends Animal {
  @override
  void emitirSom() {
    print('Au au!');
  }
}

class Gato extends Animal {
  @override
  void emitirSom() {
    print('Miau!');
  }
}

void main() {
  Animal a = Cachorro();
  a.emitirSom(); // Au au!

  a = Gato();
  a.emitirSom(); // Miau!
}
```

A anotação `@override` não é obrigatória mas é uma boa prática — avisa o compilador que você está intencionalmente sobrescrevendo, e ele alerta se o método não existir na classe pai.

---

## 2. Como posso chamar o método original de uma classe pai em um método sobrescrito?

**Pergunta feita à IA:**
> Como posso chamar o método original de uma classe pai em um método sobrescrito?

**Resposta da IA:**

Usando a palavra-chave `super`:

```dart
class Veiculo {
  void ligar() {
    print('verificando sistema...');
    print('motor ligado');
  }
}

class Carro extends Veiculo {
  @override
  void ligar() {
    super.ligar(); // executa o método da classe pai primeiro
    print('ar-condicionado ligado');
    print('rádio ligado');
  }
}

void main() {
  Carro().ligar();
  // verificando sistema...
  // motor ligado
  // ar-condicionado ligado
  // rádio ligado
}
```

`super` pode ser usado também para acessar atributos da classe pai. É comum em construtores: `super(parametro)` para chamar o construtor do pai antes de inicializar a classe filha.

---

## 3. Como posso criar um getter para acessar um atributo privado de uma classe?

**Pergunta feita à IA:**
> Como posso criar um getter para acessar um atributo privado de uma classe?

**Resposta da IA:**

Em Dart, getters são definidos com a palavra-chave `get`:

```dart
class Pessoa {
  String _nome;
  int _idade;

  Pessoa(this._nome, this._idade);

  // getter simples
  String get nome => _nome;

  // getter com lógica
  int get idade => _idade;

  // getter calculado — não armazena nada, calcula na hora
  bool get maiorDeIdade => _idade >= 18;

  String get apresentacao => 'Olá, sou $_nome e tenho $_idade anos';
}

void main() {
  var p = Pessoa('Ana', 22);
  print(p.nome);          // Ana
  print(p.maiorDeIdade);  // true
  print(p.apresentacao);  // Olá, sou Ana e tenho 22 anos
}
```

Getters são acessados como propriedades (sem parênteses), não como métodos. Isso torna a interface mais limpa.

---

## 4. Em quais situações é melhor usar getters e setters em vez de acessar atributos diretamente?

**Pergunta feita à IA:**
> Em quais situações é melhor usar getters e setters em vez de acessar atributos diretamente?

**Resposta da IA:**

- **Quando precisa de validação**: um setter pode rejeitar valores inválidos antes de atribuir.
- **Quando o valor é calculado**: um getter pode combinar ou transformar atributos sem armazená-los separadamente.
- **Para encapsular a implementação interna**: se mudar como o dado é armazenado internamente, quem usa o getter não precisa mudar nada.
- **Para controlar acesso**: expor leitura mas não escrita (getter sem setter) deixa o atributo read-only para quem usa a classe.

```dart
class Produto {
  String _nome;
  double _preco;

  Produto(this._nome, this._preco);

  String get nome => _nome;

  double get preco => _preco;

  set preco(double valor) {
    if (valor < 0) throw ArgumentError('preço não pode ser negativo');
    _preco = valor;
  }

  // getter calculado
  double get precoComImposto => _preco * 1.12;
}
```

Acesso direto a atributos públicos é mais simples mas abre mão de qualquer controle futuro. Com getter/setter você pode adicionar lógica sem quebrar quem já usa a classe.

---

## 5. O que é uma classe abstrata e como ela difere de uma classe normal?

**Pergunta feita à IA:**
> O que é uma 'classe abstrata' e como ela difere de uma classe normal?

**Resposta da IA:**

Uma classe abstrata é uma classe que **não pode ser instanciada diretamente** — ela existe para ser herdada. Pode ter métodos concretos (com implementação) e métodos abstratos (sem implementação, que as subclasses devem implementar).

```dart
abstract class Forma {
  // método abstrato — sem implementação
  double calcularArea();
  double calcularPerimetro();

  // método concreto — com implementação compartilhada
  void exibir() {
    print('Área: ${calcularArea()}, Perímetro: ${calcularPerimetro()}');
  }
}

class Circulo extends Forma {
  double raio;
  Circulo(this.raio);

  @override
  double calcularArea() => 3.14159 * raio * raio;

  @override
  double calcularPerimetro() => 2 * 3.14159 * raio;
}

class Retangulo extends Forma {
  double largura, altura;
  Retangulo(this.largura, this.altura);

  @override
  double calcularArea() => largura * altura;

  @override
  double calcularPerimetro() => 2 * (largura + altura);
}

void main() {
  // Forma f = Forma(); // ERRO — não pode instanciar abstrata
  Forma c = Circulo(5);
  c.exibir(); // usa o método concreto da classe pai
}
```

---

## 6. Quando devo usar classes abstratas em vez de classes concretas?

**Pergunta feita à IA:**
> Quando devo usar classes abstratas em vez de classes concretas?

**Resposta da IA:**

Use classe abstrata quando:

- A classe representa um **conceito genérico** que não faz sentido existir por si só. `Forma` é abstrata — você não cria uma "forma", cria um círculo ou retângulo.
- Você quer **forçar subclasses a implementar** certos métodos, garantindo um contrato.
- Você quer **compartilhar implementação comum** entre subclasses mas ainda deixar alguns comportamentos abertos.

Use classe concreta quando:
- A classe representa uma entidade completa que pode ser instanciada diretamente.
- Não há necessidade de forçar implementação de métodos nas subclasses.

Uma boa heurística: se você se pergunta "mas o que faz um [Classe] genérico?" e a resposta é "nada que faça sentido", provavelmente é abstrata.

---

## 7. O que é herança em Dart e como ela funciona?

**Pergunta feita à IA:**
> O que é 'herança' em Dart e como ela funciona?

**Resposta da IA:**

Herança permite que uma classe (filha) herde atributos e métodos de outra classe (pai), usando `extends`. A filha pode usar tudo que o pai tem e ainda adicionar ou sobrescrever comportamentos.

```dart
class Funcionario {
  String nome;
  double salario;

  Funcionario(this.nome, this.salario);

  double calcularBonus() => salario * 0.1;

  @override
  String toString() => '$nome — salário: R\$$salario';
}

class Gerente extends Funcionario {
  int qtdSubordinados;

  Gerente(super.nome, super.salario, this.qtdSubordinados);

  // sobrescreve o cálculo de bônus
  @override
  double calcularBonus() => salario * 0.3 + qtdSubordinados * 100;
}

void main() {
  var g = Gerente('Carlos', 8000, 5);
  print(g);              // Carlos — salário: R$8000.0
  print(g.calcularBonus()); // 2900.0
}
```

Dart suporta apenas **herança simples** — uma classe só pode ter um pai direto. Para múltiplos comportamentos, usa-se `mixins`.

---

## 8. Qual a diferença entre herança e composição?

**Pergunta feita à IA:**
> Qual a diferença entre herança e composição?

**Resposta da IA:**

- **Herança** — relação "é um": `Cachorro` é um `Animal`. A classe filha recebe tudo do pai automaticamente.
- **Composição** — relação "tem um": `Carro` tem um `Motor`. A classe contém outras classes como atributos.

```dart
// herança — Cachorro É UM Animal
class Animal { void respirar() => print('respirando'); }
class Cachorro extends Animal {
  void latir() => print('au au');
}

// composição — Carro TEM UM Motor
class Motor {
  void ligar() => print('motor ligado');
}

class Carro {
  final Motor motor = Motor(); // composição

  void ligar() {
    motor.ligar();
    print('carro pronto');
  }
}
```

**Quando usar cada um:**
- Herança: quando a relação "é um" é genuína e a subclasse realmente representa uma especialização.
- Composição: quando você quer reaproveitar comportamento sem criar uma hierarquia rígida. É mais flexível e mais fácil de testar.

A regra clássica: prefira composição sobre herança quando tiver dúvida.

---

## 9. O que é uma interface em Dart e como ela define um contrato de comportamento?

**Pergunta feita à IA:**
> O que é uma 'interface' em Dart e como ela define um contrato de comportamento?

**Resposta da IA:**

Em Dart, não existe a palavra-chave `interface` como em Java. **Toda classe pode ser usada como interface**. Quando uma classe implementa outra com `implements`, ela é obrigada a fornecer implementação para todos os métodos e getters da classe implementada.

```dart
class Autenticavel {
  bool autenticar(String senha) => false; // implementação padrão ignorada
  void logout() {}
}

class Usuario implements Autenticavel {
  final String _senha;
  Usuario(this._senha);

  @override
  bool autenticar(String senha) => senha == _senha;

  @override
  void logout() => print('usuário deslogado');
}
```

Para contratos mais semânticos, usa-se `abstract class`:

```dart
abstract class Exportavel {
  String paraJson();
  String paraCsv();
}

class Relatorio implements Exportavel {
  @override
  String paraJson() => '{"relatorio": true}';

  @override
  String paraCsv() => 'relatorio,true';
}
```

---

## 10. Como uma classe pode implementar uma interface?

**Pergunta feita à IA:**
> Como uma classe pode implementar uma interface?

**Resposta da IA:**

Usando `implements`. Uma classe pode implementar múltiplas interfaces ao mesmo tempo, o que não é possível com `extends`:

```dart
abstract class Salvavel {
  void salvar();
}

abstract class Carregavel {
  void carregar();
}

// implementa dois contratos ao mesmo tempo
class Documento implements Salvavel, Carregavel {
  String conteudo;
  Documento(this.conteudo);

  @override
  void salvar() => print('salvando: $conteudo');

  @override
  void carregar() => print('carregando documento');
}
```

Com `implements`, a classe deve reimplementar **tudo** — não herda nenhuma implementação. Com `extends`, herda as implementações e pode sobrescrever só o que quiser.

---

## 11. Qual a diferença entre herança e implementação de interfaces?

**Pergunta feita à IA:**
> Qual a diferença entre herança e implementação de interfaces?

**Resposta da IA:**

| | `extends` (herança) | `implements` (interface) |
|---|---|---|
| Herda implementação? | Sim | Não — tudo deve ser reimplementado |
| Quantas pode usar? | Apenas uma | Múltiplas |
| Relação semântica | "é um" | "se comporta como" |
| Uso típico | Especializar uma classe base | Garantir que a classe tem certos métodos |

```dart
class A {
  void metodo() => print('A');
}

// herança — herda a implementação
class B extends A {} // B.metodo() funciona sem reimplementar

// interface — precisa reimplementar tudo
class C implements A {
  @override
  void metodo() => print('C'); // obrigatório
}
```

---

## 12. Quais cenários devo usar métodos estáticos em vez de métodos de instância?

**Pergunta feita à IA:**
> Quais cenários devo usar métodos estáticos em vez de métodos de instância?

**Resposta da IA:**

Use métodos estáticos quando:

- A operação **não depende do estado de nenhum objeto** — só dos parâmetros recebidos.
- São funções utilitárias associadas ao contexto da classe mas sem precisar de instância.
- Implementar factories ou métodos de criação.

```dart
class Matematica {
  static double potencia(double base, int expoente) {
    double resultado = 1;
    for (int i = 0; i < expoente; i++) resultado *= base;
    return resultado;
  }

  static bool isPrimo(int n) {
    if (n < 2) return false;
    for (int i = 2; i <= n ~/ 2; i++) {
      if (n % i == 0) return false;
    }
    return true;
  }
}

// sem criar objeto
print(Matematica.potencia(2, 10)); // 1024.0
print(Matematica.isPrimo(17));     // true
```

Evite estático quando o método precisa acessar ou modificar o estado do objeto — nesse caso deve ser de instância.

---

## 13. Como posso acessar um método estático sem criar uma instância da classe?

**Pergunta feita à IA:**
> Como posso acessar um método estático sem criar uma instância da classe?

**Resposta da IA:**

Diretamente pelo nome da classe:

```dart
class Formatador {
  static String moeda(double valor) => 'R\$ ${valor.toStringAsFixed(2)}';
  static String cpf(String cpf) =>
      '${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.${cpf.substring(6, 9)}-${cpf.substring(9)}';
}

// sem instanciar
print(Formatador.moeda(1500.5));       // R$ 1500.50
print(Formatador.cpf('12345678901')); // 123.456.789-01
```

Métodos estáticos não têm acesso ao `this` — não pertencem a nenhum objeto, pertencem à classe.

---

## 14. O que são enumeradores em Dart e para que servem?

**Pergunta feita à IA:**
> O que são 'enumeradores' em Dart e para que servem?

**Resposta da IA:**

Enums (enumeradores) são um tipo especial que representa um conjunto fixo de valores nomeados. Usados quando uma variável só pode assumir um número limitado de estados predefinidos.

```dart
enum StatusPedido {
  aguardandoPagamento,
  pago,
  emPreparacao,
  emTransito,
  entregue,
  cancelado,
}

void processarPedido(StatusPedido status) {
  switch (status) {
    case StatusPedido.pago:
      print('iniciando preparação');
      break;
    case StatusPedido.emTransito:
      print('pedido a caminho');
      break;
    case StatusPedido.entregue:
      print('pedido entregue, obrigado!');
      break;
    default:
      print('status: $status');
  }
}
```

No Dart 2.17+, enums podem ter atributos, métodos e construtores:

```dart
enum Direcao {
  norte('N'),
  sul('S'),
  leste('L'),
  oeste('O');

  final String abreviacao;
  const Direcao(this.abreviacao);
}

print(Direcao.norte.abreviacao); // N
```

---

## 15. Em quais situações é melhor usar enumeradores em vez de constantes?

**Pergunta feita à IA:**
> Em quais situações é melhor usar enumeradores em vez de constantes?

**Resposta da IA:**

| | `enum` | Constantes (`const`) |
|---|---|---|
| Agrupa valores relacionados? | Sim, explicitamente | Só por convenção de nome |
| Type-safe? | Sim — o compilador valida | Não — qualquer int/String passa |
| Funciona com switch/exhaustive? | Sim | Não |
| Pode ter métodos/atributos? | Sim (Dart 2.17+) | Não |

```dart
// com constantes — frágil
const int STATUS_ATIVO = 1;
const int STATUS_INATIVO = 2;

void ativar(int status) { } // aceita qualquer int, inclusive 999

// com enum — seguro
enum StatusUsuario { ativo, inativo, bloqueado }

void ativar(StatusUsuario status) { } // só aceita valores do enum
```

Use enum quando os valores formam um conjunto fechado e bem definido. Use constantes quando são valores independentes sem relação semântica entre si.

---

## 16. Como criar um setter com validação?

**Pergunta feita à IA:**
> Como posso criar um setter para modificar um atributo privado de uma classe com validação?

**Resposta da IA:**

```dart
class ContaBancaria {
  String _titular;
  double _saldo;

  ContaBancaria(this._titular, this._saldo);

  String get titular => _titular;
  double get saldo => _saldo;

  set titular(String nome) {
    if (nome.trim().isEmpty) {
      throw ArgumentError('nome do titular não pode ser vazio');
    }
    _titular = nome.trim();
  }

  set saldo(double valor) {
    if (valor < 0) {
      throw ArgumentError('saldo não pode ser negativo');
    }
    _saldo = valor;
  }
}

void main() {
  var conta = ContaBancaria('João', 1000);
  conta.titular = '  Maria  '; // setter aplica trim
  print(conta.titular);        // Maria

  conta.saldo = -500; // ArgumentError: saldo não pode ser negativo
}
```

---

## 17. Como sobrescrever um método da classe pai na classe filha?

**Pergunta feita à IA:**
> Como posso sobrescrever um método da classe pai na classe filha?

**Resposta da IA:**

```dart
class Notificacao {
  String titulo;
  String mensagem;

  Notificacao(this.titulo, this.mensagem);

  void enviar() {
    print('enviando notificação: $titulo');
  }
}

class NotificacaoEmail extends Notificacao {
  String email;

  NotificacaoEmail(super.titulo, super.mensagem, this.email);

  @override
  void enviar() {
    super.enviar(); // chama o pai se quiser
    print('destinatário: $email');
    print('corpo: $mensagem');
  }
}

class NotificacaoSms extends Notificacao {
  String telefone;

  NotificacaoSms(super.titulo, super.mensagem, this.telefone);

  @override
  void enviar() {
    print('SMS para $telefone: $titulo — $mensagem');
  }
}

void main() {
  List<Notificacao> notificacoes = [
    NotificacaoEmail('Bem-vindo', 'Olá!', 'user@email.com'),
    NotificacaoSms('Alerta', 'Código: 1234', '+5511999999999'),
  ];

  for (var n in notificacoes) {
    n.enviar(); // polimorfismo — cada um executa o seu
    print('---');
  }
}
```

---

## 18. O que são métodos estáticos e como diferem dos métodos de instância?

**Pergunta feita à IA:**
> O que são 'métodos estáticos' ou 'métodos de classe' e como eles diferem dos métodos de instância?

**Resposta da IA:**

| | Método de instância | Método estático |
|---|---|---|
| Pertence a | Um objeto específico | À classe em si |
| Acessa `this`? | Sim | Não |
| Como chamar | `objeto.metodo()` | `Classe.metodo()` |
| Precisa de instância? | Sim | Não |
| Acessa atributos de instância? | Sim | Não — só atributos estáticos |

```dart
class Temperatura {
  double _celsius;

  Temperatura(this._celsius);

  // método de instância — opera sobre o objeto
  double get fahrenheit => _celsius * 9 / 5 + 32;

  // método estático — utilitário, não precisa de objeto
  static double celsiusParaFahrenheit(double c) => c * 9 / 5 + 32;
  static double fahrenheitParaCelsius(double f) => (f - 32) * 5 / 9;
}

void main() {
  // método de instância
  var t = Temperatura(100);
  print(t.fahrenheit); // 212.0

  // método estático — sem criar objeto
  print(Temperatura.celsiusParaFahrenheit(0));  // 32.0
  print(Temperatura.fahrenheitParaCelsius(98)); // 36.67
}
```
