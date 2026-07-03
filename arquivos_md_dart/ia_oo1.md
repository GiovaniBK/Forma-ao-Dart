# IA como apoio – Orientação a Objetos parte 1

Atividade da Lince Tech Academy sobre classes, objetos, métodos, construtores e factories em Dart.

---

## 1. Quais são os principais conceitos da orientação a objetos?

**Pergunta feita à IA:**
> Quais são os principais conceitos da orientação a objetos?

**Resposta da IA:**

Os quatro pilares principais são:

- **Encapsulamento** — esconder os detalhes internos de um objeto e expor só o que é necessário. O objeto controla seu próprio estado.
- **Herança** — uma classe pode herdar atributos e comportamentos de outra, reaproveitar código e especializar comportamentos.
- **Polimorfismo** — objetos de tipos diferentes podem ser tratados de forma uniforme quando compartilham uma interface ou superclasse. Um mesmo método pode ter comportamentos diferentes dependendo do objeto.
- **Abstração** — modelar o mundo real focando no que é relevante para o sistema, ignorando detalhes desnecessários.

Além dos pilares, outros conceitos centrais são:
- **Classe** — molde/blueprint que define estrutura e comportamento.
- **Objeto** — instância de uma classe, com seus próprios dados.
- **Atributo** — variável que pertence a um objeto.
- **Método** — função que pertence a uma classe e opera sobre seus atributos.

---

## 2. Quais as vantagens de usar orientação a objetos em comparação com outras formas de programação?

**Pergunta feita à IA:**
> Quais as vantagens de usar orientação a objetos em comparação com outras formas de programação?

**Resposta da IA:**

- **Organização e modularidade**: o código fica dividido em unidades com responsabilidades claras. É mais fácil entender, manter e modificar partes específicas sem quebrar o restante.
- **Reaproveitamento de código**: herança e composição permitem reutilizar comportamentos sem duplicar código.
- **Facilidade de manutenção**: encapsulamento garante que mudanças internas de uma classe não afetam quem a usa, desde que a interface permaneça a mesma.
- **Modelagem próxima do mundo real**: objetos representam entidades reais (usuário, produto, pedido), o que torna o código mais intuitivo de entender.
- **Escalabilidade**: projetos grandes ficam mais gerenciáveis quando bem estruturados com classes e responsabilidades separadas.

Comparando com programação procedural pura, OO brilha em sistemas complexos com muitas entidades e regras de negócio. Para scripts simples ou processamento de dados, abordagens funcionais ou procedurais podem ser mais diretas.

---

## 3. O que é uma classe e como ela se relaciona com objetos?

**Pergunta feita à IA:**
> O que é uma 'classe' e como ela se relaciona com 'objetos'?

**Resposta da IA:**

Uma **classe** é um molde — define quais atributos e métodos os objetos daquele tipo terão. Um **objeto** é uma instância concreta criada a partir desse molde, com seus próprios valores.

A relação é como uma planta baixa de uma casa (classe) e as casas construídas a partir dela (objetos). A planta define quantos quartos, onde fica a cozinha — mas cada casa construída tem sua própria cor, móveis, moradores.

```dart
// classe — o molde
class Carro {
  String marca;
  String cor;
  int ano;

  Carro(this.marca, this.cor, this.ano);

  void acelerar() {
    print('$marca acelerando...');
  }
}

// objetos — instâncias concretas
var carro1 = Carro('Toyota', 'vermelho', 2020);
var carro2 = Carro('Honda', 'preto', 2022);

// cada objeto tem seus próprios dados
carro1.acelerar(); // Toyota acelerando...
carro2.acelerar(); // Honda acelerando...
```

`carro1` e `carro2` são dois objetos diferentes da mesma classe `Carro`.

---

## 4. O que são métodos e como eles funcionam dentro de uma classe?

**Pergunta feita à IA:**
> O que são 'métodos' e como eles funcionam dentro de uma classe?

**Resposta da IA:**

Métodos são funções definidas dentro de uma classe. Eles operam sobre os atributos do objeto e definem os comportamentos que ele pode ter.

```dart
class ContaBancaria {
  double saldo;
  String titular;

  ContaBancaria(this.titular, this.saldo);

  // método que modifica o estado do objeto
  void depositar(double valor) {
    saldo += valor;
    print('Depósito de R\$$valor. Saldo atual: R\$$saldo');
  }

  // método que retorna informação
  double consultarSaldo() {
    return saldo;
  }

  // método que usa outros métodos internos
  bool sacar(double valor) {
    if (valor > saldo) {
      print('Saldo insuficiente');
      return false;
    }
    saldo -= valor;
    return true;
  }
}
```

Métodos têm acesso direto aos atributos da classe através do `this` (implícito em Dart quando não há ambiguidade). Eles podem modificar o estado do objeto, retornar valores ou executar operações com efeitos colaterais.

---

## 5. Como posso acessar os métodos de um objeto em Dart?

**Pergunta feita à IA:**
> Como posso acessar os métodos de um objeto em Dart?

**Resposta da IA:**

Usando a notação de ponto `.` após a variável que referencia o objeto:

```dart
class Calculadora {
  int somar(int a, int b) => a + b;
  int subtrair(int a, int b) => a - b;
}

void main() {
  var calc = Calculadora(); // cria o objeto
  
  print(calc.somar(5, 3));    // acessa o método somar → 8
  print(calc.subtrair(5, 3)); // acessa o método subtrair → 2
}
```

Para objetos nullable, use `?.` para evitar null pointer:

```dart
Calculadora? calc;
calc?.somar(1, 2); // só executa se calc não for null
```

Para atributos e métodos estáticos (que pertencem à classe, não ao objeto), acessa-se pelo nome da classe:

```dart
class MathHelper {
  static double pi = 3.14159;
  static double areaCirculo(double r) => pi * r * r;
}

print(MathHelper.pi);              // acesso estático
print(MathHelper.areaCirculo(5));  // sem criar objeto
```

---

## 6. Qual a diferença entre atributos públicos e privados?

**Pergunta feita à IA:**
> Qual a diferença entre atributos 'públicos' e 'privados'?

**Resposta da IA:**

Em Dart, a visibilidade é controlada pelo prefixo `_` (underscore):

- **Público** (sem `_`) — acessível de qualquer lugar, dentro ou fora da classe e do arquivo.
- **Privado** (com `_`) — acessível apenas dentro do mesmo **arquivo** `.dart`. Diferente de Java, a privacidade em Dart é por arquivo, não por classe.

```dart
class Pessoa {
  String nome;       // público
  int _idade;        // privado ao arquivo
  String _cpf;       // privado ao arquivo

  Pessoa(this.nome, this._idade, this._cpf);

  // método público que expõe a idade de forma controlada
  int get idade => _idade;

  // lógica interna — privada
  bool _maiorDeIdade() => _idade >= 18;

  String get status => _maiorDeIdade() ? 'adulto' : 'menor';
}

void main() {
  var p = Pessoa('Carlos', 25, '123.456.789-00');
  print(p.nome);    // OK — público
  print(p.idade);   // OK — getter público
  // print(p._cpf); // ERRO — privado
}
```

A convenção é encapsular atributos que representam estado interno com `_` e expor apenas o necessário através de getters e métodos.

---

## 7. Qual a diferença entre um construtor padrão e um construtor nomeado?

**Pergunta feita à IA:**
> Qual a diferença entre um construtor padrão e um construtor nomeado?

**Resposta da IA:**

- **Construtor padrão** — tem o mesmo nome da classe. Só pode existir um por classe.
- **Construtor nomeado** — tem um nome adicional após a classe. Podem existir vários, cada um para um cenário diferente de criação.

```dart
class Ponto {
  double x;
  double y;

  // construtor padrão
  Ponto(this.x, this.y);

  // construtor nomeado — ponto na origem
  Ponto.origem()
      : x = 0,
        y = 0;

  // construtor nomeado — criado a partir de uma lista
  Ponto.fromList(List<double> coords)
      : x = coords[0],
        y = coords[1];

  @override
  String toString() => 'Ponto($x, $y)';
}

void main() {
  var p1 = Ponto(3, 4);
  var p2 = Ponto.origem();
  var p3 = Ponto.fromList([1.5, 2.5]);

  print(p1); // Ponto(3.0, 4.0)
  print(p2); // Ponto(0.0, 0.0)
  print(p3); // Ponto(1.5, 2.5)
}
```

Construtores nomeados são muito usados em Dart para criar objetos a partir de JSON, com valores padrão, ou em estados específicos.

---

## 8. O que são factories em Dart e quando devo usá-las?

**Pergunta feita à IA:**
> O que são 'factories' em Dart e quando devo usá-las?

**Resposta da IA:**

Um `factory constructor` é um construtor especial que não necessariamente cria uma nova instância — ele controla o que é retornado. Pode retornar uma instância existente, uma subclasse, ou criar o objeto com lógica mais complexa.

```dart
class Configuracao {
  static Configuracao? _instancia;
  final String tema;

  Configuracao._interno(this.tema);

  // factory — retorna sempre a mesma instância (Singleton)
  factory Configuracao(String tema) {
    _instancia ??= Configuracao._interno(tema);
    return _instancia!;
  }
}

// ambas as variáveis apontam para o mesmo objeto
var c1 = Configuracao('escuro');
var c2 = Configuracao('claro');
print(identical(c1, c2)); // true
```

**Outros usos comuns:**

```dart
class Animal {
  final String tipo;
  Animal._(this.tipo);

  // factory que retorna subclasse baseada no input
  factory Animal.criar(String tipo) {
    switch (tipo) {
      case 'cachorro': return Cachorro();
      case 'gato': return Gato();
      default: return Animal._(tipo);
    }
  }
}
```

Use `factory` quando:
- Implementar o padrão Singleton.
- Precisar retornar subclasses diferentes dependendo de parâmetros.
- Criar objetos a partir de JSON (`factory fromJson`).
- A criação do objeto envolve lógica que um construtor normal não suporta.

---

## 9. Dicas de organização do projeto usando classes?

**Pergunta feita à IA:**
> Dicas de organização do meu projeto usando classes?

**Resposta da IA:**

- **Um arquivo por classe** (em projetos reais): `usuario.dart`, `produto.dart`, `pedido.dart`. Facilita encontrar e manter cada classe.
- **Organize por funcionalidade, não por tipo**:
```
lib/
  models/
    usuario.dart
    produto.dart
  services/
    auth_service.dart
    produto_service.dart
  exceptions/
    auth_exception.dart
```
- **Nomes de classe em PascalCase**: `ContaBancaria`, `ItemPedido`, `ServicoEmail`.
- **Princípio da responsabilidade única**: cada classe faz uma coisa. `Usuario` guarda dados do usuário. `UsuarioService` faz operações com usuários. Não misture.
- **Evite classes gigantes**: se uma classe passa de 200-300 linhas, provavelmente está fazendo coisas demais.
- **Separe modelo de lógica**: classes de modelo (`Produto`) guardam dados. Classes de serviço (`ProdutoService`) implementam regras de negócio.

---

## 10. Como identificar quando usar classes em Dart e qual a importância?

**Pergunta feita à IA:**
> Como identificar quando usar classes em dart e qual a importância?

**Resposta da IA:**

**Sinais de que você precisa de uma classe:**

- Você tem um conjunto de dados que andam juntos — `nome`, `email`, `senha` de um usuário. Isso é uma classe `Usuario`.
- Você tem funções que sempre recebem os mesmos parâmetros juntos — provavelmente esses parâmetros deveriam ser atributos de uma classe.
- Você está duplicando lógica em vários lugares que opera sobre os mesmos tipos de dados.
- O código ficaria mais claro com `usuario.validar()` do que com `validarUsuario(nome, email, senha)`.

**Quando não é necessário:**
- Scripts simples de uso único onde funções soltas resolvem.
- Funções utilitárias puras sem estado (pode usar funções em nível de arquivo mesmo).

**A importância:**

Classes permitem pensar no problema em termos de entidades do domínio — `Pedido`, `Cliente`, `Produto` — em vez de arrays e variáveis soltas. Isso torna o código mais próximo da linguagem do negócio, mais fácil de discutir com não-programadores e mais fácil de escalar conforme o sistema cresce.

```dart
// sem classe — difícil de entender e manter
String nomeUsuario = 'João';
String emailUsuario = 'joao@email.com';
bool usuarioAtivo = true;
validar(nomeUsuario, emailUsuario, usuarioAtivo);

// com classe — autoexplicativo
var usuario = Usuario(nome: 'João', email: 'joao@email.com', ativo: true);
usuario.validar();
```
