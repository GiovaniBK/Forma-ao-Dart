# IA como apoio – Flutter: Gerenciamento de Estados

Atividade da Lince Tech Academy sobre Provider, ChangeNotifierProvider e Consumer.

---

## 1. O que é gerenciamento de estados em Flutter e por que é importante?

**Pergunta feita à IA:**
> O que é gerenciamento de estados em Flutter e por que é importante?

**Resposta da IA:**

Estado é qualquer dado que pode mudar e que afeta o que é exibido na tela — itens de um carrinho, usuário logado, tema do app, lista de produtos carregados de uma API.

Gerenciar estado significa controlar onde esse dado vive, como ele muda e como a UI é notificada para atualizar. Em apps pequenos, `setState` local resolve. Mas quando o mesmo dado precisa ser acessado por várias telas e widgets distantes na árvore, passar tudo via construtor fica insustentável — esse problema é chamado de "prop drilling".

Gerenciadores de estado resolvem isso centralizando os dados e notificando automaticamente só os widgets que dependem do que mudou.

---

## 2. Qual a diferença entre estado local e estado global?

**Pergunta feita à IA:**
> Qual a diferença entre estado local e estado global em um aplicativo Flutter?

**Resposta da IA:**

- **Estado local** — pertence a um widget específico. Só aquele widget (e seus filhos diretos) precisa saber sobre ele. Gerenciado com `setState`. Exemplos: se um campo de texto está focado, se um accordion está aberto, animação local.

- **Estado global** — precisa ser acessado por múltiplos widgets em partes diferentes da árvore. Exemplos: usuário autenticado, itens do carrinho, tema do app, dados carregados de uma API que aparecem em várias telas.

A regra: mantenha o estado o mais local possível. Só eleve para global quando realmente precisar compartilhar entre widgets distantes.

---

## 3. Quais as vantagens de usar um gerenciador de estados?

**Pergunta feita à IA:**
> Quais as vantagens de usar um gerenciador de estados em um projeto Flutter?

**Resposta da IA:**

- **Elimina prop drilling**: não precisa passar dados através de vários níveis de widgets até chegar em quem precisa.
- **Separação de responsabilidades**: a lógica de negócio fica fora dos widgets — mais fácil de testar e manter.
- **Reconstrução cirúrgica**: só os widgets que dependem do estado que mudou são reconstruídos, não a árvore inteira.
- **Compartilhamento de estado**: múltiplas telas acessam os mesmos dados sem duplicação.
- **Código mais organizado**: em projetos maiores, a separação entre UI e lógica fica muito mais clara.

---

## 4. O que é o pacote Provider em Flutter e para que ele serve?

**Pergunta feita à IA:**
> O que é o pacote Provider em Flutter e para que ele serve?

**Resposta da IA:**

Provider é o pacote oficial recomendado pela equipe do Flutter para gerenciamento de estado. Ele usa o mecanismo de `InheritedWidget` do Flutter por baixo, mas com uma API muito mais simples.

Basicamente ele permite:
1. Disponibilizar um objeto (o estado) em qualquer ponto da árvore de widgets.
2. Consumir esse objeto em qualquer widget descendente sem precisar passá-lo manualmente.
3. Notificar automaticamente os widgets consumidores quando o estado muda.

Para instalar:
```yaml
# pubspec.yaml
dependencies:
  provider: ^6.1.0
```

---

## 5. Como o Provider ajuda a evitar a reconstrução desnecessária de widgets?

**Pergunta feita à IA:**
> Como o Provider ajuda a evitar a reconstrução desnecessária de widgets?

**Resposta da IA:**

Sem Provider, chamar `setState` reconstrói o widget inteiro e todos os filhos. Com Provider, só os widgets que explicitamente consomem o estado (via `Consumer` ou `Provider.of`) são reconstruídos quando ele muda.

```dart
// apenas o Text dentro do Consumer reconstrói
// o resto da tela não é afetado
Consumer<ContadorModel>(
  builder: (context, contador, child) {
    return Text('${contador.valor}'); // só isso reconstrói
  },
)
```

O parâmetro `child` do `Consumer` é ainda mais eficiente — widgets passados como `child` nunca reconstroem, mesmo quando o estado muda:

```dart
Consumer<ContadorModel>(
  builder: (context, contador, child) {
    return Column(
      children: [
        Text('${contador.valor}'), // reconstrói
        child!, // nunca reconstrói
      ],
    );
  },
  child: const Text('esse texto nunca muda'),
)
```

---

## 6. Como o Provider simplifica o gerenciamento de estados?

**Pergunta feita à IA:**
> Como o Provider simplifica o gerenciamento de estados em Flutter?

**Resposta da IA:**

Antes do Provider (ou sem ele), para passar um dado de uma tela raiz para um widget profundo na árvore, era preciso passar via construtor em cada nível intermediário — mesmo que esses níveis não usassem o dado.

Com Provider, o dado é disponibilizado uma vez no topo e qualquer widget descendente acessa diretamente:

```dart
// disponibiliza no topo
ChangeNotifierProvider(
  create: (_) => CarrinhoModel(),
  child: const MyApp(),
)

// acessa em qualquer descendente, sem importar a profundidade
final carrinho = Provider.of<CarrinhoModel>(context);
```

Isso desacopla os widgets intermediários do dado — eles não precisam nem saber que ele existe.

---

## 7. O que é o ChangeNotifierProvider e como ele funciona?

**Pergunta feita à IA:**
> O que é o ChangeNotifierProvider e como ele funciona?

**Resposta da IA:**

`ChangeNotifierProvider` é o tipo mais comum de provider. Ele cria e disponibiliza um objeto `ChangeNotifier` para a árvore de widgets, e quando esse objeto chama `notifyListeners()`, todos os `Consumer` e `Provider.of` com `listen: true` são reconstruídos.

```dart
// 1. criar o model
class ContadorModel extends ChangeNotifier {
  int _valor = 0;
  int get valor => _valor;

  void incrementar() {
    _valor++;
    notifyListeners(); // avisa os consumidores
  }
}

// 2. disponibilizar na árvore
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ContadorModel(),
      child: const MyApp(),
    ),
  );
}
```

O `create` é chamado uma vez. O Provider gerencia o ciclo de vida do objeto, inclusive chamando `dispose()` quando o widget é removido da árvore.

---

## 8. Como fornecer um ChangeNotifier para a árvore de widgets?

**Pergunta feita à IA:**
> Como posso fornecer um ChangeNotifier para a árvore de widgets usando ChangeNotifierProvider?

**Resposta da IA:**

Para disponibilizar um único provider:
```dart
ChangeNotifierProvider(
  create: (_) => MeuModel(),
  child: const MyApp(),
)
```

Para múltiplos providers ao mesmo tempo, use `MultiProvider`:
```dart
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UsuarioModel()),
        ChangeNotifierProvider(create: (_) => CarrinhoModel()),
        ChangeNotifierProvider(create: (_) => TemaModel()),
      ],
      child: const MyApp(),
    ),
  );
}
```

Colocar no `main()` antes do `MyApp` garante que todos os widgets do app têm acesso.

---

## 9. Como atualizar o estado do aplicativo usando providers?

**Pergunta feita à IA:**
> Como posso atualizar o estado do meu aplicativo usando providers?

**Resposta da IA:**

A atualização acontece no model — você chama um método que modifica o estado e chama `notifyListeners()`. Os widgets que consomem esse provider são reconstruídos automaticamente.

```dart
class CarrinhoModel extends ChangeNotifier {
  final List<Produto> _itens = [];

  List<Produto> get itens => List.unmodifiable(_itens);
  int get quantidade => _itens.length;
  double get total => _itens.fold(0, (soma, p) => soma + p.preco);

  void adicionar(Produto produto) {
    _itens.add(produto);
    notifyListeners();
  }

  void remover(Produto produto) {
    _itens.remove(produto);
    notifyListeners();
  }

  void limpar() {
    _itens.clear();
    notifyListeners();
  }
}

// chamando de um widget
context.read<CarrinhoModel>().adicionar(produto);
```

`context.read<T>()` acessa o provider sem escutar mudanças — ideal para chamar métodos. `context.watch<T>()` acessa e escuta — reconstrói quando muda.

---

## 10. O que é o Consumer e como ele funciona?

**Pergunta feita à IA:**
> O que é o Consumer e como ele funciona?

**Resposta da IA:**

`Consumer<T>` é um widget que escuta um provider do tipo `T` e reconstrói seu `builder` sempre que o provider notifica mudanças.

```dart
Consumer<ContadorModel>(
  builder: (BuildContext context, ContadorModel contador, Widget? child) {
    // este bloco reconstrói quando notifyListeners() for chamado
    return Text('Valor: ${contador.valor}');
  },
)
```

Os três parâmetros do `builder`:
- `context` — o BuildContext normal.
- `contador` — a instância do model, já tipada.
- `child` — widget opcional que não reconstrói (passado fora do builder).

---

## 11. Como o Consumer reconstrói apenas os widgets que dependem do estado?

**Pergunta feita à IA:**
> Como o Consumer ajuda a reconstruir apenas os widgets que dependem do estado?

**Resposta da IA:**

O `Consumer` é colocado apenas ao redor do widget que precisa do estado — não ao redor de toda a tela. Isso limita o escopo da reconstrução.

```dart
Scaffold(
  appBar: AppBar(title: const Text('Loja')), // nunca reconstrói
  body: Column(
    children: [
      const BannerWidget(), // nunca reconstrói

      // só esse trecho reconstrói quando o carrinho muda
      Consumer<CarrinhoModel>(
        builder: (context, carrinho, child) {
          return Text('${carrinho.quantidade} itens no carrinho');
        },
      ),

      const CatalogoWidget(), // nunca reconstrói
    ],
  ),
)
```

Quanto menor e mais específico o `Consumer`, mais eficiente a reconstrução.

---

## 12. Como usar o Consumer para acessar o estado do ChangeNotifierProvider?

**Pergunta feita à IA:**
> Como posso usar o Consumer para acessar o estado fornecido pelo ChangeNotifierProvider?

**Resposta da IA:**

```dart
// model
class UsuarioModel extends ChangeNotifier {
  String _nome = 'Visitante';
  String get nome => _nome;

  void fazerLogin(String nome) {
    _nome = nome;
    notifyListeners();
  }
}

// widget consumidor
class Saudacao extends StatelessWidget {
  const Saudacao({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UsuarioModel>(
      builder: (context, usuario, child) {
        return Text('Olá, ${usuario.nome}!');
      },
    );
  }
}

// widget que chama ação (sem escutar)
ElevatedButton(
  onPressed: () {
    context.read<UsuarioModel>().fazerLogin('João');
  },
  child: const Text('Entrar'),
)
```

---

## 13. Qual a diferença entre Consumer e Provider.of()?

**Pergunta feita à IA:**
> Qual a diferença entre usar Consumer e Provider.of() para acessar o estado?

**Resposta da IA:**

| | `Consumer<T>` | `Provider.of<T>(context)` |
|---|---|---|
| Escopo da reconstrução | Só o builder do Consumer | O widget inteiro que chamou |
| Onde pode ser usado | Em qualquer lugar do build | Dentro do método build |
| Sintaxe | Mais verboso | Mais conciso |
| `listen: false` | Não se aplica | `Provider.of<T>(context, listen: false)` |

```dart
// Provider.of com listen: true — reconstrói o widget inteiro
final contador = Provider.of<ContadorModel>(context);

// Provider.of com listen: false — só lê, não reconstrói (para chamar métodos)
Provider.of<ContadorModel>(context, listen: false).incrementar();

// equivalente moderno mais conciso
context.watch<ContadorModel>(); // com listen
context.read<ContadorModel>();  // sem listen
```

Prefira `Consumer` quando só parte do widget precisa reconstruir. Use `context.read()` para chamar métodos sem escutar.

---

## 14. Como otimizar o uso do Consumer para evitar reconstruções desnecessárias?

**Pergunta feita à IA:**
> Como posso otimizar o uso do Consumer para evitar reconstruções desnecessárias?

**Resposta da IA:**

- **Coloque o Consumer o mais baixo possível na árvore**: quanto menor a subárvore que ele controla, menos widgets reconstroem.

- **Use o parâmetro `child`** para partes que nunca mudam:
```dart
Consumer<ContadorModel>(
  builder: (context, contador, child) {
    return Row(
      children: [
        Text('${contador.valor}'), // reconstrói
        child!,                    // não reconstrói
      ],
    );
  },
  child: const Icon(Icons.star), // construído uma vez
)
```

- **Use `Selector`** quando só uma propriedade específica do model importa:
```dart
Selector<CarrinhoModel, int>(
  selector: (_, carrinho) => carrinho.quantidade,
  builder: (context, quantidade, child) {
    return Text('$quantidade itens'); // só reconstrói se quantidade mudar
  },
)
```

`Selector` evita reconstruções quando outras propriedades do model mudam mas a selecionada não.

---

## 15. Exemplo: contador com ChangeNotifierProvider e Consumer

**Pergunta feita à IA:**
> Crie um aplicativo simples com um contador que pode ser incrementado e decrementado, usando ChangeNotifierProvider e Consumer.

**Resposta da IA:**

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// model
class ContadorModel extends ChangeNotifier {
  int _valor = 0;
  int get valor => _valor;

  void incrementar() {
    _valor++;
    notifyListeners();
  }

  void decrementar() {
    if (_valor > 0) {
      _valor--;
      notifyListeners();
    }
  }

  void resetar() {
    _valor = 0;
    notifyListeners();
  }
}

// app
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ContadorModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ContadorScreen());
  }
}

class ContadorScreen extends StatelessWidget {
  const ContadorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contador'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<ContadorModel>().resetar(),
          ),
        ],
      ),
      body: Center(
        child: Consumer<ContadorModel>(
          builder: (context, contador, child) {
            return Text(
              '${contador.valor}',
              style: const TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
            );
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'inc',
            onPressed: () => context.read<ContadorModel>().incrementar(),
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'dec',
            onPressed: () => context.read<ContadorModel>().decrementar(),
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
```

---

## 16. Exemplo: alternador de tema claro/escuro com Provider

**Pergunta feita à IA:**
> Crie um aplicativo de tema que permite ao usuário alternar entre temas claros e escuros, usando ChangeNotifierProvider e Consumer.

**Resposta da IA:**

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// model
class TemaModel extends ChangeNotifier {
  ThemeMode _modo = ThemeMode.light;
  ThemeMode get modo => _modo;
  bool get isDark => _modo == ThemeMode.dark;

  void alternar() {
    _modo = isDark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}

// app
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TemaModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Consumer aqui porque o MaterialApp precisa reagir à mudança de tema
    return Consumer<TemaModel>(
      builder: (context, tema, child) {
        return MaterialApp(
          themeMode: tema.modo,
          theme: ThemeData.light(useMaterial3: true),
          darkTheme: ThemeData.dark(useMaterial3: true),
          home: const HomeScreen(),
        );
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = context.watch<TemaModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Tema do App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              tema.isDark ? Icons.dark_mode : Icons.light_mode,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              tema.isDark ? 'Tema escuro' : 'Tema claro',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => context.read<TemaModel>().alternar(),
              icon: const Icon(Icons.swap_horiz),
              label: const Text('Alternar tema'),
            ),
          ],
        ),
      ),
    );
  }
}
```
