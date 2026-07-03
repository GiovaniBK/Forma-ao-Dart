# IA como apoio – Tratamento de Exceções em Dart

Atividade da Lince Tech Academy sobre assert, erros, exceções e try/catch.

---

## 1. Qual a diferença entre um erro e uma exceção em Dart?

**Pergunta feita à IA:**
> Qual a diferença entre um erro e uma exceção em Dart?

**Resposta da IA:**

Em Dart, `Error` e `Exception` são hierarquias separadas com propósitos diferentes:

- **`Error`** — representa falhas de programação, situações que nunca deveriam acontecer se o código estivesse correto. São bugs. Exemplos: `RangeError`, `StateError`, `NullError`. Em geral **não devem ser capturados** — o programa deve ser corrigido.

- **`Exception`** — representa condições anormais mas esperadas durante a execução, que o programa pode tratar e se recuperar. Exemplos: `FormatException`, `IOException`, `TimeoutException`. Devem ser capturadas com `try/catch`.

```dart
// Erro — bug no código, índice inválido
List<int> lista = [1, 2, 3];
print(lista[10]); // RangeError — não capture, corrija o código

// Exceção — situação esperada, entrada inválida
int.parse('abc'); // FormatException — capture e trate
```

---

## 2. Em quais situações devo esperar erros, e em quais devo esperar exceções?

**Pergunta feita à IA:**
> Em quais situações devo esperar encontrar um erro, e em quais devo esperar uma exceção?

**Resposta da IA:**

**Espere `Error` quando:**
- Acessar índice fora dos limites de uma lista → `RangeError`
- Usar uma variável `late` não inicializada → `LateInitializationError`
- Chamar método em objeto com estado inválido → `StateError`
- Passar argumento com tipo errado → `ArgumentError`

Esses indicam que o código está errado e precisa ser corrigido, não tratado.

**Espere `Exception` quando:**
- Converter string para número com formato inválido → `FormatException`
- Ler um arquivo que não existe → `IOException`
- Requisição de rede que falha ou expira → `TimeoutException`, `SocketException`
- Qualquer input externo que pode chegar em formato inesperado

A regra geral: se a situação depende de algo fora do controle do código (usuário, rede, arquivo), espere `Exception`. Se depende só do próprio código, é `Error` e deve ser prevenido.

---

## 3. O que fazem os blocos `try`, `catch` e `finally` em Dart?

**Pergunta feita à IA:**
> O que fazem os blocos 'try', 'catch' e 'finally' em Dart?

**Resposta da IA:**

- **`try`** — envolve o código que pode lançar uma exceção. Se nada for lançado, o `catch` é ignorado.
- **`catch`** — executado quando uma exceção é lançada dentro do `try`. Recebe o objeto da exceção.
- **`finally`** — executado **sempre**, independente de ter ocorrido exceção ou não. Usado para limpeza de recursos.

```dart
try {
  int resultado = int.parse('abc'); // lança FormatException
  print(resultado);
} catch (e) {
  print('erro capturado: $e');
} finally {
  print('isso sempre executa'); // fecha conexão, libera recurso, etc.
}
```

O `finally` é executado inclusive quando há um `return` dentro do `try` ou do `catch`.

---

## 4. Como posso capturar diferentes tipos de exceções usando `catch`?

**Pergunta feita à IA:**
> Como posso capturar diferentes tipos de exceções usando 'catch'?

**Resposta da IA:**

Use `on TipoDeExcecao` para capturar tipos específicos, e `catch` genérico como fallback:

```dart
try {
  var resultado = int.parse(entrada);
  var lista = [1, 2, 3];
  print(lista[resultado]);
} on FormatException catch (e) {
  print('formato inválido: ${e.message}');
} on RangeError catch (e) {
  print('índice fora do limite: $e');
} catch (e, stackTrace) {
  // captura qualquer outra coisa
  print('erro inesperado: $e');
  print(stackTrace);
}
```

O Dart avalia os `on` em ordem — o primeiro que corresponder ao tipo é executado. O `catch (e, s)` aceita dois parâmetros: o objeto da exceção e o stack trace.

---

## 5. Em quais situações é útil usar o bloco `finally`?

**Pergunta feita à IA:**
> Em quais situações é útil usar o bloco 'finally'?

**Resposta da IA:**

O `finally` garante que um trecho de código executa independente do que acontecer — exceção, retorno antecipado ou execução normal. É útil para:

- **Fechar conexões com banco de dados**: garantir que a conexão é fechada mesmo se a query falhar.
- **Liberar arquivos abertos**: `arquivo.close()` no `finally` garante que o arquivo não fica bloqueado.
- **Encerrar indicadores de loading**: em Flutter, desativar um spinner de carregamento independente do resultado da requisição.
- **Liberar locks ou recursos compartilhados**: garantir que nenhum recurso fica preso.

```dart
File? arquivo;
try {
  arquivo = File('dados.txt');
  // operações com o arquivo
} catch (e) {
  print('erro ao ler arquivo: $e');
} finally {
  arquivo?.close(); // garante fechamento em qualquer caso
}
```

---

## 6. Por que eu precisaria lançar uma exceção em meu código?

**Pergunta feita à IA:**
> Por que eu precisaria lançar uma exceção em meu código?

**Resposta da IA:**

Lançar exceções serve para **comunicar ao chamador** que algo deu errado de forma que ele não pode ignorar. É preferível a retornar `null` ou `-1` como sinal de erro, porque:

- O chamador é forçado a lidar com o problema (ou a exceção sobe pela pilha).
- A mensagem de erro pode ser descritiva e específica.
- O fluxo normal do código não fica poluído com verificações de valor especial.

```dart
double dividir(double a, double b) {
  if (b == 0) {
    throw ArgumentError('divisor não pode ser zero');
  }
  return a / b;
}

// quem chama precisa tratar ou a exceção sobe
try {
  print(dividir(10, 0));
} catch (e) {
  print(e); // ArgumentError: divisor não pode ser zero
}
```

---

## 7. Como posso personalizar mensagens de erro ao lançar exceções?

**Pergunta feita à IA:**
> Como posso personalizar mensagens de erro ao lançar exceções?

**Resposta da IA:**

Há três formas principais:

**1. Usar exceções built-in com mensagem:**
```dart
throw ArgumentError('o valor não pode ser negativo');
throw FormatException('CPF fora do formato esperado', entrada);
throw StateError('operação inválida neste estado');
```

**2. Criar uma exceção customizada:**
```dart
class SaldoInsuficienteException implements Exception {
  final double saldo;
  final double valorSolicitado;

  SaldoInsuficienteException(this.saldo, this.valorSolicitado);

  @override
  String toString() =>
      'Saldo insuficiente: disponível R\$$saldo, solicitado R\$$valorSolicitado';
}

// uso
throw SaldoInsuficienteException(50.0, 200.0);
```

**3. Usar `Exception` genérica com mensagem:**
```dart
throw Exception('algo deu errado ao processar o pedido');
```

A segunda opção é a mais recomendada em projetos reais — permite capturar o tipo específico com `on` e acessar os dados estruturados da exceção.

---

## 8. Quais são as melhores práticas para lançar exceções em Dart?

**Pergunta feita à IA:**
> Quais são as melhores práticas para lançar exceções em Dart?

**Resposta da IA:**

- **Lance exceções, não erros**: para situações recuperáveis, implemente `Exception`. `Error` é reservado para bugs de programação.
- **Crie exceções específicas**: uma `ProdutoNaoEncontradoException` é muito mais útil que `Exception('não encontrado')`.
- **Mensagens descritivas**: inclua o valor que causou o problema na mensagem — facilita muito o debug.
- **Lance cedo**: valide entradas no início da função, não no meio da lógica.
- **Não use exceções para fluxo normal**: exceção deve ser situação excepcional. Se algo acontece com frequência, use retorno nullable ou `Result` pattern.
- **Documente quais exceções uma função pode lançar**: isso ajuda quem usa a função saber o que tratar.

```dart
// ruim — exceção pra controle de fluxo normal
try {
  return lista.firstWhere((e) => e.id == id);
} catch (e) {
  return null;
}

// melhor
return lista.firstWhereOrNull((e) => e.id == id);
```

---

## 9. Qual a diferença entre usar `assert` e lançar uma exceção para verificar condições?

**Pergunta feita à IA:**
> Qual a diferença entre usar 'assert' e lançar uma exceção para verificar condições?

**Resposta da IA:**

| | `assert` | `throw Exception` |
|---|---|---|
| Quando executa | Só em modo debug | Sempre (debug e produção) |
| Propósito | Verificar invariantes do código durante desenvolvimento | Tratar condições de erro em produção |
| O que lança | `AssertionError` | A exceção que você definir |
| Pode ser capturado? | Tecnicamente sim, mas não deve | Sim, com try/catch |

```dart
// assert — só roda em debug, some em produção
assert(idade >= 0, 'idade não pode ser negativa');

// throw — roda sempre, para input inválido real
if (idade < 0) {
  throw ArgumentError('idade não pode ser negativa: $idade');
}
```

Use `assert` para verificar contratos internos e suposições do desenvolvedor. Use `throw` para validar dados que vêm de fora (usuário, API, arquivo).

---

## 10. Em quais situações o `assert` é mais útil durante o desenvolvimento?

**Pergunta feita à IA:**
> Em quais situações o 'assert' é mais útil durante o desenvolvimento?

**Resposta da IA:**

O `assert` é mais útil para:

- **Verificar pré-condições de funções internas**: garantir que quem chama está passando valores válidos.
- **Checar invariantes de estado**: confirmar que o objeto está num estado consistente.
- **Detectar bugs cedo durante testes**: o assert estoura imediatamente ao ser violado, apontando o problema na hora certa.
- **Documentar suposições do código**: um `assert` serve como documentação viva de o que o código espera.

```dart
class Retangulo {
  final double largura;
  final double altura;

  Retangulo(this.largura, this.altura)
      : assert(largura > 0, 'largura deve ser positiva'),
        assert(altura > 0, 'altura deve ser positiva');
}

double calcularMedia(List<int> valores) {
  assert(valores.isNotEmpty, 'lista não pode estar vazia');
  return valores.reduce((a, b) => a + b) / valores.length;
}
```

Em Flutter, `assert` é muito usado nos construtores de widgets para garantir que os parâmetros fazem sentido.

---

## 11. Como organizar exceções no projeto?

**Pergunta feita à IA:**
> Como organizar minhas exceções no projeto?

**Resposta da IA:**

A abordagem mais comum em projetos Dart/Flutter é criar um arquivo ou pasta dedicada para exceções customizadas, organizadas por domínio:

```
lib/
  exceptions/
    auth_exception.dart
    produto_exception.dart
    network_exception.dart
```

Cada arquivo define as exceções relacionadas àquele contexto:

```dart
// produto_exception.dart

class ProdutoNaoEncontradoException implements Exception {
  final int id;
  ProdutoNaoEncontradoException(this.id);

  @override
  String toString() => 'Produto com id $id não encontrado';
}

class EstoqueInsuficienteException implements Exception {
  final int disponivel;
  final int solicitado;
  EstoqueInsuficienteException(this.disponivel, this.solicitado);

  @override
  String toString() =>
      'Estoque insuficiente: $disponivel disponíveis, $solicitado solicitados';
}
```

Evite jogar todas as exceções num único arquivo gigante — fica difícil de manter. Agrupe pelo contexto de negócio.

---

## 12. Como erros e exceções afetam a execução do programa?

**Pergunta feita à IA:**
> Como os erros e exceções afetam a execução do meu programa, de exemplos?

**Resposta da IA:**

**Exceção não capturada — programa encerra:**
```dart
void main() {
  print('início');
  int.parse('abc'); // FormatException não capturada
  print('isso nunca executa'); // execução para aqui
}
// output: início
// Unhandled exception: FormatException: Invalid radix-10 number (at character 1)
```

**Exceção capturada — programa continua:**
```dart
void main() {
  print('início');
  try {
    int.parse('abc');
  } catch (e) {
    print('erro tratado: $e');
  }
  print('continua normalmente');
}
// output: início / erro tratado: ... / continua normalmente
```

**Erro não capturado — comportamento similar mas indica bug:**
```dart
void main() {
  List<int> lista = [1, 2, 3];
  print(lista[10]); // RangeError
  print('nunca chega aqui');
}
// output: Unhandled exception: RangeError (index): Index out of range
```

A diferença prática: exceções devem ser capturadas e tratadas. Erros indicam que o código precisa ser corrigido — capturá-los mascara o bug em vez de resolver.
