# IA como apoio – Flutter: Programação Assíncrona

Atividade da Lince Tech Academy sobre Future, requisições HTTP, JSON e boas práticas assíncronas.

---

## 1. O que é programação assíncrona em Flutter e por que ela é importante?

**Pergunta feita à IA:**
> O que é programação assíncrona em Flutter e por que ela é importante?

**Resposta da IA:**

Flutter roda numa única thread (a UI thread). Se uma operação demorada — como buscar dados de uma API — rodar de forma síncrona, ela trava essa thread e congela a interface enquanto espera. O usuário vê o app travado.

Programação assíncrona permite iniciar essa operação e liberar a thread para continuar renderizando a UI. Quando o resultado chega, o app é notificado e atualiza a tela.

```dart
// síncrono — trava a UI
String dados = buscarDadosSincrono(); // UI congela aqui

// assíncrono — UI continua respondendo
String dados = await buscarDadosAsync(); // UI livre enquanto espera
```

Em Flutter isso é especialmente crítico porque qualquer travamento de mais de ~16ms já causa queda de frames visível para o usuário.

---

## 2. Quais cuidados devo ter usando programação assíncrona?

**Pergunta feita à IA:**
> Quais cuidados devo ter usando programação assíncrona?

**Resposta da IA:**

- **Verifique `mounted` antes de chamar `setState` após um `await`**: o widget pode ter sido descartado enquanto a operação acontecia.
```dart
final dados = await buscar();
if (!mounted) return;
setState(() => _dados = dados);
```

- **Sempre trate erros com `try/catch`**: operações assíncronas podem falhar — sem tratamento, o erro é silencioso ou derruba o app.

- **Não chame `setState` dentro de `initState` diretamente**: inicie a operação em `initState` mas só chame `setState` quando o Future completar.

- **Evite Futures não aguardados**: chamar uma função `async` sem `await` significa que erros podem ser perdidos.

- **Controle o estado de carregamento**: mostre um indicador enquanto aguarda e trate o estado de erro separadamente.

---

## 3. O que são isolates em Flutter?

**Pergunta feita à IA:**
> O que são isolates em flutter?

**Resposta da IA:**

Dart é single-thread por padrão, mas oferece **isolates** para rodar código em paralelo de verdade. Cada isolate tem sua própria memória e thread — eles não compartilham estado, comunicando-se apenas por mensagens.

São úteis para tarefas CPU-intensivas que travariam a UI mesmo com `async/await`:
- Processar imagens grandes
- Parsear JSONs enormes
- Cálculos matemáticos pesados
- Compressão de arquivos

```dart
import 'dart:isolate';

void tarefaPesada(SendPort sendPort) {
  // roda em thread separada
  int resultado = 0;
  for (int i = 0; i < 1000000000; i++) resultado += i;
  sendPort.send(resultado);
}

void main() async {
  final receivePort = ReceivePort();
  await Isolate.spawn(tarefaPesada, receivePort.sendPort);
  final resultado = await receivePort.first;
  print(resultado);
}
```

O Flutter também oferece `compute()` como atalho para casos simples.

---

## 4. Quais cuidados devo ter ao usar isolates em Flutter?

**Pergunta feita à IA:**
> Quais cuidados devo ter ao usar isolates em Flutter?

**Resposta da IA:**

- **Não acesse o estado do widget a partir de um isolate**: isolates não têm acesso à UI thread. Toda comunicação é via mensagens.
- **Dados passados entre isolates são copiados, não compartilhados**: objetos grandes podem ter custo de cópia considerável.
- **Use `compute()` para casos simples**: é mais fácil que criar isolates manualmente e cobre a maioria dos casos.
- **Não crie isolates para operações de I/O**: requisições de rede, leitura de arquivo — o `async/await` já é suficiente e mais simples. Isolates são para CPU, não para espera.
- **Termine o isolate quando não precisar mais**: isolates consomem recursos e não são coletados automaticamente.

---

## 5. Qual o conceito do Loop de Eventos em Flutter?

**Pergunta feita à IA:**
> Qual o conceito do Loop de Eventos em flutter?

**Resposta da IA:**

O Dart usa um **Event Loop** (loop de eventos) para gerenciar a execução assíncrona numa única thread. Funciona com duas filas:

- **Event Queue** — eventos externos: toques na tela, I/O completado, timers disparados, mensagens de isolate.
- **Microtask Queue** — tarefas internas de alta prioridade, como callbacks de `Future.then()`.

O loop processa assim:
1. Executa o código síncrono atual até o fim.
2. Esvazia toda a Microtask Queue.
3. Pega o próximo evento da Event Queue e executa.
4. Repete.

Por isso `await` não bloqueia a thread — ele registra uma microtask para continuar depois que o Future completar, liberando o loop para processar outros eventos enquanto espera.

---

## 6. O que é um Future em Dart e como ele funciona?

**Pergunta feita à IA:**
> O que é um 'Future' em Dart e como ele funciona?

**Resposta da IA:**

`Future<T>` representa um valor que estará disponível no futuro. Pode completar com um valor do tipo `T` ou com um erro.

```dart
Future<String> buscarNome() async {
  await Future.delayed(Duration(seconds: 1));
  return 'João';
}

// usando await
void main() async {
  String nome = await buscarNome();
  print(nome); // João
}

// usando .then/.catchError
buscarNome()
  .then((nome) => print(nome))
  .catchError((e) => print('erro: $e'));
```

Um Future pode estar em três estados: pendente, completado com valor, ou completado com erro. Uma vez completado, não muda mais.

---

## 7. Como usar async e await para trabalhar com Futures?

**Pergunta feita à IA:**
> Como posso usar 'async' e 'await' para trabalhar com 'Futures'?

**Resposta da IA:**

`async` marca uma função como assíncrona — ela passa a retornar um `Future` automaticamente. `await` pausa a execução da função até o Future completar, sem bloquear a thread.

```dart
Future<List<String>> buscarLista() async {
  await Future.delayed(Duration(seconds: 2));
  return ['item 1', 'item 2', 'item 3'];
}

Future<void> carregarDados() async {
  print('buscando...');
  final lista = await buscarLista(); // aguarda aqui
  print('recebido: $lista');

  // pode encadear awaits
  final processado = await processarLista(lista);
  print(processado);
}
```

Funções `async` sempre retornam `Future`, mesmo que você escreva `void`. Se escrever `async` e retornar `String`, o tipo real é `Future<String>`.

---

## 8. Como lidar com erros em operações assíncronas com try-catch?

**Pergunta feita à IA:**
> Como posso lidar com erros em operações assíncronas usando 'try-catch'?

**Resposta da IA:**

`try/catch` funciona normalmente com `async/await`:

```dart
Future<void> carregarUsuario(int id) async {
  try {
    final response = await http.get(Uri.parse('https://api.exemplo.com/users/$id'));

    if (response.statusCode != 200) {
      throw Exception('Erro ${response.statusCode}');
    }

    final dados = jsonDecode(response.body);
    setState(() => _usuario = Usuario.fromJson(dados));

  } on SocketException {
    setState(() => _erro = 'Sem conexão com internet');
  } on TimeoutException {
    setState(() => _erro = 'Requisição expirou');
  } catch (e) {
    setState(() => _erro = 'Erro inesperado: $e');
  } finally {
    setState(() => _carregando = false);
  }
}
```

---

## 9. Explicação dos métodos HTTP

**Pergunta feita à IA:**
> Traga a explicação dos métodos HTTP.

**Resposta da IA:**

| Método | Uso | Corpo? |
|---|---|---|
| `GET` | Buscar dados | Não |
| `POST` | Criar um recurso | Sim |
| `PUT` | Substituir um recurso completo | Sim |
| `PATCH` | Atualizar parte de um recurso | Sim |
| `DELETE` | Remover um recurso | Não (geralmente) |

```dart
// GET
final res = await http.get(Uri.parse('$baseUrl/produtos'));

// POST
final res = await http.post(
  Uri.parse('$baseUrl/produtos'),
  headers: {'Content-Type': 'application/json'},
  body: jsonEncode({'nome': 'Camiseta', 'preco': 49.90}),
);

// PUT
final res = await http.put(
  Uri.parse('$baseUrl/produtos/1'),
  headers: {'Content-Type': 'application/json'},
  body: jsonEncode({'nome': 'Camiseta P', 'preco': 44.90}),
);

// DELETE
final res = await http.delete(Uri.parse('$baseUrl/produtos/1'));
```

---

## 10. Como lidar com diferentes códigos de resposta HTTP?

**Pergunta feita à IA:**
> Como posso lidar com diferentes códigos de resposta HTTP (200, 404, 500)?

**Resposta da IA:**

```dart
Future<Produto> buscarProduto(int id) async {
  final response = await http.get(Uri.parse('$baseUrl/produtos/$id'));

  switch (response.statusCode) {
    case 200:
      return Produto.fromJson(jsonDecode(response.body));
    case 404:
      throw Exception('Produto não encontrado');
    case 401:
      throw Exception('Não autorizado — faça login novamente');
    case 500:
      throw Exception('Erro interno do servidor');
    default:
      throw Exception('Erro inesperado: ${response.statusCode}');
  }
}
```

Faixas de status:
- `2xx` — sucesso
- `3xx` — redirecionamento
- `4xx` — erro do cliente (dados errados, não autorizado, não encontrado)
- `5xx` — erro do servidor

---

## 11. O que é JSON e como ele é usado em Flutter?

**Pergunta feita à IA:**
> O que é JSON e como ele é usado em Flutter?

**Resposta da IA:**

JSON (JavaScript Object Notation) é um formato de texto para troca de dados entre sistemas. É o formato mais comum em APIs REST.

```json
{
  "id": 1,
  "nome": "João Silva",
  "email": "joao@email.com",
  "ativo": true
}
```

Em Flutter, o pacote `dart:convert` converte entre JSON string e objetos Dart:

```dart
import 'dart:convert';

// string JSON → Map Dart
final Map<String, dynamic> mapa = jsonDecode('{"nome": "João", "idade": 25}');
print(mapa['nome']); // João

// Map Dart → string JSON
final String json = jsonEncode({'nome': 'Maria', 'idade': 30});
print(json); // {"nome":"Maria","idade":30}
```

---

## 12. Como acessar valores específicos em um objeto JSON?

**Pergunta feita à IA:**
> Como posso acessar valores específicos em um objeto JSON?

**Resposta da IA:**

Após o `jsonDecode`, você tem um `Map<String, dynamic>` e acessa por chave:

```dart
final json = jsonDecode('''
{
  "usuario": {
    "nome": "Ana",
    "endereco": {
      "cidade": "Blumenau",
      "estado": "SC"
    }
  }
}
''');

// acesso direto
print(json['usuario']['nome']); // Ana

// acesso aninhado
print(json['usuario']['endereco']['cidade']); // Blumenau

// com null safety
final cidade = json['usuario']?['endereco']?['cidade'] ?? 'cidade não informada';
```

---

## 13. Como lidar com arrays (listas) em JSON em Flutter?

**Pergunta feita à IA:**
> Como posso lidar com arrays (listas) em JSON em Flutter?

**Resposta da IA:**

Arrays JSON viram `List<dynamic>` no Dart após o `jsonDecode`:

```dart
final json = jsonDecode('''
[
  {"id": 1, "nome": "Produto A"},
  {"id": 2, "nome": "Produto B"},
  {"id": 3, "nome": "Produto C"}
]
''');

// json é uma List<dynamic>
final List<dynamic> lista = json;
print(lista.length); // 3

// acessar item específico
print(lista[0]['nome']); // Produto A

// converter para lista tipada
final produtos = lista.map((item) => Produto.fromJson(item)).toList();
```

---

## 14. Como iterar sobre os elementos de um array JSON?

**Pergunta feita à IA:**
> Como posso iterar sobre os elementos de um array JSON?

**Resposta da IA:**

```dart
final response = await http.get(Uri.parse('$baseUrl/produtos'));
final List<dynamic> lista = jsonDecode(response.body);

// for-in
for (final item in lista) {
  print(item['nome']);
}

// map para converter
final produtos = lista.map((item) => Produto.fromJson(item)).toList();

// where para filtrar
final ativos = lista
    .where((item) => item['ativo'] == true)
    .map((item) => Produto.fromJson(item))
    .toList();
```

---

## 15. Por que é útil mapear JSON para classes Dart?

**Pergunta feita à IA:**
> Por que é útil mapear JSON para classes Dart?

**Resposta da IA:**

Trabalhar com `Map<String, dynamic>` o tempo todo é frágil — uma chave errada ou um tipo inesperado só estoura em runtime. Mapear para classes Dart traz:

- **Tipagem**: o compilador verifica os tipos.
- **Autocomplete**: a IDE sugere os campos da classe.
- **Refatoração segura**: renomear um campo na classe é detectado em toda a base de código.
- **Lógica encapsulada**: métodos como `nomeCompleto`, validações e formatações ficam na classe.
- **Código mais legível**: `usuario.nome` é mais claro que `dados['usuario']['nome']`.

---

## 16. Como usar factory para criar objetos Dart a partir de JSON?

**Pergunta feita à IA:**
> Como posso usar 'factory' para criar objetos Dart a partir de JSON?

**Resposta da IA:**

O padrão `fromJson` com `factory constructor` é o mais comum em Flutter:

```dart
class Produto {
  final int id;
  final String nome;
  final double preco;
  final bool disponivel;

  Produto({
    required this.id,
    required this.nome,
    required this.preco,
    required this.disponivel,
  });

  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      id: json['id'] as int,
      nome: json['nome'] as String,
      preco: (json['preco'] as num).toDouble(),
      disponivel: json['disponivel'] as bool? ?? true,
    );
  }
}

// uso
final response = await http.get(Uri.parse('$baseUrl/produtos/1'));
final produto = Produto.fromJson(jsonDecode(response.body));
print(produto.nome);
```

---

## 17. Como usar toJson() para converter objetos Dart em JSON?

**Pergunta feita à IA:**
> Como posso usar 'toJson()' para converter objetos Dart em JSON?

**Resposta da IA:**

Adiciona-se um método `toJson()` que retorna um `Map<String, dynamic>`:

```dart
class Produto {
  final int id;
  final String nome;
  final double preco;

  Produto({required this.id, required this.nome, required this.preco});

  factory Produto.fromJson(Map<String, dynamic> json) => Produto(
    id: json['id'],
    nome: json['nome'],
    preco: (json['preco'] as num).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'preco': preco,
  };
}

// enviar via POST
final produto = Produto(id: 0, nome: 'Tênis', preco: 199.90);

await http.post(
  Uri.parse('$baseUrl/produtos'),
  headers: {'Content-Type': 'application/json'},
  body: jsonEncode(produto.toJson()),
);
```

---

## 18. Como organizar as requisições no código Flutter?

**Pergunta feita à IA:**
> Como organizar minhas requisições no meu código Flutter?

**Resposta da IA:**

A abordagem mais comum é criar classes de serviço separadas por entidade:

```
lib/
  models/
    produto.dart
  services/
    produto_service.dart
    auth_service.dart
  screens/
    produtos_screen.dart
```

```dart
// produto_service.dart
class ProdutoService {
  static const _baseUrl = 'https://api.exemplo.com';
  final _client = http.Client();

  Future<List<Produto>> listar() async {
    final response = await _client.get(Uri.parse('$_baseUrl/produtos'));
    if (response.statusCode != 200) throw Exception('Erro ao listar produtos');
    final List lista = jsonDecode(response.body);
    return lista.map((j) => Produto.fromJson(j)).toList();
  }

  Future<Produto> buscarPorId(int id) async {
    final response = await _client.get(Uri.parse('$_baseUrl/produtos/$id'));
    if (response.statusCode == 404) throw Exception('Produto não encontrado');
    if (response.statusCode != 200) throw Exception('Erro ${response.statusCode}');
    return Produto.fromJson(jsonDecode(response.body));
  }

  Future<void> criar(Produto produto) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/produtos'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(produto.toJson()),
    );
    if (response.statusCode != 201) throw Exception('Erro ao criar produto');
  }
}
```

A tela só usa o serviço — sem lógica de HTTP direto no widget.

---

## 19. Boas práticas realizando requisições

**Pergunta feita à IA:**
> Quais as boas práticas realizando requisições?

**Resposta da IA:**

- **Separe a camada de serviço dos widgets**: widgets não devem ter `http.get` direto.
- **Sempre trate erros**: nunca deixe um Future de requisição sem `try/catch`.
- **Configure timeout**: requisições sem timeout podem ficar pendentes para sempre.
```dart
await http.get(url).timeout(const Duration(seconds: 10));
```
- **Use `http.Client()` e feche-o**: reutilizar o client é mais eficiente que criar um novo a cada chamada. Chame `client.close()` no `dispose`.
- **Não exponha a URL base espalhada**: centralize em uma constante ou variável de ambiente.
- **Trate os status codes**: não assuma que toda resposta é sucesso.
- **Controle o estado de loading e erro no widget**: exiba feedback visual adequado para cada estado.

---

## 20. Como exibir mensagem de carregamento durante uma requisição HTTP?

**Pergunta feita à IA:**
> Como posso exibir uma mensagem de carregamento enquanto a requisição HTTP está em andamento?

**Resposta da IA:**

```dart
class ProdutosScreen extends StatefulWidget {
  const ProdutosScreen({super.key});
  @override
  State<ProdutosScreen> createState() => _ProdutosScreenState();
}

class _ProdutosScreenState extends State<ProdutosScreen> {
  List<Produto> _produtos = [];
  bool _carregando = true;
  String? _erro;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  Future<void> _carregar() async {
    try {
      final lista = await ProdutoService().listar();
      if (!mounted) return;
      setState(() {
        _produtos = lista;
        _carregando = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _erro = e.toString();
        _carregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_carregando) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (_erro != null) {
      return Scaffold(
        body: Center(child: Text('Erro: $_erro')),
      );
    }
    return Scaffold(
      body: ListView.builder(
        itemCount: _produtos.length,
        itemBuilder: (_, i) => ListTile(title: Text(_produtos[i].nome)),
      ),
    );
  }
}
```

---

## 21. Exemplos de consumo de APIs em Flutter

**Pergunta feita à IA:**
> De exemplos de consumo a API's em Flutter?

**Resposta da IA:**

**Exemplo com JSONPlaceholder (API pública de testes):**

```dart
class Post {
  final int id;
  final String titulo;
  final String corpo;

  Post({required this.id, required this.titulo, required this.corpo});

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json['id'],
    titulo: json['title'],
    corpo: json['body'],
  );
}

class PostService {
  Future<List<Post>> buscarPosts() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'))
        .timeout(const Duration(seconds: 10));

    if (response.statusCode != 200) {
      throw Exception('Falha ao buscar posts');
    }

    final List lista = jsonDecode(response.body);
    return lista.map((j) => Post.fromJson(j)).toList();
  }
}

// na tela
class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});
  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  late Future<List<Post>> _posts;

  @override
  void initState() {
    super.initState();
    _posts = PostService().buscarPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: FutureBuilder<List<Post>>(
        future: _posts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }
          final posts = snapshot.data!;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (_, i) => ListTile(
              title: Text(posts[i].titulo),
              subtitle: Text(posts[i].corpo, maxLines: 2, overflow: TextOverflow.ellipsis),
            ),
          );
        },
      ),
    );
  }
}
```

`FutureBuilder` é uma alternativa ao controle manual de estado de loading — ele gerencia os estados `waiting`, `done` e `error` automaticamente.
