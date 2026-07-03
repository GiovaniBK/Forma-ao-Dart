# IA como apoio – Introdução ao Flutter e Widgets

Atividade da Lince Tech Academy sobre estrutura básica de um app Flutter, Material Design, Stateless e Stateful widgets.

---

## 1. Explique o MaterialApp e seus parâmetros

**Pergunta feita à IA:**
> Explique o MaterialApp e seus parâmetros?

**Resposta da IA:**

`MaterialApp` é o widget raiz da maioria dos apps Flutter. Ele configura o app inteiro — tema, rotas, idioma, título — e fornece os recursos do Material Design para todos os widgets abaixo dele na árvore.

```dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MinhaTelaInicial(),
    );
  }
}
```

Os parâmetros mais usados são `title`, `theme`, `home`, `routes`, `debugShowCheckedModeBanner` e `initialRoute`.

---

## 2. Quais parâmetros são importantes no MaterialApp?

**Pergunta feita à IA:**
> Quais parâmetros são importantes no MaterialApp?

**Resposta da IA:**

| Parâmetro | Descrição |
|---|---|
| `home` | Widget exibido na rota inicial do app |
| `title` | Nome do app (aparece no gerenciador de tarefas do SO) |
| `theme` | Tema visual padrão (cores, tipografia, formas) |
| `darkTheme` | Tema para modo escuro |
| `themeMode` | Controla qual tema usar: `system`, `light` ou `dark` |
| `routes` | Mapa de rotas nomeadas do app |
| `initialRoute` | Rota inicial quando se usa `routes` |
| `navigatorKey` | Permite navegar sem contexto |
| `debugShowCheckedModeBanner` | Remove o banner "DEBUG" do canto da tela |
| `locale` | Idioma/região do app |
| `supportedLocales` | Lista de idiomas suportados |

Para a maioria dos apps, `home`, `theme` e `debugShowCheckedModeBanner` já resolvem no início.

---

## 3. Como funcionam os imports no Flutter?

**Pergunta feita à IA:**
> Como funcionam os "import's" no flutter?

**Resposta da IA:**

Imports em Flutter seguem o padrão do Dart. Há três tipos principais:

```dart
// 1. pacotes do SDK do Dart
import 'dart:math';
import 'dart:convert';

// 2. pacotes externos (instalados via pubspec.yaml)
import 'package:flutter/material.dart';   // Flutter + Material Design
import 'package:flutter/cupertino.dart';  // widgets estilo iOS
import 'package:http/http.dart' as http;  // pacote externo

// 3. arquivos do próprio projeto
import 'package:meu_app/screens/home_screen.dart';
import '../widgets/botao_customizado.dart'; // caminho relativo
```

O `package:flutter/material.dart` é o import mais comum — ele traz todos os widgets do Material Design, o `StatelessWidget`, `StatefulWidget`, `BuildContext`, `Colors`, etc.

Quando dois pacotes exportam algo com o mesmo nome, use `as` para criar um alias e evitar conflito:
```dart
import 'package:lib_a/lib_a.dart' as libA;
import 'package:lib_b/lib_b.dart' as libB;
```

---

## 4. O que é o Material Design e como ele é utilizado no Flutter?

**Pergunta feita à IA:**
> Explique o que é o Material Design e como ele é utilizado no Flutter.

**Resposta da IA:**

Material Design é o sistema de design criado pelo Google — define padrões visuais como cores, tipografia, espaçamento, elevação, animações e comportamentos de componentes. O objetivo é criar interfaces consistentes e intuitivas.

No Flutter, o Material Design é disponibilizado através do pacote `flutter/material.dart`. Quando seu app usa `MaterialApp` e widgets Material (`Scaffold`, `AppBar`, `ElevatedButton`, etc.), ele automaticamente segue as diretrizes do Material Design.

Com o Material 3 (padrão no Flutter atual), os componentes ficaram mais modernos com suporte a cores dinâmicas baseadas no `colorScheme`:

```dart
ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  useMaterial3: true,
)
```

Isso propaga a paleta de cores por todos os widgets automaticamente, sem precisar definir cor por cor.

---

## 5. Quais são os principais widgets do Material Design no Flutter?

**Pergunta feita à IA:**
> Quais são os principais widgets do Material Design disponíveis no Flutter?

**Resposta da IA:**

**Estrutura:**
- `Scaffold` — estrutura base de uma tela (appBar, body, floatingActionButton, drawer)
- `AppBar` — barra superior com título e ações
- `Drawer` — menu lateral
- `BottomNavigationBar` — navegação inferior

**Botões:**
- `ElevatedButton` — botão com elevação
- `TextButton` — botão sem fundo
- `OutlinedButton` — botão com borda
- `IconButton` — botão com ícone
- `FloatingActionButton` — botão flutuante

**Inputs:**
- `TextField` — campo de texto
- `Checkbox`, `Switch`, `Radio` — seleções
- `Slider` — controle deslizante
- `DropdownButton` — seleção em lista suspensa

**Exibição:**
- `Text`, `Icon`, `Image` — conteúdo básico
- `Card` — container com elevação e bordas arredondadas
- `ListTile` — item de lista com título, subtítulo e ícones
- `Chip` — tag/etiqueta compacta
- `CircularProgressIndicator`, `LinearProgressIndicator` — carregamento

**Dialogs e feedback:**
- `AlertDialog`, `SimpleDialog` — janelas modais
- `SnackBar` — mensagem temporária na base da tela
- `BottomSheet` — painel que sobe da base

---

## 6. O que são widgets Stateless e quando devemos utilizá-los?

**Pergunta feita à IA:**
> O que são widgets Stateless e quando devemos utilizá-los?

**Resposta da IA:**

Um `StatelessWidget` é um widget que não guarda estado interno — ele recebe dados via construtor e renderiza a interface. Se os dados mudarem, o widget pai reconstrói o filho passando novos valores.

```dart
class CartaoUsuario extends StatelessWidget {
  final String nome;
  final String email;

  const CartaoUsuario({
    super.key,
    required this.nome,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(nome),
        subtitle: Text(email),
      ),
    );
  }
}
```

Use Stateless quando:
- O widget só exibe dados passados por parâmetro.
- A aparência não muda com interação do usuário.
- É um componente puramente visual: ícone, texto, card, avatar.

---

## 7. Explique o ciclo de vida de um widget Stateless

**Pergunta feita à IA:**
> Explique o ciclo de vida de um widget Stateless.

**Resposta da IA:**

O ciclo de vida do `StatelessWidget` é simples — tem basicamente uma etapa relevante:

1. **Construção** — o construtor é chamado com os parâmetros.
2. **`build()`** — Flutter chama esse método para obter a árvore de widgets que representa a UI. É chamado sempre que o widget precisa ser renderizado ou re-renderizado.
3. **Descarte** — quando o widget é removido da árvore, ele é descartado sem nenhum callback especial.

O `build()` pode ser chamado várias vezes — sempre que o widget pai reconstruir e passar novos parâmetros. Por isso, o método `build` deve ser puro e sem efeitos colaterais.

---

## 8. Quais são as limitações dos widgets Stateless?

**Pergunta feita à IA:**
> Quais são as limitações dos widgets Stateless?

**Resposta da IA:**

- **Não guardam estado interno**: não têm memória entre reconstruções. Se o usuário digitar algo num campo de texto dentro de um Stateless, esse valor se perde na próxima reconstrução.
- **Não respondem a eventos por conta própria**: um botão dentro de um Stateless pode capturar o clique, mas não pode atualizar a tela sem depender do widget pai.
- **Toda atualização vem de fora**: a única forma de mudar o que um Stateless exibe é o pai reconstruí-lo com novos parâmetros.

Essas limitações não são problemas quando o widget realmente não precisa de estado. O problema é tentar usar Stateless em situações que exigem interatividade — aí é hora de usar Stateful.

---

## 9. O que são widgets Stateful e quando devemos utilizá-los?

**Pergunta feita à IA:**
> O que são widgets Stateful e quando devemos utilizá-los?

**Resposta da IA:**

Um `StatefulWidget` é um widget que mantém estado interno que pode mudar ao longo do tempo. Quando o estado muda, o Flutter reconstrói o widget automaticamente para refletir a mudança na tela.

É composto por duas classes: o widget em si e um objeto `State` separado que guarda o estado.

```dart
class Contador extends StatefulWidget {
  const Contador({super.key});

  @override
  State<Contador> createState() => _ContadorState();
}

class _ContadorState extends State<Contador> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$_count'),
        ElevatedButton(
          onPressed: () => setState(() => _count++),
          child: const Text('incrementar'),
        ),
      ],
    );
  }
}
```

Use Stateful quando:
- O widget precisa reagir a interações do usuário (cliques, digitação, scroll).
- Há dados que mudam com o tempo (timer, animação, carregamento).
- É necessário controlar o estado de formulários.

---

## 10. Explique o ciclo de vida de um widget Stateful

**Pergunta feita à IA:**
> Explique o ciclo de vida de um widget Stateful.

**Resposta da IA:**

O ciclo de vida de um `StatefulWidget` é mais rico que o do Stateless:

1. **`createState()`** — chamado pelo Flutter para criar o objeto `State` associado.
2. **`initState()`** — chamado uma vez quando o State é inserido na árvore. Ideal para inicializações: controllers, subscriptions, chamadas assíncronas iniciais.
3. **`build()`** — chamado toda vez que o estado muda (`setState`) ou o widget pai reconstrói. Deve ser rápido e sem efeitos colaterais.
4. **`didUpdateWidget()`** — chamado quando o widget pai passa novos parâmetros para o mesmo State.
5. **`setState()`** — não é um callback, mas o método que você chama para notificar o Flutter que o estado mudou e o `build` deve rodar de novo.
6. **`deactivate()`** — chamado quando o widget é removido temporariamente da árvore.
7. **`dispose()`** — chamado quando o widget é removido permanentemente. Aqui você libera recursos: `controller.dispose()`, cancelar subscriptions, etc.

---

## 11. Como o gerenciamento de estado é feito em widgets Stateful?

**Pergunta feita à IA:**
> Como o gerenciamento de estado é feito em widgets Stateful?

**Resposta da IA:**

O estado fica em variáveis dentro da classe `_NomeState`. Para atualizar a UI quando uma variável muda, você envolve a modificação em `setState()`:

```dart
class _FormState extends State<FormWidget> {
  String _nome = '';
  bool _aceitouTermos = false;
  int _opcaoSelecionada = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (valor) => setState(() => _nome = valor),
        ),
        Switch(
          value: _aceitouTermos,
          onChanged: (valor) => setState(() => _aceitouTermos = valor),
        ),
        Text('Nome: $_nome, Termos: $_aceitouTermos'),
      ],
    );
  }
}
```

O `setState` agenda uma reconstrução do widget — o Flutter chama `build()` novamente e a UI reflete os novos valores.

---

## 12. Como funciona o setState em Flutter?

**Pergunta feita à IA:**
> Como funciona o "setState" em Flutter?

**Resposta da IA:**

`setState()` recebe uma função onde você faz as modificações no estado. Depois que essa função executa, o Flutter marca o widget como "sujo" e agenda uma reconstrução na próxima frame.

```dart
// correto — modificação dentro do setState
setState(() {
  _contador++;
  _titulo = 'novo título';
});

// errado — modificação fora do setState (UI não atualiza)
_contador++;
setState(() {}); // funciona mas é má prática

// errado — operação assíncrona dentro do setState
setState(() async {
  await buscarDados(); // nunca faça isso
});
```

Para operações assíncronas, faça o await fora e o setState dentro:
```dart
Future<void> carregar() async {
  final dados = await buscarDados();
  setState(() {
    _dados = dados;
  });
}
```

---

## 13. Quais cuidados tomar no gerenciamento de estado?

**Pergunta feita à IA:**
> Quais cuidados tomar no gerenciamento de estado?

**Resposta da IA:**

- **Não chame `setState` depois de `dispose`**: se uma operação assíncrona termina depois do widget ser removido da tela, chamar `setState` vai lançar um erro. Verifique `mounted` antes:
```dart
if (mounted) setState(() { _dados = dados; });
```

- **Não coloque lógica pesada no `build`**: o `build` pode ser chamado dezenas de vezes por segundo. Cálculos, filtragens e formatações devem estar no `setState` ou em variáveis separadas.

- **`setState` mínimo**: mude só o que precisa mudar. `setState` reconstrói o widget inteiro — quanto menor o widget, mais eficiente.

- **Não abuse do estado local para dados globais**: se o mesmo estado precisa ser acessado por widgets em partes diferentes da árvore, use gerenciamento de estado externo (Provider, Riverpod, BLoC, etc.).

- **Inicialize controllers em `initState`, libere em `dispose`**:
```dart
late TextEditingController _controller;

@override
void initState() {
  super.initState();
  _controller = TextEditingController();
}

@override
void dispose() {
  _controller.dispose();
  super.dispose();
}
```

---

## 14. Quais as principais diferenças entre widgets Stateless e Stateful?

**Pergunta feita à IA:**
> Quais as principais diferenças entre widgets Stateless e Stateful?

**Resposta da IA:**

| | StatelessWidget | StatefulWidget |
|---|---|---|
| Guarda estado interno? | Não | Sim |
| Pode atualizar a UI sozinho? | Não | Sim, via `setState` |
| Ciclo de vida | Simples (`build`) | Completo (`initState`, `build`, `dispose`…) |
| Performance | Mais leve | Levemente mais pesado |
| Uso típico | Componentes visuais estáticos | Formulários, contadores, animações, dados dinâmicos |
| Número de classes | 1 | 2 (widget + State) |

A regra prática: comece com Stateless. Se precisar de estado, mude para Stateful.

---

## 15. Como o Flutter lida com a renderização de widgets na tela?

**Pergunta feita à IA:**
> Como o Flutter lida com a renderização de widgets na tela?

**Resposta da IA:**

Flutter usa três árvores internas para renderizar a UI:

- **Widget Tree** — a árvore que você escreve no código. Widgets são imutáveis e leves — são apenas descrições da UI.
- **Element Tree** — instâncias intermediárias que fazem o link entre widgets e render objects. Persiste entre reconstruções.
- **Render Tree** — objetos que fazem o layout e a pintura real na tela.

Quando você chama `setState`, o Flutter não reconstrói tudo do zero. Ele compara o widget anterior com o novo (reconciliação) e atualiza só os render objects que realmente mudaram. Esse processo é chamado de **diffing**.

É por isso que:
- Widgets são baratos de criar — são só descrições.
- `const` widgets são ainda mais eficientes — o Flutter sabe que nunca mudam e pode reutilizá-los.
- Extrair sub-árvores em widgets separados melhora performance — limita o escopo da reconstrução.

---

## 16. Exemplos de cenários onde cada tipo de widget é mais adequado

**Pergunta feita à IA:**
> Forneça exemplos de cenários onde cada tipo de widget seria mais adequado.

**Resposta da IA:**

**Stateless — use quando:**
```dart
// cartão de perfil — só exibe dados
class PerfilCard extends StatelessWidget {
  final String nome, foto;
  const PerfilCard({super.key, required this.nome, required this.foto});
  // ...
}

// item de lista — estático
class ProdutoItem extends StatelessWidget {
  final Produto produto;
  // ...
}

// tela sobre o app — nada muda
class SobreScreen extends StatelessWidget { }
```

**Stateful — use quando:**
```dart
// formulário de login — controla campos e validação
class LoginForm extends StatefulWidget { }

// carrinho de compras — itens adicionados/removidos
class CarrinhoScreen extends StatefulWidget { }

// player de música — play/pause, progresso, volume
class PlayerWidget extends StatefulWidget { }

// tabs — controla qual aba está ativa
class HomeScreen extends StatefulWidget { }
```

---

## 17. Exemplo do mesmo app com Stateless e Stateful

**Pergunta feita à IA:**
> Preciso de um exemplo do igual, porém usando os 2 tipos de widgets Stateless e Stateful.

**Resposta da IA:**

Um contador simples implementado dos dois jeitos:

**Com Stateless — o estado fica no pai:**
```dart
class ContadorStateless extends StatelessWidget {
  final int valor;
  final VoidCallback aoIncrementar;

  const ContadorStateless({
    super.key,
    required this.valor,
    required this.aoIncrementar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$valor', style: const TextStyle(fontSize: 48)),
        ElevatedButton(
          onPressed: aoIncrementar,
          child: const Text('incrementar'),
        ),
      ],
    );
  }
}

// uso — o pai controla o estado
class PaiStateless extends StatefulWidget {
  const PaiStateless({super.key});
  @override
  State<PaiStateless> createState() => _PaiStatelessState();
}

class _PaiStatelessState extends State<PaiStateless> {
  int _valor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ContadorStateless(
          valor: _valor,
          aoIncrementar: () => setState(() => _valor++),
        ),
      ),
    );
  }
}
```

**Com Stateful — o estado fica no próprio widget:**
```dart
class ContadorStateful extends StatefulWidget {
  const ContadorStateful({super.key});

  @override
  State<ContadorStateful> createState() => _ContadorStatefulState();
}

class _ContadorStatefulState extends State<ContadorStateful> {
  int _valor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$_valor', style: const TextStyle(fontSize: 48)),
            ElevatedButton(
              onPressed: () => setState(() => _valor++),
              child: const Text('incrementar'),
            ),
          ],
        ),
      ),
    );
  }
}
```

A diferença principal: no Stateless, o estado (`_valor`) fica num widget pai e é passado por parâmetro. No Stateful, o estado fica no próprio widget e é gerenciado internamente com `setState`.
