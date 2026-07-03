# IA como apoio – Condicionais e Laços de Repetição em Dart

Atividade da Lince Tech Academy sobre if/else, switch, for, while e comandos de interrupção.

---

## 1. Qual a diferença entre usar `if`, `else if` e `else`?

**Pergunta feita à IA:**
> Qual a diferença entre usar 'if', 'else if' e 'else'?

**Resposta da IA:**

- **`if`** — avalia uma condição. Se for verdadeira, executa o bloco. Obrigatório, é sempre o início.
- **`else if`** — avaliado só se o `if` anterior for falso. Permite checar múltiplas condições em sequência.
- **`else`** — executado se nenhuma das condições anteriores for verdadeira. É o caso padrão/fallback. Opcional.

```dart
int nota = 75;

if (nota >= 90) {
  print('A');
} else if (nota >= 70) {
  print('B');
} else if (nota >= 50) {
  print('C');
} else {
  print('reprovado');
}
```

O Dart para na primeira condição verdadeira e ignora o restante da cadeia.

---

## 2. Quais cuidados tenho que ter com `if` e `else`?

**Pergunta feita à IA:**
> Quais cuidados tenho que ter com "if" e "else"?

**Resposta da IA:**

- **Sempre use chaves `{}`**, mesmo para blocos de uma linha. Sem chaves, só a linha imediatamente seguinte pertence ao `if`, o que pode causar bugs silenciosos ao adicionar mais linhas depois.

```dart
// perigoso
if (ativo)
  print('ativo');
  enviarEmail(); // isso sempre executa, não faz parte do if!

// correto
if (ativo) {
  print('ativo');
  enviarEmail();
}
```

- **Cuidado com condições sempre verdadeiras ou sempre falsas**: se uma condição nunca muda, o bloco é inútil ou o `else` nunca executa.
- **Evite `if` aninhados demais**: mais de 3 níveis de aninhamento fica ilegível. Considere extrair para funções ou usar early return.
- **Não compare booleano com `true`/`false`**: `if (ativo == true)` é redundante. Use `if (ativo)`.
- **Cuidado com null**: checar `if (objeto != null)` antes de acessar propriedades é obrigatório com variáveis nullable.

---

## 3. Qual a importância da palavra-chave `break` em um `switch case`?

**Pergunta feita à IA:**
> Qual a importância da palavra-chave 'break' em um 'switch case'?

**Resposta da IA:**

Em Dart, o `break` encerra a execução do `switch` após o caso correspondente. Diferente de linguagens como C ou Java, **o Dart não permite fall-through implícito** — se um `case` tiver código, ele deve terminar com `break`, `return`, `throw` ou `continue`.

```dart
String dia = 'segunda';

switch (dia) {
  case 'sábado':
  case 'domingo':
    print('fim de semana'); // fall-through permitido só em cases vazios
    break;
  case 'segunda':
    print('início da semana');
    break;
  default:
    print('dia útil');
}
```

Fall-through (cair de um case para outro) só é permitido em Dart quando o `case` está **vazio** — como no exemplo acima com sábado/domingo.

---

## 4. Quando devo usar `switch` em vez de uma série de `if else`?

**Pergunta feita à IA:**
> Quando devo usar 'switch' em vez de uma série de 'if else'?

**Resposta da IA:**

Use `switch` quando:
- Você está comparando **uma mesma variável** contra múltiplos valores fixos.
- Os valores são discretos: strings, inteiros, enums.
- Há muitos casos — `switch` fica mais legível que 10 `else if` seguidos.

Use `if/else` quando:
- As condições envolvem **ranges** ou expressões complexas: `nota >= 70`.
- Cada condição compara variáveis diferentes.
- Você tem poucos casos (2-3) e o `if` já é claro.

```dart
// switch faz sentido aqui
switch (diaDaSemana) {
  case 'segunda': ... break;
  case 'terça': ... break;
  // ...
}

// if/else faz mais sentido aqui
if (temperatura > 35) {
  print('muito quente');
} else if (temperatura > 20) {
  print('agradável');
} else {
  print('frio');
}
```

---

## 5. Qual a diferença entre um loop `for` tradicional e um loop `for...in`?

**Pergunta feita à IA:**
> Qual a diferença entre um loop 'for' tradicional e um loop 'for...in'?

**Resposta da IA:**

- **`for` tradicional** — controle total: índice, condição e incremento explícitos. Use quando precisar do índice ou de controle fino sobre a iteração.
- **`for...in`** — itera diretamente sobre os elementos de um `Iterable`. Mais legível quando só precisa dos valores.

```dart
List<String> frutas = ['maçã', 'banana', 'uva'];

// for tradicional — acesso ao índice
for (int i = 0; i < frutas.length; i++) {
  print('$i: ${frutas[i]}');
}

// for...in — mais limpo quando o índice não importa
for (String fruta in frutas) {
  print(fruta);
}
```

O `for...in` funciona com qualquer `Iterable` (listas, sets, ranges). Não dá acesso ao índice diretamente — se precisar, use o `for` tradicional ou `asMap()`.

---

## 6. Como posso repetir um bloco de código um número específico de vezes?

**Pergunta feita à IA:**
> Como posso repetir um bloco de código um número específico de vezes?

**Resposta da IA:**

A forma mais direta é um `for` com contador:

```dart
// repete 5 vezes
for (int i = 0; i < 5; i++) {
  print('repetição $i');
}

// alternativa com List.generate (mais funcional)
List.generate(5, (i) => print('repetição $i'));
```

Se não precisar do contador, dá pra usar `for` com range do pacote padrão ou simplesmente ignorar a variável:

```dart
for (int i = 0; i < 5; i++) {
  fazerAlgo(); // i nem é usado
}
```

---

## 7. Quais são os riscos de usar um loop `while` sem uma condição de parada adequada?

**Pergunta feita à IA:**
> Quais são os riscos de usar um loop 'while' sem uma condição de parada adequada?

**Resposta da IA:**

O principal risco é o **loop infinito** — o programa trava e nunca termina, consumindo CPU indefinidamente até travar o processo ou o sistema.

```dart
// loop infinito — a condição nunca se torna falsa
int x = 0;
while (x < 10) {
  print(x);
  // esqueceu de incrementar x — loop infinito!
}

// correto
while (x < 10) {
  print(x);
  x++; // condição de parada garantida
}
```

Outros riscos:
- **Consumo excessivo de memória**: se o loop aloca objetos a cada iteração sem liberar.
- **Travamento da interface**: em aplicativos, um loop infinito na thread principal congela a UI.
- **Difícil de depurar**: loops infinitos não lançam exceção — o programa simplesmente para de responder.

Sempre garanta que a variável da condição é modificada dentro do loop.

---

## 8. Quando é adequado usar `for` e quando usar `while`?

**Pergunta feita à IA:**
> Quando é adequado usar for e usar while?

**Resposta da IA:**

| Situação | Use |
|---|---|
| Número de iterações conhecido | `for` |
| Iterando sobre uma coleção | `for` / `for...in` |
| Condição de parada baseada em estado externo | `while` |
| Número de iterações desconhecido | `while` |
| Loop que deve executar pelo menos uma vez | `do...while` |

```dart
// for — sabe quantas vezes vai rodar
for (int i = 0; i < lista.length; i++) { }

// while — roda até o usuário digitar algo válido
while (entrada == null || entrada.isEmpty) {
  entrada = lerEntrada();
}

// do...while — executa primeiro, verifica depois
do {
  entrada = lerEntrada();
} while (entrada.isEmpty);
```

---

## 9. Qual a diferença entre os comandos `break` e `continue`?

**Pergunta feita à IA:**
> Qual a diferença entre os comandos 'break' e 'continue'?

**Resposta da IA:**

- **`break`** — encerra o loop completamente. A execução continua após o loop.
- **`continue`** — pula o restante da iteração atual e vai para a próxima.

```dart
for (int i = 0; i < 10; i++) {
  if (i == 3) continue; // pula o 3, continua no 4
  if (i == 7) break;    // para tudo no 7
  print(i);
}
// imprime: 0, 1, 2, 4, 5, 6
```

---

## 10. Como posso usar `break` para sair de um loop aninhado?

**Pergunta feita à IA:**
> Como posso usar 'break' para sair de um loop aninhado?

**Resposta da IA:**

Um `break` simples só sai do loop mais interno. Para sair de loops aninhados, Dart suporta **labels**:

```dart
externo:
for (int i = 0; i < 5; i++) {
  for (int j = 0; j < 5; j++) {
    if (j == 2) break externo; // sai dos dois loops
    print('$i, $j');
  }
}
```

Sem label, o `break` só interromperia o loop interno e o externo continuaria normalmente. Labels permitem nomear o loop alvo do `break` ou `continue`.

---

## 11. Em quais situações é útil usar o comando `continue` em um loop?

**Pergunta feita à IA:**
> Em quais situações é útil usar o comando 'continue' em um loop?

**Resposta da IA:**

O `continue` é útil quando você quer **pular casos específicos** sem encerrar o loop inteiro:

```dart
// pular números pares
for (int i = 0; i < 10; i++) {
  if (i % 2 == 0) continue;
  print(i); // imprime só ímpares: 1, 3, 5, 7, 9
}

// pular itens inválidos numa lista
for (String email in emails) {
  if (!emailValido(email)) continue;
  enviarEmail(email);
}

// evitar aninhamento desnecessário
for (var item in lista) {
  if (item == null) continue;       // early continue
  if (item.valor <= 0) continue;    // early continue
  processar(item);                  // lógica principal fica limpa
}
```

O último exemplo mostra o padrão de **early continue** — equivalente ao early return em funções, reduz aninhamento e deixa a lógica principal mais legível.

---

## 12. Como usar um loop `while` para ler dados de um arquivo?

**Pergunta feita à IA:**
> Como posso usar um loop 'while' para ler dados de um arquivo?

**Resposta da IA:**

Em Dart, leitura de arquivo linha a linha pode ser feita com `Stream` ou lendo tudo de uma vez. Uma abordagem com `while` seria processar uma lista de linhas até esgotar:

```dart
import 'dart:io';

void main() async {
  final arquivo = File('dados.txt');
  final linhas = await arquivo.readAsLines();
  
  int indice = 0;
  while (indice < linhas.length) {
    String linha = linhas[indice];
    if (linha.isNotEmpty) {
      print(linha);
    }
    indice++;
  }
}
```

Para arquivos grandes, prefira `Stream` para não carregar tudo em memória:

```dart
final stream = arquivo.openRead();
final linhas = stream.transform(utf8.decoder).transform(LineSplitter());

await for (String linha in linhas) {
  print(linha);
}
```

---

## 13. Como usar `switch` com tipos de dados diferentes, como strings?

**Pergunta feita à IA:**
> Como posso usar 'switch' com tipos de dados diferentes, como strings?

**Resposta da IA:**

Em Dart, `switch` funciona com `String`, `int`, `double`, `bool` e enums. A comparação é feita com `==`.

```dart
String comando = 'sair';

switch (comando) {
  case 'iniciar':
    print('iniciando...');
    break;
  case 'pausar':
    print('pausando...');
    break;
  case 'sair':
    print('encerrando...');
    break;
  default:
    print('comando desconhecido');
}
```

A partir do Dart 3, o `switch` ganhou sintaxe mais moderna com **pattern matching**:

```dart
String resultado = switch (comando) {
  'iniciar' => 'iniciando...',
  'pausar'  => 'pausando...',
  'sair'    => 'encerrando...',
  _         => 'comando desconhecido',
};
```

---

## 14. Como organizar o código com `if` e `else`?

**Pergunta feita à IA:**
> Como organizar o código com "if" "elses".

**Resposta da IA:**

- **Early return / early continue**: trate os casos de erro ou exceção primeiro e retorne logo, deixando o caminho feliz no final sem aninhamento.

```dart
// aninhado — difícil de ler
String processar(String? entrada) {
  if (entrada != null) {
    if (entrada.isNotEmpty) {
      if (entrada.length > 3) {
        return entrada.toUpperCase();
      }
    }
  }
  return '';
}

// com early return — muito mais limpo
String processar(String? entrada) {
  if (entrada == null) return '';
  if (entrada.isEmpty) return '';
  if (entrada.length <= 3) return '';
  return entrada.toUpperCase();
}
```

- **Extraia condições complexas em variáveis ou funções com nomes descritivos**:

```dart
// difícil de entender
if (usuario.idade >= 18 && usuario.documentos.isNotEmpty && !usuario.bloqueado) { }

// mais legível
bool podeAcessar = usuario.idade >= 18 
    && usuario.documentos.isNotEmpty 
    && !usuario.bloqueado;

if (podeAcessar) { }
```

- **Evite mais de 3 níveis de aninhamento**: é sinal de que parte da lógica deveria estar em outra função.

---

