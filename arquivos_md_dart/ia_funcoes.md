# IA como apoio – Funções em Dart

Atividade do Lince Tech Academy sobre funções em Dart.

---

## 1. Quais cuidados devo ter ao criar funções em Dart?

**Pergunta feita à IA:**
> Quais cuidados devo ter ao criar funções em dart?

**Resposta da IA:**

- **Funções devem ter uma responsabilidade única**: uma função que faz muitas coisas ao mesmo tempo fica difícil de testar e manter. Se o nome precisar de "e" no meio, provavelmente é sinal de que deveria ser duas funções.
- **Nomes descritivos e em camelCase**: `calcularTotal()` é melhor que `calc()` ou `ct()`.
- **Declare o tipo de retorno**: mesmo que o Dart consiga inferir, declarar `int soma(int a, int b)` é mais legível que só `soma(a, b)`.
- **Evite efeitos colaterais desnecessários**: funções que modificam variáveis externas sem deixar isso claro são fontes de bug.
- **Tamanho razoável**: se a função passa de 20-30 linhas, vale pensar se ela está fazendo coisas demais.
- **Trate casos de erro**: se a função pode receber valores inválidos, trate isso dentro dela ou documente que o chamador é responsável.


---

## 2. Posso chamar minha função dentro dela mesma?

**Pergunta feita à IA:**
> Posso chamar minha função dentro dela mesma?

**Resposta da IA:**

Sim, isso se chama **recursão**. Uma função pode chamar a si mesma, desde que exista uma condição de parada, senão entra em loop infinito e estoura a pilha de chamadas (`Stack Overflow`).

```dart
int fatorial(int n) {
  if (n <= 1) return 1;        // condição de parada
  return n * fatorial(n - 1);  // chamada recursiva
}

print(fatorial(5)); // 120
```

**Cuidados:**
- Sempre ter uma condição de parada clara.
- Recursão profunda pode causar `Stack Overflow` para valores muito grandes.
- Em alguns casos, um loop simples é mais eficiente e legível que recursão.

---

## 3. Existe limite de parâmetros a serem recebidos em uma função?

**Pergunta feita à IA:**
> Existe limite de parâmetros a serem recebidos em uma função?

**Resposta da IA:**

Tecnicamente o Dart não impõe um limite fixo de parâmetros. Mas na prática:

- **Mais de 3-4 parâmetros é sinal de alerta**: funções com muitos parâmetros são difíceis de chamar, de lembrar a ordem e de testar.
- **Solução comum**: agrupar parâmetros relacionados em uma classe ou usar parâmetros nomeados.

```dart
// difícil de chamar — qual é qual?
void criarUsuario(String nome, int idade, String email, String cidade, bool ativo) { }

// melhor com parâmetros nomeados
void criarUsuario({
  required String nome,
  required int idade,
  required String email,
  String cidade = '',
  bool ativo = true,
}) { }
```

---

## 4. É recomendado usar `dynamic` nos parâmetros de uma função?

**Pergunta feita à IA:**
> É recomendado usar de dynamic nos parâmetros de uma função?

**Resposta da IA:**

Em geral, **não é recomendado**. Usar `dynamic` desativa a verificação de tipos do Dart, o que significa:

- Erros de tipo só aparecem em tempo de execução, não em compilação.
- A IDE perde a capacidade de autocompletar e sugerir métodos.
- Quem usa a função não sabe o que pode passar.

**Quando pode fazer sentido:**
- Integração com JSON ou dados externos onde o tipo realmente não é conhecido.
- Funções utilitárias muito genéricas onde `Object?` ou generics não resolvem.

**Alternativa melhor**: usar **generics** quando você quer aceitar tipos diferentes mas ainda com segurança.

```dart
// ruim
void imprimir(dynamic valor) { print(valor); }

// melhor
void imprimir<T>(T valor) { print(valor); }
```

---

## 5. Quando usar parâmetros opcionais e requeridos em uma função Dart?

**Pergunta feita à IA:**
> Quando usar os operadores de valores opcionais e valores requeridos em uma função dart?

**Resposta da IA:**

**`required`** — use quando o parâmetro é indispensável para a função funcionar corretamente.

**Opcional com valor padrão** — use quando existe um valor que faz sentido na maioria dos casos.

**Opcional nullable** — use quando a ausência do parâmetro tem significado diferente de um valor padrão.

```dart
void enviarEmail({
  required String destinatario,   // sempre obrigatório
  required String assunto,        // sempre obrigatório
  String corpo = '',              // opcional, padrão vazio
  bool html = false,              // opcional, padrão false
  String? cc,                     // opcional, null = sem cópia
}) { }
```

**Regra prática**: se a função não pode funcionar sem o parâmetro, use `required`. Se tem um valor padrão razoável, use valor padrão. Se null tem significado próprio, use nullable.

---

## 6. O que são parâmetros nomeados em uma função?

**Pergunta feita à IA:**
> O que são parâmetros nomeados em uma função?

**Resposta da IA:**

Parâmetros nomeados são parâmetros identificados pelo nome ao chamar a função, não pela posição. No Dart, são declarados com `{}`.

```dart
// parâmetros posicionais — a ordem importa
void somar(int a, int b) => print(a + b);
somar(3, 5); // precisa passar na ordem certa

// parâmetros nomeados — a ordem não importa
void apresentar({required String nome, required int idade}) {
  print('$nome tem $idade anos');
}
apresentar(idade: 25, nome: 'Carlos'); // pode inverter a ordem
```

**Vantagens:**
- Chamadas mais legíveis, especialmente com muitos parâmetros.
- Não precisa lembrar a ordem.
- Comum em Flutter: `Text('oi', style: ..., textAlign: ...)`.

---

## 7. Quais métodos existem para variáveis do tipo `Function` em Dart?

**Pergunta feita à IA:**
> Quais métodos existem para variáveis do tipo Function em dart?

**Resposta da IA:**

O tipo `Function` em Dart é relativamente simples — não tem muitos métodos utilitários como List ou String. O principal uso é armazenar e chamar funções como valores.

| O que dá pra fazer | Como |
|---|---|
| Armazenar uma função em variável | `Function minhaFn = somar;` |
| Chamar a função armazenada | `minhaFn(2, 3)` |
| Passar função como parâmetro | `void executar(Function fn) { fn(); }` |
| Verificar se é uma função | `minhaFn is Function` |
| Usar typedef para nomear o tipo | `typedef Operacao = int Function(int, int);` |

**Observação**: o ideal é evitar o tipo `Function` genérico e usar assinaturas específicas com `typedef` ou inline, para que o compilador possa verificar os tipos dos parâmetros.

---

## 8. Diferença entre `olaMundo` e `olaMundo()` em Dart

**Pergunta feita à IA:**
> Qual a diferença entre chamar minha função chamado olaMundo das seguintes formas "olaMundo" e "olaMundo()".

**Resposta da IA:**

- **`olaMundo`** — é uma **referência** à função. Você está passando a função como valor, sem executá-la.
- **`olaMundo()`** — é a **chamada** da função. Ela é executada na hora.

```dart
void olaMundo() {
  print('Olá, mundo!');
}

void main() {
  var referencia = olaMundo;   // guarda a função, não executa
  referencia();                // agora executa

  olaMundo();                  // executa direto
}
```

**Uso prático:**
```dart
// passando a função como parâmetro (sem parênteses)
botao.aoClicar = olaMundo;

// executando na hora (com parênteses)
botao.aoClicar = olaMundo();  // ERRADO — executa agora e passa o retorno (void)
```


---

## 9. Exemplos de função tratando strings com diferentes métodos

**Pergunta feita à IA:**
> Mostre exemplos de uma função tratando strings com seus diferentes métodos.

**Resposta da IA:**

```dart
// formata um nome completo
String formatarNome(String nome) {
  return nome.trim().toLowerCase().split(' ').map((palavra) {
    if (palavra.isEmpty) return '';
    return palavra[0].toUpperCase() + palavra.substring(1);
  }).join(' ');
}

print(formatarNome('  joÃO da silVA  ')); // João Da Silva


// valida se um email tem formato básico
bool emailValido(String email) {
  email = email.trim().toLowerCase();
  return email.contains('@') && email.contains('.');
}


// mascara um CPF
String mascararCpf(String cpf) {
  cpf = cpf.replaceAll(RegExp(r'\D'), ''); // remove não-dígitos
  if (cpf.length != 11) return 'CPF inválido';
  return '${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.${cpf.substring(6, 9)}-${cpf.substring(9)}';
}

print(mascararCpf('12345678901')); // 123.456.789-01
```


---

## 10. Exemplos de mau uso de funções

**Pergunta feita à IA:**
> Traga exemplos de mau uso de funções.

**Resposta da IA:**

```dart
// 1. função que faz coisas demais
void processarPedido(Pedido p) {
  // valida dados
  // calcula frete
  // aplica desconto
  // salva no banco
  // envia email
  // atualiza estoque
  // gera nota fiscal
}
// deveria ser 6-7 funções menores


// 2. nome que não diz nada
void fazer(String x) { ... }
void processar(int n) { ... }


// 3. parâmetro boolean que muda comportamento completamente
void salvar(Produto p, bool atualizar) {
  if (atualizar) { /* lógica A */ }
  else { /* lógica B completamente diferente */ }
}
// melhor: duas funções separadas — criarProduto() e atualizarProduto()


// 4. retornar null sem avisar
String buscarNome(int id) {
  // ...
  return null; // surpresa pra quem chama
}
// use String? no retorno ou lance uma exceção


// 5. efeito colateral escondido
int calcularTotal(List<int> valores) {
  valores.clear(); // ninguém esperava isso
  return 0;
}
```

---

## 11. Como organizar funções no código?

**Pergunta feita à IA:**
> Como organizar minhas funções no código?

**Resposta da IA:**

- **Agrupe por responsabilidade**: funções relacionadas ficam juntas — funções de validação num lugar, de formatação em outro, de cálculo em outro.
- **Ordem sugerida dentro de um arquivo**:
  1. Função principal / ponto de entrada
  2. Funções públicas
  3. Funções privadas (prefixo `_` em Dart)
- **Use arquivos separados para contextos diferentes**: `validacoes.dart`, `formatadores.dart`, `calculos.dart`.
- **Funções pequenas e auxiliares perto de quem as usa**: se uma função só faz sentido dentro de um contexto específico, mantenha próxima.
- **Evite funções soltas sem contexto**: em Dart, diferente de Java, funções podem existir fora de classes — mas isso não significa que devem ficar espalhadas sem organização.

---
