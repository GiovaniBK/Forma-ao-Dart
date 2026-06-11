# IA como apoio – Operadores em Dart

Atividade da Lince Tech Academy sobre operadores em Dart.

---

## 1. O que acontece se eu comparar valores de tipos diferentes usando operadores relacionais em Dart?

**Pergunta feita à IA:**
> O que acontece se eu comparar valores de tipos diferentes usando operadores relacionais em dart?

**Resposta da IA:**

O Dart é uma linguagem fortemente tipada, então comparar tipos incompatíveis geralmente resulta em erro de compilação ou retorno `false` dependendo do caso.

- Comparar `int` com `double` funciona normalmente porque ambos são `num`: `1 == 1.0` retorna `true`.
- Comparar `String` com `int` usando `==` não dá erro de compilação, mas sempre retorna `false` — tipos diferentes nunca são iguais.
- Operadores como `<`, `>`, `<=`, `>=` só funcionam entre tipos compatíveis (`num`). Tentar usar com `String` e `int` causa erro de compilação.

```dart
print(1 == 1.0);     // true  — int e double são num
print(1 == '1');     // false — tipos diferentes
print(1 < '2');      // ERRO de compilação
```

---

## 2. Qual a diferença entre os operadores de divisão `/` e `~/`?

**Pergunta feita à IA:**
> Qual a diferença entre os operadores de divisão '/' e '~/'?

**Resposta da IA:**

- **`/`** — divisão comum, sempre retorna `double`, mesmo que o resultado seja inteiro.
- **`~/`** — divisão inteira (truncada), descarta a parte decimal e retorna `int`.

```dart
print(7 / 2);   // 3.5  — double
print(7 ~/ 2);  // 3    — int (trunca, não arredonda)
print(7 % 2);   // 1    — resto da divisão (módulo)
```

Útil quando você precisa de índices, paginação, ou qualquer cálculo que exija número inteiro.

---

## 3. Como verifico se uma variável é de um determinado tipo em Dart?

**Pergunta feita à IA:**
> Como verifico se uma variável é de um determinado tipo em dart?

**Resposta da IA:**

Usando o operador `is` para verificar, e `is!` para negar:

```dart
dynamic valor = 'texto';

if (valor is String) {
  print('é uma String');
}

if (valor is! int) {
  print('não é um int');
}
```

Após o `is`, o Dart faz **type promotion** automaticamente — dentro do bloco `if`, a variável já é tratada como o tipo verificado, sem precisar de cast manual.

```dart
dynamic x = 'olá';
if (x is String) {
  print(x.length); // funciona! Dart já sabe que x é String aqui
}
```
---

## 4. Qual a função do operador `?` em testes de tipo?

**Pergunta feita à IA:**
> Qual a função do operador '?' em testes de tipo?

**Resposta da IA:**

O `?` em testes de tipo aparece principalmente no **cast condicional** com `as?`... na verdade, o Dart não tem `as?`. O `?` nos testes de tipo aparece em outros contextos:

- **`tipo?`** — declara um tipo nullable: `String?` aceita String ou null.
- **`?.`** — null-aware access: só acessa o membro se o objeto não for null.
- **`??`** — null coalescing: retorna o lado direito se o lado esquerdo for null.

```dart
String? nome = null;

print(nome?.length);       // null — não lança erro
print(nome?.length ?? 0);  // 0   — valor padrão se null
```

---

## 5. Quais são os operadores de atribuição compostos e como eles funcionam?

**Pergunta feita à IA:**
> Quais são os operadores de atribuição compostos e como eles funcionam?

**Resposta da IA:**

Operadores de atribuição compostos combinam uma operação com a atribuição, deixando o código mais curto:

| Operador | Equivale a |
|---|---|
| `a += b` | `a = a + b` |
| `a -= b` | `a = a - b` |
| `a *= b` | `a = a * b` |
| `a /= b` | `a = a / b` |
| `a ~/= b` | `a = a ~/ b` |
| `a %= b` | `a = a % b` |
| `a ??= b` | `a = a ?? b` (atribui só se a for null) |

```dart
int x = 10;
x += 5;   // x = 15
x *= 2;   // x = 30

String? nome;
nome ??= 'padrão'; // nome era null, agora é 'padrão'
nome ??= 'outro';  // nome já tem valor, não muda
```
---

## 6. Como uso os operadores `&&` e `||` para combinar condições?

**Pergunta feita à IA:**
> Como uso os operadores '&&' e '||' para combinar condições?

**Resposta da IA:**

- **`&&`** (E lógico) — todas as condições precisam ser verdadeiras.
- **`||`** (OU lógico) — basta uma condição ser verdadeira.
- **`!`** (NÃO lógico) — inverte o valor booleano.

Ambos usam **short-circuit evaluation**:
- No `&&`, se a primeira condição for falsa, a segunda nem é avaliada.
- No `||`, se a primeira for verdadeira, a segunda nem é avaliada.

```dart
int idade = 20;
bool temCadastro = true;

if (idade >= 18 && temCadastro) {
  print('pode acessar');
}

if (idade < 18 || !temCadastro) {
  print('acesso negado');
}
```
---

## 7. Qual a diferença entre usar `if-else` e expressões condicionais?

**Pergunta feita à IA:**
> Qual a diferença entre usar 'if-else' e expressões condicionais?

**Resposta da IA:**

**`if-else`** — estrutura de controle, pode ter múltiplas linhas, ideal para lógica complexa.

**Operador ternário `? :`** — expressão, retorna um valor, ideal para condições simples numa linha.

**`??`** — específico para null, mais legível que ternário quando só está tratando null.

```dart
// if-else — mais verboso, mais claro pra lógica complexa
String resultado;
if (nota >= 7) {
  resultado = 'aprovado';
} else {
  resultado = 'reprovado';
}

// ternário — compacto, bom quando é simples
String resultado = nota >= 7 ? 'aprovado' : 'reprovado';

// ?? — específico pra null
String nome = nomeDigitado ?? 'visitante';
```
---

## 8. Em quais situações a notação em cascata pode tornar o código mais legível?

**Pergunta feita à IA:**
> Em quais situações a notação em cascata pode tornar o código mais legível?

**Resposta da IA:**

A notação em cascata (`..`) permite chamar múltiplos métodos no mesmo objeto sem repetir a variável. É mais legível quando você está configurando ou populando um objeto logo após criá-lo.

```dart
// sem cascata — repetitivo
var lista = [];
lista.add(1);
lista.add(2);
lista.add(3);
lista.sort();

// com cascata — mais fluido
var lista = []
  ..add(1)
  ..add(2)
  ..add(3)
  ..sort();
```

Funciona bem com builders, configuração de objetos, e qualquer situação onde você chama vários métodos seguidos no mesmo objeto.

---

## 9. Qual a diferença entre usar a notação em cascata e chamar métodos separadamente?

**Pergunta feita à IA:**
> Qual a diferença entre usar a notação em cascata e chamar métodos separadamente?

**Resposta da IA:**

A diferença principal é que a cascata **sempre retorna o objeto original**, ignorando o retorno de cada método. Chamar separadamente usa o retorno de cada método.

```dart
// cascata — retorna a lista original após cada operação
var lista = [3, 1, 2]..sort()..add(4);
// lista = [1, 2, 3, 4]

// se sort() retornasse algo útil, a cascata ignoraria
// pra isso você usaria chamadas separadas
```

Também existe o `?..` para cascata null-safe — só executa se o objeto não for null:

```dart
objeto?..metodo1()..metodo2(); // não executa se objeto for null
```

---

## 10. Como a notação em cascata pode ser usada com testes de tipo?

**Pergunta feita à IA:**
> Como a notação em cascata pode ser usada para modificar um objeto após realizar testes de tipo?

**Resposta da IA:**

Você pode combinar `is` com cascata para agir sobre um objeto somente se ele for de um tipo específico:

```dart
dynamic animal = Cachorro();

if (animal is Cachorro) {
  animal
    ..nome = 'Rex'
    ..latir()
    ..correr();
}
```

Com o type promotion do Dart, dentro do `if (animal is Cachorro)` a variável já é tratada como `Cachorro`, então a cascata funciona com acesso total aos membros da classe.

---

## 11. Documentação dos operadores em Dart

**Pergunta feita à IA:**
> Traga a documentação dos operadores.

**Resposta da IA:**

**Aritméticos:**
| Operador | Descrição |
|---|---|
| `+` | Adição |
| `-` | Subtração |
| `*` | Multiplicação |
| `/` | Divisão (retorna double) |
| `~/` | Divisão inteira (retorna int) |
| `%` | Módulo (resto) |
| `-expr` | Negação unária |

**Relacionais:**
| Operador | Descrição |
|---|---|
| `==` | Igual |
| `!=` | Diferente |
| `>` | Maior que |
| `<` | Menor que |
| `>=` | Maior ou igual |
| `<=` | Menor ou igual |

**Teste de tipo:**
| Operador | Descrição |
|---|---|
| `is` | Verdadeiro se for do tipo |
| `is!` | Verdadeiro se não for do tipo |
| `as` | Cast de tipo |

**Lógicos:**
| Operador | Descrição |
|---|---|
| `&&` | E lógico |
| `\|\|` | OU lógico |
| `!` | NÃO lógico |

**Null-aware:**
| Operador | Descrição |
|---|---|
| `??` | Retorna direita se esquerda for null |
| `??=` | Atribui só se for null |
| `?.` | Acessa membro só se não for null |

**Cascata:**
| Operador | Descrição |
|---|---|
| `..` | Cascata normal |
| `?..` | Cascata null-safe |

---

## 12. Exemplos de mau uso do ternário

**Pergunta feita à IA:**
> Traga exemplos de mau uso do ternário.

**Resposta da IA:**

```dart
// 1. ternário aninhado — ilegível
String categoria = idade < 12 ? 'criança' : idade < 18 ? 'adolescente' : idade < 60 ? 'adulto' : 'idoso';
// use if-else aqui, muito mais claro

// 2. ternário com lógica complexa nas opções
String msg = usuario != null ? '${usuario.nome.trim().toUpperCase()} logado às ${DateTime.now()}' : 'sem usuário';
// quebre em variáveis antes

// 3. ternário pra efeito colateral, não pra valor
condicao ? fazerAlgo() : fazerOutraCoisa();
// use if-else — ternário é pra retornar valor, não executar ações

// 4. ternário onde ?? seria mais claro
String nome = valor != null ? valor : 'padrão';
// melhor: String nome = valor ?? 'padrão';
```

---

## 13. Como evitar problemas com operadores lógicos

**Pergunta feita à IA:**
> Como evitar problemas com operadores lógicos.

**Resposta da IA:**

- **Cuidado com precedência**: `&&` tem precedência maior que `||`. Use parênteses quando combinar os dois.

```dart
// ambíguo
if (a || b && c) { }       // Dart lê como a || (b && c)

// explícito
if (a || (b && c)) { }     // mesma coisa, mas claro
if ((a || b) && c) { }     // diferente!
```

- **Evite negações duplas**: `!!valor` é confuso. `valor` já é o mesmo.
- **Short-circuit pode esconder bugs**: se você depende de um efeito colateral na segunda condição, cuidado — ela pode não executar.
- **Não compare booleano com `true`/`false`**: `if (ativo == true)` é redundante, use `if (ativo)`.
- **Cuidado com null em condições**: sem verificação prévia, `objeto.propriedade && outraCoisa` pode lançar null pointer.


---
