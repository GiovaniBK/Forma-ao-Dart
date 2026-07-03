# IA como apoio – Concorrência em Dart

Atividade da Lince Tech Academy sobre Future e programação assíncrona.

---

## 1. O que é um Future em Dart e como ele me ajuda a lidar com tarefas que levam tempo?

**Pergunta feita à IA:**
> O que é um Future em Dart e como ele me ajuda a lidar com tarefas que levam tempo?

**Resposta da IA:**

Um `Future` representa um valor que estará disponível em algum momento no futuro — o resultado de uma operação que leva tempo para completar, como uma requisição de rede, leitura de arquivo ou consulta ao banco de dados.

Sem Future, o programa travaria esperando cada operação terminar antes de continuar. Com Future, você inicia a operação e continua executando outras coisas enquanto aguarda o resultado.

```dart
Future<String> buscarDados() async {
  await Future.delayed(Duration(seconds: 2)); // simula demora
  return 'dados carregados';
}

void main() async {
  print('iniciando...');
  String resultado = await buscarDados();
  print(resultado);
  print('fim');
}
// iniciando...
// (2 segundos depois)
// dados carregados
// fim
```

Um Future pode estar em três estados: pendente, concluído com valor, ou concluído com erro.

---

## 2. O que significam os termos assíncrono e síncrono?

**Pergunta feita à IA:**
> O que significam os termos 'assíncrono' e 'síncrono'?

**Resposta da IA:**

- **Síncrono** — as operações executam em sequência, uma de cada vez. A próxima linha só executa quando a anterior terminar. O programa fica bloqueado esperando.

- **Assíncrono** — uma operação pode ser iniciada e o programa continua sem esperar ela terminar. Quando a operação conclui, o resultado é entregue.

```dart
// síncrono — bloqueia tudo
void sincronos() {
  print('1');
  sleep(Duration(seconds: 2)); // trava o programa inteiro
  print('2'); // só executa depois de 2s
}

// assíncrono — não bloqueia
Future<void> assincronos() async {
  print('1');
  await Future.delayed(Duration(seconds: 2)); // libera a thread
  print('2');
}
```

Em Dart, o modelo é single-thread com event loop — não há threads paralelas por padrão, mas operações assíncronas permitem que o programa permaneça responsivo enquanto aguarda.

---

## 3. O que acontece se um Future falhar e como posso lidar com esse erro?

**Pergunta feita à IA:**
> O que acontece se um Future falhar e como posso lidar com esse erro?

**Resposta da IA:**

Quando um Future falha, ele completa com um erro em vez de um valor. Se não tratado, o erro se propaga e pode encerrar o programa.

Há duas formas de tratar:

**Com try/catch (recomendado com async/await):**
```dart
Future<String> buscar() async {
  throw Exception('falha na conexão');
}

void main() async {
  try {
    String resultado = await buscar();
    print(resultado);
  } catch (e) {
    print('erro capturado: $e');
  }
}
```

**Com .catchError() (estilo callback):**
```dart
buscar()
  .then((valor) => print(valor))
  .catchError((e) => print('erro: $e'));
```

O `try/catch` com `async/await` é mais legível e é o padrão recomendado hoje.

---

## 4. Existe uma forma de executar várias tarefas assíncronas em paralelo?

**Pergunta feita à IA:**
> Existe uma forma de executar várias tarefas assíncronas em paralelo?

**Resposta da IA:**

Sim, usando `Future.wait()` — inicia vários Futures ao mesmo tempo e aguarda todos terminarem:

```dart
Future<String> buscarUsuario() async {
  await Future.delayed(Duration(seconds: 2));
  return 'usuário';
}

Future<String> buscarProdutos() async {
  await Future.delayed(Duration(seconds: 3));
  return 'produtos';
}

void main() async {
  // em paralelo — total ~3s (o maior)
  var resultados = await Future.wait([
    buscarUsuario(),
    buscarProdutos(),
  ]);

  print(resultados[0]); // usuário
  print(resultados[1]); // produtos
}
```

Se fosse com `await` sequencial, levaria 2+3=5 segundos. Com `Future.wait`, leva ~3s porque rodam ao mesmo tempo.

Se qualquer um dos Futures falhar, o `Future.wait` falha imediatamente. Para continuar mesmo com erros, use `Future.wait` com `eagerError: false` ou trate individualmente.

---

## 5. Em quais situações devo usar Futures em meu código Dart?

**Pergunta feita à IA:**
> Em quais situações devo usar Futures em meu código Dart?

**Resposta da IA:**

Use Future sempre que a operação envolve espera por algo externo:

- **Requisições HTTP** — buscar dados de uma API.
- **Leitura/escrita de arquivos** — operações de I/O são sempre assíncronas.
- **Consultas a banco de dados** — queries podem demorar.
- **Timers e delays** — `Future.delayed` para aguardar sem bloquear.
- **Permissões e sensores** — em Flutter, pedir permissão de câmera, GPS, etc.

Não use Future para:
- Cálculos puramente em memória que terminam rápido — adiciona complexidade desnecessária.
- Operações síncronas simples.

---

## 6. Quais cuidados devo tomar ao não usar await em funções Future?

**Pergunta feita à IA:**
> Quais cuidados devo tomar não usando await em funções Future?

**Resposta da IA:**

Chamar uma função que retorna `Future` sem `await` significa que você não está esperando o resultado — o Future roda "solto" e você não sabe quando ou se vai terminar.

```dart
Future<void> salvar() async {
  await Future.delayed(Duration(seconds: 1));
  print('salvo!');
}

void main() async {
  salvar(); // sem await — não espera
  print('fim'); // executa antes de 'salvo!'
}
// fim
// salvo!  ← ordem errada
```

Riscos de não usar `await`:
- **Erros silenciosos**: exceções em Futures não aguardados podem ser perdidas sem aviso.
- **Ordem incorreta**: código que depende do resultado do Future pode executar antes dele terminar.
- **Recursos não liberados**: conexões ou arquivos podem ficar abertos mais tempo que o esperado.

Se intencionalmente não quiser aguardar, pelo menos adicione `.catchError()` para não perder erros.

---

## 7. Como lidar com erros usando Future?

**Pergunta feita à IA:**
> Como lidar com erros usando Future?

**Resposta da IA:**

**Opção 1 — try/catch com async/await (mais comum):**
```dart
Future<int> dividir(int a, int b) async {
  if (b == 0) throw ArgumentError('divisão por zero');
  return a ~/ b;
}

void main() async {
  try {
    print(await dividir(10, 0));
  } on ArgumentError catch (e) {
    print('argumento inválido: $e');
  } catch (e) {
    print('erro inesperado: $e');
  }
}
```

**Opção 2 — .then() e .catchError():**
```dart
dividir(10, 2)
  .then((resultado) => print('resultado: $resultado'))
  .catchError((e) => print('erro: $e'))
  .whenComplete(() => print('sempre executa'));
```

O `.whenComplete()` é equivalente ao `finally` — executa independente de sucesso ou erro.

---

## 8. De quais formas posso esperar que um Future seja concluído?

**Pergunta feita à IA:**
> De quais formas posso esperar que um Future seja concluído e obter o resultado?

**Resposta da IA:**

**Forma 1 — await (mais legível):**
```dart
String resultado = await minhaFuncaoAsync();
print(resultado);
```

**Forma 2 — .then() (callback):**
```dart
minhaFuncaoAsync().then((resultado) {
  print(resultado);
});
```

**Forma 3 — Future.wait para múltiplos:**
```dart
var resultados = await Future.wait([future1, future2, future3]);
```

**Forma 4 — armazenar o Future e aguardar depois:**
```dart
Future<String> futuro = minhaFuncaoAsync(); // inicia mas não aguarda
// faz outras coisas...
String resultado = await futuro; // aguarda aqui
```

A forma 4 é útil quando você quer iniciar o Future cedo mas só precisa do resultado mais tarde.

---

## 9. Como simular um erro em um Future usando Future.error?

**Pergunta feita à IA:**
> Como posso simular um erro em um Future usando Future.error?

**Resposta da IA:**

`Future.error()` cria um Future já completado com erro — útil para testes ou para retornar erros de forma explícita:

```dart
Future<String> buscarComErro() {
  return Future.error(Exception('servidor indisponível'));
}

Future<String> buscarCondicional(bool sucesso) {
  if (sucesso) {
    return Future.value('dados ok');
  }
  return Future.error(Exception('falhou'));
}

void main() async {
  try {
    await buscarComErro();
  } catch (e) {
    print('capturado: $e'); // capturado: Exception: servidor indisponível
  }

  try {
    print(await buscarCondicional(false));
  } catch (e) {
    print('capturado: $e');
  }
}
```

---

## 10. Como criar uma função que retorna um Future que simula uma demora?

**Pergunta feita à IA:**
> Como posso criar uma função que retorna um Future que simula uma demora do programa?

**Resposta da IA:**

Usando `Future.delayed`:

```dart
// simula requisição de rede
Future<String> buscarUsuario(int id) async {
  await Future.delayed(Duration(seconds: 2));
  return 'Usuário $id';
}

// simula operação que pode falhar
Future<Map<String, dynamic>> buscarDados(bool simularErro) async {
  await Future.delayed(Duration(milliseconds: 1500));

  if (simularErro) {
    throw Exception('timeout na requisição');
  }

  return {'id': 1, 'nome': 'João', 'email': 'joao@email.com'};
}

void main() async {
  print('buscando...');

  try {
    var usuario = await buscarUsuario(42);
    print(usuario);

    var dados = await buscarDados(false);
    print(dados);
  } catch (e) {
    print('erro: $e');
  }
}
```

`Future.delayed` é muito usado em testes e desenvolvimento para simular latência de rede sem precisar de uma API real.
