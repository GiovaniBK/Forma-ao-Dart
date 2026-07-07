# IA como apoio – Flutter: Widgets Básicos

Atividade da Lince Tech Academy sobre Row, Column, Stack, Image, Text, ListView e ListTile.

---

## 1. Explique o conceito de um widget Row em Flutter

**Pergunta feita à IA:**
> Explique o conceito de um widget Row em Flutter.

**Resposta da IA:**

`Row` organiza seus filhos horizontalmente, da esquerda para a direita. É um dos widgets de layout mais usados no Flutter.

```dart
Row(
  children: [
    Icon(Icons.star),
    Text('Favorito'),
    ElevatedButton(onPressed: () {}, child: Text('OK')),
  ],
)
```

Por padrão, a `Row` ocupa toda a largura disponível e posiciona os filhos no início. O comportamento pode ser controlado com `mainAxisAlignment` e `crossAxisAlignment`.

---

## 2. Como posso adicionar espaçamento uniforme entre os widgets em um Row?

**Pergunta feita à IA:**
> Como posso adicionar espaçamento uniforme entre os widgets em um Row?

**Resposta da IA:**

Há algumas formas:

**Com `mainAxisAlignment`:**
```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [Icon(Icons.home), Icon(Icons.search), Icon(Icons.person)],
)
```

**Com `SizedBox` entre os filhos:**
```dart
Row(
  children: [
    Text('A'),
    SizedBox(width: 16),
    Text('B'),
    SizedBox(width: 16),
    Text('C'),
  ],
)
```

**Com `gap` de pacotes externos (como `gap`)** ou usando `Spacer` para empurrar elementos para as extremidades:
```dart
Row(
  children: [
    Text('esquerda'),
    Spacer(),
    Text('direita'),
  ],
)
```

---

## 3. Qual a diferença entre MainAxisAlignment e CrossAxisAlignment em um Row?

**Pergunta feita à IA:**
> Qual a diferença entre MainAxisAlignment e CrossAxisAlignment em um Row?

**Resposta da IA:**

Num `Row`:
- **MainAxisAlignment** controla o alinhamento no eixo **horizontal** (o eixo principal).
- **CrossAxisAlignment** controla o alinhamento no eixo **vertical** (o eixo cruzado).

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.center,     // centraliza horizontalmente
  crossAxisAlignment: CrossAxisAlignment.start,    // alinha ao topo verticalmente
  children: [...],
)
```

Valores comuns de `MainAxisAlignment`: `start`, `end`, `center`, `spaceBetween`, `spaceAround`, `spaceEvenly`.

Valores comuns de `CrossAxisAlignment`: `start`, `end`, `center`, `stretch`, `baseline`.

---

## 4. Explique o conceito de um widget Column em Flutter

**Pergunta feita à IA:**
> Explique o conceito de um widget Column em Flutter.

**Resposta da IA:**

`Column` organiza seus filhos verticalmente, de cima para baixo. É o equivalente vertical do `Row`.

```dart
Column(
  children: [
    Text('título'),
    SizedBox(height: 8),
    Text('subtítulo'),
    ElevatedButton(onPressed: () {}, child: Text('Ação')),
  ],
)
```

Por padrão ocupa toda a altura disponível. Se o conteúdo ultrapassar a tela, vai estourar — nesse caso envolva com `SingleChildScrollView` ou use `ListView`.

---

## 5. Qual a diferença entre MainAxisAlignment e CrossAxisAlignment em um Column?

**Pergunta feita à IA:**
> Qual a diferença entre MainAxisAlignment e CrossAxisAlignment em um Column?

**Resposta da IA:**

Num `Column` os eixos são invertidos em relação ao `Row`:
- **MainAxisAlignment** controla o alinhamento **vertical** (o eixo principal da Column).
- **CrossAxisAlignment** controla o alinhamento **horizontal** (o eixo cruzado).

```dart
Column(
  mainAxisAlignment: MainAxisAlignment.center,       // centraliza verticalmente
  crossAxisAlignment: CrossAxisAlignment.stretch,    // estica horizontalmente
  children: [...],
)
```

`CrossAxisAlignment.stretch` é útil para fazer botões e campos ocuparem toda a largura da coluna.

---

## 6. Explique o conceito de um widget Stack em Flutter

**Pergunta feita à IA:**
> Explique o conceito de um widget Stack em Flutter.

**Resposta da IA:**

`Stack` empilha widgets uns sobre os outros, como camadas. O primeiro filho fica na base, o último fica no topo. É útil para sobrepor elementos — texto sobre imagem, badge sobre ícone, overlay sobre conteúdo.

```dart
Stack(
  children: [
    Image.network('https://exemplo.com/foto.jpg'),  // camada base
    Positioned(
      bottom: 8,
      left: 8,
      child: Text('foto de perfil', style: TextStyle(color: Colors.white)),
    ),
  ],
)
```

---

## 7. Quais as vantagens de usar Stack em vez de Row ou Column?

**Pergunta feita à IA:**
> Quais as vantagens de usar Stack em vez de Row ou Column?

**Resposta da IA:**

`Row` e `Column` organizam widgets em sequência sem sobreposição. `Stack` permite que widgets ocupem a mesma posição espacial:

- Texto sobre imagem de fundo.
- Badge de notificação sobre um ícone.
- Botão flutuante posicionado num canto específico de um container.
- Loading overlay sobre todo o conteúdo da tela.

Não tem vantagem de performance — é só uma questão de layout. Use `Stack` quando precisar de sobreposição, `Row`/`Column` quando precisar de sequência.

---

## 8. Como posso posicionar widgets específicos dentro de um Stack?

**Pergunta feita à IA:**
> Como posso posicionar widgets específicos dentro de um Stack?

**Resposta da IA:**

Com o widget `Positioned`, que permite definir distâncias em relação às bordas do Stack:

```dart
Stack(
  children: [
    Container(width: 200, height: 200, color: Colors.blue),
    Positioned(
      top: 10,
      right: 10,
      child: Icon(Icons.close, color: Colors.white),
    ),
    Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.black54,
        padding: EdgeInsets.all(8),
        child: Text('legenda', style: TextStyle(color: Colors.white)),
      ),
    ),
  ],
)
```

Widgets sem `Positioned` ficam alinhados de acordo com o `alignment` do Stack (padrão: canto superior esquerdo).

---

## 9. Como posso exibir uma imagem de um arquivo local em Flutter?

**Pergunta feita à IA:**
> Como posso exibir uma imagem de um arquivo local em Flutter?

**Resposta da IA:**

Primeiro declare o arquivo no `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/imagens/foto.png
    - assets/imagens/  # ou a pasta inteira
```

Depois use `Image.asset`:

```dart
Image.asset(
  'assets/imagens/foto.png',
  width: 200,
  height: 150,
  fit: BoxFit.cover,
)
```

Os valores mais usados de `fit`:
- `BoxFit.cover` — preenche o espaço, pode cortar.
- `BoxFit.contain` — mostra a imagem inteira, pode sobrar espaço.
- `BoxFit.fill` — estica para preencher (pode distorcer).

---

## 10. Quais propriedades posso usar para controlar a aparência do texto?

**Pergunta feita à IA:**
> Quais propriedades posso usar para controlar a aparência do texto (fonte, tamanho, cor)?

**Resposta da IA:**

Tudo passa pelo `TextStyle`:

```dart
Text(
  'Título do App',
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.deepPurple,
    fontStyle: FontStyle.italic,
    letterSpacing: 1.5,
    wordSpacing: 4,
    decoration: TextDecoration.underline,
    fontFamily: 'Roboto',
    height: 1.4, // espaçamento entre linhas
  ),
)
```

Para fontes customizadas, declare no `pubspec.yaml` e referencie pelo nome no `fontFamily`.

---

## 11. Como posso exibir um texto em várias linhas?

**Pergunta feita à IA:**
> Como posso exibir um texto em várias linhas?

**Resposta da IA:**

O `Text` já quebra linha automaticamente quando o texto é longo e há espaço limitado. Para controlar:

```dart
// limitar número de linhas
Text(
  'texto muito longo que pode ou não caber...',
  maxLines: 2,
  overflow: TextOverflow.ellipsis, // adiciona "..." no final
)

// forçar quebra de linha com \n
Text('linha 1\nlinha 2\nlinha 3')

// texto rico com estilos diferentes por trecho
RichText(
  text: TextSpan(
    text: 'normal ',
    style: TextStyle(color: Colors.black),
    children: [
      TextSpan(text: 'negrito ', style: TextStyle(fontWeight: FontWeight.bold)),
      TextSpan(text: 'colorido', style: TextStyle(color: Colors.red)),
    ],
  ),
)
```

---

## 12. Como posso criar uma lista de rolagem vertical em Flutter?

**Pergunta feita à IA:**
> Como posso criar uma lista de rolagem vertical em Flutter?

**Resposta da IA:**

Com `ListView`. Há três formas principais:

**Lista simples (poucos itens fixos):**
```dart
ListView(
  children: [
    Text('item 1'),
    Text('item 2'),
    Text('item 3'),
  ],
)
```

**ListView.builder (lista dinâmica — recomendado para muitos itens):**
```dart
ListView.builder(
  itemCount: itens.length,
  itemBuilder: (context, index) {
    return Text(itens[index]);
  },
)
```

**ListView.separated (com divisórias):**
```dart
ListView.separated(
  itemCount: itens.length,
  separatorBuilder: (context, index) => Divider(),
  itemBuilder: (context, index) => Text(itens[index]),
)
```

---

## 13. Como posso adicionar itens dinamicamente a um ListView?

**Pergunta feita à IA:**
> Como posso adicionar itens dinamicamente a um ListView?

**Resposta da IA:**

Mantendo a lista no estado de um `StatefulWidget` e chamando `setState` ao adicionar:

```dart
class ListaDinamica extends StatefulWidget {
  const ListaDinamica({super.key});
  @override
  State<ListaDinamica> createState() => _ListaDinamicaState();
}

class _ListaDinamicaState extends State<ListaDinamica> {
  final List<String> _itens = [];
  int _contador = 0;

  void _adicionarItem() {
    setState(() {
      _itens.add('Item $_contador');
      _contador++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _itens.length,
        itemBuilder: (context, index) => ListTile(title: Text(_itens[index])),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarItem,
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

---

## 14. Quais as diferenças entre ListView.builder e ListView.separated?

**Pergunta feita à IA:**
> Quais as diferenças entre ListView.builder e ListView.separated?

**Resposta da IA:**

| | `ListView.builder` | `ListView.separated` |
|---|---|---|
| Divisória entre itens | Não inclui | Sim, via `separatorBuilder` |
| Parâmetros obrigatórios | `itemBuilder`, `itemCount` | `itemBuilder`, `separatorBuilder`, `itemCount` |
| Flexibilidade da divisória | N/A | Qualquer widget (Divider, SizedBox, Container) |

```dart
// builder — sem divisória
ListView.builder(
  itemCount: 20,
  itemBuilder: (context, i) => ListTile(title: Text('item $i')),
)

// separated — com divisória customizável
ListView.separated(
  itemCount: 20,
  separatorBuilder: (context, i) => const Divider(height: 1),
  itemBuilder: (context, i) => ListTile(title: Text('item $i')),
)
```

`ListView.separated` também garante que a divisória não aparece após o último item.

---

## 15. Como posso usar ListTile para criar itens de lista em um ListView?

**Pergunta feita à IA:**
> Como posso usar ListTile para criar itens de lista em um ListView?

**Resposta da IA:**

`ListTile` é um widget pronto para itens de lista com layout pré-definido: ícone à esquerda, título, subtítulo e ação à direita.

```dart
ListView.builder(
  itemCount: contatos.length,
  itemBuilder: (context, index) {
    final contato = contatos[index];
    return ListTile(
      leading: CircleAvatar(child: Text(contato.nome[0])),
      title: Text(contato.nome),
      subtitle: Text(contato.email),
      trailing: Icon(Icons.chevron_right),
    );
  },
)
```

---

## 16. Como posso tornar os itens ListTile interativos?

**Pergunta feita à IA:**
> Como posso tornar os itens ListTile interativos (clicáveis)?

**Resposta da IA:**

`ListTile` tem o parâmetro `onTap` e `onLongPress` nativamente:

```dart
ListTile(
  title: Text('Item clicável'),
  onTap: () {
    print('clicado');
    Navigator.push(context, MaterialPageRoute(builder: (_) => DetalheTela()));
  },
  onLongPress: () {
    showDialog(context: context, builder: (_) => AlertDialog(title: Text('opções')));
  },
)
```

O efeito de ripple (ondulação ao toque) já vem incluído automaticamente.

---

## 17. Quais as vantagens de usar ListTile em vez de widgets de texto simples?

**Pergunta feita à IA:**
> Quais as vantagens de usar ListTile em vez de widgets de texto simples?

**Resposta da IA:**

- **Layout pronto**: título, subtítulo, ícone à esquerda e ação à direita já posicionados corretamente sem precisar montar um `Row` manualmente.
- **Altura mínima garantida**: o `ListTile` respeita as diretrizes do Material Design para área de toque (mínimo 48dp).
- **`onTap` nativo**: sem precisar envolver com `GestureDetector` ou `InkWell`.
- **Consistência visual**: segue automaticamente o tema do app.
- **Menos código**: o que seria uma `Row` com `Column`, `Padding` e `GestureDetector` vira um widget só.

Para listas simples, `ListTile` é quase sempre a escolha certa.

---

## 18. Como os widgets são organizados dentro de um Stack?

**Pergunta feita à IA:**
> Como os widgets são organizados dentro de um Stack?

**Resposta da IA:**

Widgets dentro de um `Stack` são pintados na ordem da lista — o primeiro filho fica na camada mais abaixo, o último no topo.

```dart
Stack(
  alignment: Alignment.center, // alinhamento padrão dos filhos sem Positioned
  children: [
    // camada 0 — base
    Container(width: 300, height: 200, color: Colors.blue),

    // camada 1 — sobre o container azul
    Container(width: 200, height: 100, color: Colors.red.withOpacity(0.7)),

    // camada 2 — topo, posicionado no canto
    Positioned(
      top: 8, right: 8,
      child: Icon(Icons.star, color: Colors.white),
    ),
  ],
)
```

Filhos sem `Positioned` ficam alinhados de acordo com `alignment` do Stack. Filhos com `Positioned` ignoram o `alignment` e usam as coordenadas definidas.

---

## 19. Como posso exibir uma imagem da internet em Flutter?

**Pergunta feita à IA:**
> Como posso exibir uma imagem da internet em Flutter?

**Resposta da IA:**

Com `Image.network`:

```dart
Image.network(
  'https://exemplo.com/imagem.jpg',
  width: 300,
  height: 200,
  fit: BoxFit.cover,
  loadingBuilder: (context, child, loadingProgress) {
    if (loadingProgress == null) return child;
    return Center(child: CircularProgressIndicator());
  },
  errorBuilder: (context, error, stackTrace) {
    return Icon(Icons.broken_image, size: 48);
  },
)
```

O `loadingBuilder` mostra algo enquanto a imagem carrega. O `errorBuilder` exibe um fallback se a imagem falhar. Para apps em produção, o pacote `cached_network_image` é mais recomendado por fazer cache das imagens.

---

## 20. Como posso adicionar um efeito de desvanecimento a uma imagem?

**Pergunta feita à IA:**
> Como posso adicionar um efeito de desvanecimento a uma imagem?

**Resposta da IA:**

Com `FadeInImage` para imagens que carregam da rede, ou com `AnimatedOpacity` para controlar manualmente:

```dart
// desvanecimento ao carregar da rede
FadeInImage.assetNetwork(
  placeholder: 'assets/placeholder.png',
  image: 'https://exemplo.com/foto.jpg',
  fadeInDuration: Duration(milliseconds: 500),
  fit: BoxFit.cover,
)

// desvanecimento controlado por estado
AnimatedOpacity(
  opacity: _visivel ? 1.0 : 0.0,
  duration: Duration(milliseconds: 300),
  child: Image.asset('assets/imagem.png'),
)
```

`FadeInImage` é a opção mais simples para o caso mais comum: mostrar um placeholder e fazer a imagem aparecer suavemente quando terminar de carregar.

---

## 21. Como posso adicionar ícones e outros elementos visuais a um ListTile?

**Pergunta feita à IA:**
> Como posso adicionar ícones e outros elementos visuais a um ListTile?

**Resposta da IA:**

`ListTile` tem parâmetros dedicados para cada posição:

```dart
ListTile(
  // ícone ou avatar à esquerda
  leading: CircleAvatar(
    backgroundImage: NetworkImage('https://exemplo.com/avatar.jpg'),
  ),

  // conteúdo principal
  title: Text('João Silva'),
  subtitle: Row(
    children: [
      Icon(Icons.phone, size: 14, color: Colors.grey),
      SizedBox(width: 4),
      Text('(11) 99999-9999'),
    ],
  ),

  // elemento à direita
  trailing: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.circle, size: 10, color: Colors.green),
      Text('online', style: TextStyle(fontSize: 10)),
    ],
  ),

  onTap: () {},
)
```

Os parâmetros `leading` e `trailing` aceitam qualquer widget — não se limitam a ícones.
