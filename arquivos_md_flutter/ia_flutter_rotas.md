# IA como apoio – Flutter: Rotas

Atividade da Lince Tech Academy sobre navegação com rotas anônimas, nomeadas e parâmetros.

---

## 1. O que são rotas anônimas em Flutter e como elas funcionam?

**Pergunta feita à IA:**
> O que são rotas anônimas em Flutter e como elas funcionam?

**Resposta da IA:**

Rotas anônimas são navegações onde você constrói a tela de destino diretamente no momento da chamada, sem registrá-la com um nome no `MaterialApp`. São criadas com `MaterialPageRoute` passando um `builder`.

```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const DetalheTela()),
);
```

Simples e direto — mas o destino é construído inline, o que pode dificultar a organização em apps maiores.

---

## 2. Quais métodos do Navigator são comumente utilizados?

**Pergunta feita à IA:**
> Quais métodos do Navigator, são comumente utilizados e por quê?

**Resposta da IA:**

| Método | O que faz |
|---|---|
| `Navigator.push()` | Empurra uma nova tela para a pilha |
| `Navigator.pop()` | Remove a tela atual da pilha (volta) |
| `Navigator.pushReplacement()` | Substitui a tela atual por uma nova |
| `Navigator.pushAndRemoveUntil()` | Navega e limpa a pilha até uma condição |
| `Navigator.pushNamed()` | Navega para uma rota nomeada |
| `Navigator.popUntil()` | Volta várias telas até uma condição |

`push` e `pop` são os mais básicos. `pushReplacement` é útil em fluxos de login — após logar, substituir a tela de login pela home para o usuário não conseguir voltar. `pushAndRemoveUntil` é usado para limpar toda a pilha, como no logout.

---

## 3. Qual a função do Navigator.push() na navegação com rotas anônimas?

**Pergunta feita à IA:**
> Qual a função do Navigator.push() na navegação com rotas anônimas?

**Resposta da IA:**

`Navigator.push()` empurra uma nova rota para a pilha de navegação. A tela atual fica na pilha — o usuário pode voltar com `pop()` ou com o botão de voltar do dispositivo.

```dart
// navegar para outra tela
ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DetalheTela(id: 42),
      ),
    );
  },
  child: const Text('Ver detalhes'),
)

// voltar
Navigator.pop(context);

// voltar com um resultado
Navigator.pop(context, 'dado retornado');

// capturar o resultado na tela anterior
final resultado = await Navigator.push(...);
print(resultado); // 'dado retornado'
```

---

## 4. Quais as vantagens e desvantagens de usar rotas anônimas?

**Pergunta feita à IA:**
> Quais as vantagens e desvantagens de usar rotas anônimas?

**Resposta da IA:**

**Vantagens:**
- Simples e rápido de implementar.
- Bom para apps pequenos ou protótipos.
- Fácil de passar parâmetros diretamente no construtor.
- Não precisa configurar nada no `MaterialApp`.

**Desvantagens:**
- Difícil de navegar de qualquer ponto do app sem ter o `context` certo.
- Sem deep linking nativo.
- Código de navegação espalhado pelo app — difícil de manter em projetos grandes.
- Não é possível gerar rotas dinamicamente por nome.

---

## 5. O que são rotas nomeadas em Flutter e como elas funcionam?

**Pergunta feita à IA:**
> O que são rotas nomeadas em Flutter e como elas funcionam?

**Resposta da IA:**

Rotas nomeadas associam um nome (string) a uma tela, registradas no `MaterialApp`. A navegação é feita pelo nome em vez de construir o widget diretamente.

```dart
MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => const HomeScreen(),
    '/detalhes': (context) => const DetalhesScreen(),
    '/perfil': (context) => const PerfilScreen(),
  },
)

// navegar
Navigator.pushNamed(context, '/detalhes');

// voltar
Navigator.pop(context);
```

---

## 6. Como posso navegar para uma rota nomeada específica?

**Pergunta feita à IA:**
> Como posso navegar para uma rota nomeada específica?

**Resposta da IA:**

```dart
// navegar simples
Navigator.pushNamed(context, '/perfil');

// navegar com argumentos
Navigator.pushNamed(
  context,
  '/detalhes',
  arguments: {'id': 5, 'titulo': 'Produto X'},
);

// substituir a tela atual
Navigator.pushReplacementNamed(context, '/home');

// limpar pilha e ir para uma rota
Navigator.pushNamedAndRemoveUntil(
  context,
  '/home',
  (route) => false, // remove todas as rotas anteriores
);
```

---

## 7. Quais as vantagens de usar rotas nomeadas em relação às anônimas?

**Pergunta feita à IA:**
> Quais as vantagens de usar rotas nomeadas em relação às rotas anônimas?

**Resposta da IA:**

- **Centralização**: todas as rotas ficam declaradas num só lugar no `MaterialApp`.
- **Navegação por string**: qualquer parte do app pode navegar sem precisar importar o widget de destino.
- **Deep linking**: suporte nativo a links que abrem telas específicas.
- **Legibilidade**: `pushNamed('/carrinho')` é mais claro que construir um `MaterialPageRoute` inline.
- **Facilidade de manutenção**: para renomear ou trocar uma tela, muda só no mapa de rotas.

A desvantagem é que passar objetos complexos via `arguments` é menos tipado que passar direto no construtor.

---

## 8. Como posso definir rotas nomeadas no aplicativo Flutter?

**Pergunta feita à IA:**
> Como posso definir rotas nomeadas em meu aplicativo Flutter?

**Resposta da IA:**

**Forma 1 — mapa de rotas simples:**
```dart
MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => const HomeScreen(),
    '/produto': (context) => const ProdutoScreen(),
    '/carrinho': (context) => const CarrinhoScreen(),
  },
)
```

**Forma 2 — `onGenerateRoute` para controle dinâmico:**
```dart
MaterialApp(
  onGenerateRoute: (settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/produto':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => ProdutoScreen(id: args['id']),
        );
      default:
        return MaterialPageRoute(builder: (_) => const NotFoundScreen());
    }
  },
)
```

`onGenerateRoute` é mais flexível — permite receber argumentos tipados e tratar rotas desconhecidas.

---

## 9. Como posso acessar os parâmetros passados em uma rota nomeada?

**Pergunta feita à IA:**
> Como posso acessar os parâmetros passados em uma rota nomeada?

**Resposta da IA:**

Os argumentos são acessados via `ModalRoute.of(context)!.settings.arguments`:

```dart
// quem navega passa os argumentos
Navigator.pushNamed(
  context,
  '/produto',
  arguments: {'id': 10, 'nome': 'Camiseta'},
);

// quem recebe extrai os argumentos
class ProdutoScreen extends StatelessWidget {
  const ProdutoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final id = args['id'];
    final nome = args['nome'];

    return Scaffold(
      appBar: AppBar(title: Text(nome)),
      body: Text('ID: $id'),
    );
  }
}
```

---

## 10. Como tornar os parâmetros opcionais em uma rota nomeada?

**Pergunta feita à IA:**
> Como posso tornar os parâmetros opcionais em uma rota nomeada?

**Resposta da IA:**

Como `arguments` é `Object?`, você pode tratar a ausência dele com `as Map?` e usar `??` para valores padrão:

```dart
@override
Widget build(BuildContext context) {
  final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

  final id = args?['id'] ?? 0;
  final titulo = args?['titulo'] ?? 'Sem título';

  return Scaffold(
    appBar: AppBar(title: Text(titulo)),
    body: Text('ID: $id'),
  );
}
```

Assim a tela funciona mesmo se for acessada sem argumentos — útil para telas que podem ser abertas de formas diferentes.

---

## 11. Quais cuidados devo ter ao usar rotas?

**Pergunta feita à IA:**
> Quais cuidados devo ter ao usar as rotas?

**Resposta da IA:**

- **Não use `context` após operações assíncronas sem verificar `mounted`**: após um `await`, o widget pode ter sido removido da árvore.
```dart
await salvar();
if (!mounted) return;
Navigator.pop(context);
```

- **Evite `Navigator.pop()` em telas que são raiz**: se não há tela abaixo na pilha, `pop` fecha o app.

- **Cast seguro nos argumentos**: `arguments as Map` sem verificação de tipo lança exceção se vier algo inesperado. Use `as Map?` e trate o null.

- **Cuidado com rotas duplicadas na pilha**: chamar `push` várias vezes sem intenção empilha a mesma tela múltiplas vezes.

- **Prefira constantes para os nomes das rotas** para evitar typos:
```dart
class AppRoutes {
  static const home = '/';
  static const produto = '/produto';
  static const carrinho = '/carrinho';
}
```

---

## 12. Quais as boas práticas ao usar rotas em Flutter?

**Pergunta feita à IA:**
> Quais as boas práticas ao usar rotas em Flutter?

**Resposta da IA:**

- **Centralize os nomes em uma classe de constantes** como mostrado acima.
- **Use `onGenerateRoute` em vez do mapa simples** para apps médios/grandes — mais controle e tipagem.
- **Separe a configuração de rotas do `main.dart`** em um arquivo próprio como `app_routes.dart`.
- **Prefira passar objetos via construtor** (com rotas anônimas) quando os dados são complexos ou tipados.
- **Para apps grandes**, considere pacotes de roteamento como `go_router` ou `auto_route` que oferecem deep linking, guards de autenticação e rotas tipadas.
- **Nomeie as rotas de forma consistente**: `/tela`, `/tela/sub-tela`, `/tela/:id`.

---

## 13. Exemplo de galeria navegando entre imagens com rotas anônimas

**Pergunta feita à IA:**
> Traga um exemplo de galeria navegando entre imagens usando rotas anônimas.

**Resposta da IA:**

```dart
// lista de imagens
const imagens = [
  'https://picsum.photos/id/10/400/300',
  'https://picsum.photos/id/20/400/300',
  'https://picsum.photos/id/30/400/300',
];

// tela da galeria
class GaleriaScreen extends StatelessWidget {
  const GaleriaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Galeria')),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: imagens.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ImagemDetalheScreen(
                    url: imagens[index],
                    indice: index + 1,
                    total: imagens.length,
                  ),
                ),
              );
            },
            child: Image.network(imagens[index], fit: BoxFit.cover),
          );
        },
      ),
    );
  }
}

// tela de detalhe
class ImagemDetalheScreen extends StatelessWidget {
  final String url;
  final int indice;
  final int total;

  const ImagemDetalheScreen({
    super.key,
    required this.url,
    required this.indice,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$indice de $total')),
      body: Center(
        child: Image.network(url, fit: BoxFit.contain),
      ),
    );
  }
}
```

---

## 14. Fluxo com times brasileiros usando rotas nomeadas e parâmetros

**Pergunta feita à IA:**
> Crie um fluxo com várias telas, passando pelos times brasileiros usando rotas nomeadas e parâmetros.

**Resposta da IA:**

```dart
// constantes de rotas
class AppRoutes {
  static const home = '/';
  static const times = '/times';
  static const detalhe = '/times/detalhe';
}

// modelo
class Time {
  final String nome;
  final String estado;
  final int titulos;
  Time({required this.nome, required this.estado, required this.titulos});
}

final times = [
  Time(nome: 'Flamengo', estado: 'RJ', titulos: 3),
  Time(nome: 'Palmeiras', estado: 'SP', titulos: 3),
  Time(nome: 'Santos', estado: 'SP', titulos: 2),
  Time(nome: 'São Paulo', estado: 'SP', titulos: 3),
];

// configuração das rotas no MaterialApp
MaterialApp(
  initialRoute: AppRoutes.home,
  routes: {
    AppRoutes.home: (_) => const HomeScreen(),
    AppRoutes.times: (_) => const TimesScreen(),
    AppRoutes.detalhe: (_) => const TimeDetalheScreen(),
  },
)

// tela inicial
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Futebol Brasileiro')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.times),
          child: const Text('Ver Times'),
        ),
      ),
    );
  }
}

// lista de times
class TimesScreen extends StatelessWidget {
  const TimesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Times')),
      body: ListView.builder(
        itemCount: times.length,
        itemBuilder: (context, index) {
          final time = times[index];
          return ListTile(
            title: Text(time.nome),
            subtitle: Text(time.estado),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.detalhe,
                arguments: time,
              );
            },
          );
        },
      ),
    );
  }
}

// detalhe do time
class TimeDetalheScreen extends StatelessWidget {
  const TimeDetalheScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final time = ModalRoute.of(context)!.settings.arguments as Time;
    return Scaffold(
      appBar: AppBar(title: Text(time.nome)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Estado: ${time.estado}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Títulos Brasileiros: ${time.titulos}',
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
```
