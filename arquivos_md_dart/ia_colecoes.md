# IA como apoio – Coleções em Dart

Atividade da Lince Tech Academy sobre listas, sets e mapas em Dart.

---

## 1. Quais as boas práticas no uso de listas em Dart?

**Pergunta feita à IA:**
> Quais as boas práticas no uso de listas em dart?

**Resposta da IA:**

- **Prefira `final` para listas que não serão reatribuídas**: `final List<String> nomes = []` impede que a variável aponte para outra lista, mesmo que a lista em si possa ser modificada.
- **Tipar sempre que possível**: Use `List<String>` em vez de `List` sem tipo. O Dart vai reclamar em tempo de compilação se você tentar inserir algo errado.
- **Use literais de lista**: `var lista = [1, 2, 3]` é preferível a `var lista = List<int>()` seguido de `.add()` repetidos.
- **Evite listas muito grandes em memória**: Se a lista pode crescer muito, considere estruturas mais adequadas ou processar em partes.
- **Use `const` para listas imutáveis fixas**: `const dias = ['Seg', 'Ter', 'Qua']` garante que ninguém vai adicionar ou remover itens.
- **Nomes no plural**: `usuarios`, `produtos`, `itens` — deixa claro que é uma coleção.


---

## 2. Que práticas posso adotar para trazer melhor performance ao usar listas em Dart?

**Pergunta feita à IA:**
> Que práticas posso adotar para trazer uma melhor performance ao usar listas em dart?

**Resposta da IA:**

- **Defina a capacidade inicial se souber o tamanho**: `List.filled(100, 0)` ou `List.generate(n, ...)` evitam realocações de memória.
- **Evite `add()` em loop quando possível**: Prefira `addAll()` ou spread operator `[...lista1, ...lista2]` para combinar listas.
- **Use `where()` e `map()` com lazy evaluation**: Eles retornam `Iterable`, não uma nova lista. Só adicione `.toList()` se realmente precisar materializar.
- **Evite acessar `length` repetidamente dentro de loops**: Guarde em variável se for usar várias vezes.
- **Prefira `for` tradicional ao `forEach` em loops críticos**: O `for` tende a ser mais performático em operações intensas.
- **Use `List.unmodifiable()` para proteger listas expostas em APIs**: Evita que quem recebe a lista a modifique por engano.


---

## 3. O que não é recomendado fazer quando usando listas em Dart?

**Pergunta feita à IA:**
> O que não é recomendado fazer quando usado listas em dart?

**Resposta da IA:**

- **Acessar índices sem verificar o tamanho**: `lista[5]` em uma lista de 3 elementos lança `RangeError`. Sempre verifique com `lista.length` ou use `elementAtOrNull`.
- **Modificar uma lista enquanto itera sobre ela**: Adicionar ou remover itens dentro de um `for` pode causar comportamento inesperado ou exceções.
- **Usar listas para dados com chave**: Se você precisa buscar um item pelo nome ou id, use um `Map`. Iterar a lista inteira para achar um elemento é ineficiente.
- **Criar listas desnecessariamente**: Chamar `.toList()` em todo `Iterable` sem precisar de uma lista concreta desperdiça memória.
- **Ignorar nullability em listas**: `List<String?>` e `List<String>` são coisas diferentes. Misturar sem cuidado gera erros.


---

## 4. Como entender quando usar listas e quando usar mapas?

**Pergunta feita à IA:**
> Como entender quando usar listas e quando usar mapas?

**Resposta da IA:**

| Cenário | Use |
|---|---|
| Sequência ordenada de itens | `List` |
| Busca por posição (índice) | `List` |
| Associar uma chave a um valor | `Map` |
| Busca rápida por identificador | `Map` |
| Dados sem identificador único | `List` |
| Configurações, atributos de um objeto | `Map` |

**Regra prática:** se você precisa perguntar "qual é o item na posição X", use List. Se a pergunta é "qual é o valor para a chave X", use Map.



---

## 5. Em Dart, quais práticas são interessantes no uso de mapas?

**Pergunta feita à IA:**
> Em dart quais práticas são interessantes no uso de mapas.

**Resposta da IA:**

- **Tipar o Map**: `Map<String, int>` é muito melhor que `Map`. Deixa claro o que entra e o que sai.
- **Use `map['chave'] ?? valorPadrao`**: Acessar uma chave inexistente retorna `null`. O operador `??` evita erros.
- **Prefira `containsKey()` antes de acessar**: Se não tem certeza se a chave existe, verifique primeiro.
- **Use `putIfAbsent()`**: Adiciona um valor apenas se a chave não existir ainda — evita sobrescrever dados acidentalmente.
- **`Map.fromIterable()` ou `Map.fromEntries()`**: Formas eficientes de criar mapas a partir de outras coleções.
- **Evite mapas aninhados demais**: `Map<String, Map<String, Map<String, int>>>` vira pesadelo. Crie classes para representar estruturas complexas.



---

## 6. Quais métodos podem me auxiliar no uso de listas e sets em Dart?

**Pergunta feita à IA:**
> Quais métodos podem me auxiliar no uso de listas e sets em dart?

**Resposta da IA:**

**Listas:**

| Método | O que faz |
|---|---|
| `add(item)` | Adiciona um item ao final |
| `addAll(lista)` | Adiciona vários itens |
| `remove(item)` | Remove a primeira ocorrência |
| `removeAt(index)` | Remove pelo índice |
| `contains(item)` | Verifica se o item existe |
| `indexOf(item)` | Retorna o índice do item |
| `sort()` | Ordena a lista |
| `reversed` | Retorna um Iterable invertido |
| `map(fn)` | Transforma cada elemento |
| `where(fn)` | Filtra elementos |
| `any(fn)` | Verdadeiro se algum satisfaz a condição |
| `every(fn)` | Verdadeiro se todos satisfazem |
| `reduce(fn)` | Combina todos os elementos em um |
| `fold(init, fn)` | Como reduce, mas com valor inicial |
| `first` / `last` | Primeiro e último elemento |
| `isEmpty` / `isNotEmpty` | Verifica se está vazia |

**Sets:**

| Método | O que faz |
|---|---|
| `add(item)` | Adiciona (ignora se já existir) |
| `contains(item)` | Verifica existência (mais rápido que em List) |
| `union(set)` | União de dois sets |
| `intersection(set)` | Interseção |
| `difference(set)` | Diferença |
| `toList()` | Converte para lista |


---

## 7. Quais cuidados devo ter ao usar sets?

**Pergunta feita à IA:**
> Quais cuidados devo levar ao usar sets?

**Resposta da IA:**

- **Sets não garantem ordem**: A ordem de inserção pode ou não ser preservada dependendo da implementação. Não dependa de ordem em um Set.
- **Elementos precisam ser únicos e comparáveis**: Para objetos customizados, você precisa sobrescrever `==` e `hashCode`, senão o Set não vai conseguir detectar duplicatas corretamente.
- **`Set` literal vs `Set()` construtor**: `{}` vazio cria um `Map`, não um `Set`! Use `<String>{}` ou `Set<String>()` para criar um Set vazio.
- **Não é indexado**: Você não pode fazer `meuSet[0]`. Se precisar de acesso por índice, converta para lista.
- **Cuidado ao converter List para Set para remover duplicatas**: A ordem original da lista pode ser perdida.



---

## 8. Documentação do método `elementAtOrNull`

**Pergunta feita à IA:**
> Traga a documentação do método elementaAtOrNull.

**Resposta da IA:**

**`elementAtOrNull(int index)`**

- **Disponível em**: `Iterable` (e por herança, `List`, `Set`, etc.)
- **Retorno**: O elemento no índice fornecido, ou `null` se o índice estiver fora dos limites.
- **Assinatura**: `E? elementAtOrNull(int index)`

É uma alternativa segura ao acesso direto por índice `lista[index]`, que lança `RangeError` quando o índice não existe.

```dart
List<String> frutas = ['maçã', 'banana', 'uva'];

print(frutas.elementAtOrNull(1)); // banana
print(frutas.elementAtOrNull(5)); // null  (sem exceção)
```

**Quando usar**: sempre que você não tiver certeza se o índice existe e quiser evitar try/catch ou verificação manual de `length`.


---

## 9. Cenários favoráveis ao uso de Set e listas em Dart

**Pergunta feita à IA:**
> Mostre cenários favoráveis ao uso de set e listas em dart.

**Resposta da IA:**

**Use List quando:**
```dart
// Ranking de pontuações (ordem importa)
List<int> pontuacoes = [980, 750, 430, 430, 210];

// Histórico de ações do usuário (sequência importa)
List<String> historico = ['login', 'abriu_produto', 'adicionou_carrinho'];

// Itens de um carrinho de compras (pode ter repetidos)
List<String> carrinho = ['camiseta', 'camiseta', 'calça'];
```

**Use Set quando:**
```dart
// Tags de um post (sem repetição, ordem não importa)
Set<String> tags = {'dart', 'flutter', 'mobile'};

// Usuários que curtiram um post (cada um aparece uma vez)
Set<String> curtidas = {'user1', 'user2', 'user3'};

// Verificar permissões (busca rápida)
Set<String> permissoes = {'leitura', 'escrita'};
if (permissoes.contains('escrita')) { ... }
```


---

## 10. Exemplos de uso do método `map` em mapas do Dart

**Pergunta feita à IA:**
> Traga exemplos de uso do método map da estrutura de mapas do dart.

**Resposta da IA:**

O método `map()` em um `Map` transforma cada entrada (chave e valor) e retorna um novo `Map`.

```dart
// Dobrar todos os valores
Map<String, int> precos = {'maçã': 2, 'banana': 3, 'uva': 5};

Map<String, int> precosReajustados = precos.map(
  (chave, valor) => MapEntry(chave, valor * 2),
);
print(precosReajustados); // {maçã: 4, banana: 6, uva: 10}


// Converter chaves para maiúsculo
Map<String, int> comChaveMaiuscula = precos.map(
  (chave, valor) => MapEntry(chave.toUpperCase(), valor),
);
print(comChaveMaiuscula); // {MAÇÃ: 2, BANANA: 3, UVA: 5}


// Transformar valor em String formatada
Map<String, String> precosFormatados = precos.map(
  (chave, valor) => MapEntry(chave, 'R\$ $valor,00'),
);
print(precosFormatados); // {maçã: R$ 2,00, banana: R$ 3,00, uva: R$ 5,00}
```


---

## 11. Como iterar de forma eficiente em listas

**Pergunta feita à IA:**
> Como iterar de forma eficiente em listas.

**Resposta da IA:**

**Formas de iterar:**

```dart
List<int> numeros = [1, 2, 3, 4, 5];

// 1. for clássico — melhor performance, acesso ao índice
for (int i = 0; i < numeros.length; i++) {
  print(numeros[i]);
}

// 2. for-in — mais legível quando não precisa do índice
for (int n in numeros) {
  print(n);
}

// 3. forEach — funcional, mas sem break/continue
numeros.forEach((n) => print(n));

// 4. map + toList — para transformar
List<int> dobrados = numeros.map((n) => n * 2).toList();

// 5. where — para filtrar
List<int> pares = numeros.where((n) => n % 2 == 0).toList();
```

**Dicas de eficiência:**
- Evite `forEach` se precisar de `break` ou `continue` — use `for-in`.
- Encadeie `where().map()` antes de chamar `.toList()` para não criar listas intermediárias.
- Para listas grandes, prefira `for` clássico ao `forEach`.


---

