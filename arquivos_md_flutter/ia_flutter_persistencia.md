# IA como apoio – Flutter: Persistência de Dados

Atividade da Lince Tech Academy sobre persistência de dados e SharedPreferences.

---

## 1. O que é persistência de dados em aplicativos Flutter e por que é importante?

**Pergunta feita à IA:**
> O que é persistência de dados em aplicativos Flutter e por que é importante?

**Resposta da IA:**

Persistência de dados significa armazenar informações de forma que elas sobrevivam ao fechamento do app. Sem persistência, tudo que o usuário fez — preferências, dados preenchidos, histórico — some quando o app fecha.

É importante porque apps úteis precisam lembrar coisas: o usuário logado, o tema escolhido, itens de um carrinho, tarefas salvas, progresso num jogo. Sem isso, o usuário teria que reconfigurar tudo do zero a cada abertura.

---

## 2. Quais são os diferentes tipos de dados que podem ser persistidos em Flutter?

**Pergunta feita à IA:**
> Quais são os diferentes tipos de dados que podem ser persistidos em um aplicativo Flutter?

**Resposta da IA:**

| Solução | Quando usar |
|---|---|
| **SharedPreferences** | Dados simples: strings, números, booleans — configurações, preferências |
| **Arquivo local** | Textos, JSONs, imagens — dados maiores ou estruturados |
| **SQLite (sqflite)** | Dados relacionais, consultas complexas, volumes maiores |
| **Hive / Isar** | Banco NoSQL, alta performance, objetos Dart diretamente |
| **Secure Storage** | Tokens, senhas — armazenamento criptografado |
| **Firebase / Supabase** | Dados na nuvem, sincronização entre dispositivos |

A escolha depende do tipo de dado, volume, necessidade de consulta e se precisa de criptografia.

---

## 3. O que é o pacote SharedPreferences e como ele funciona?

**Pergunta feita à IA:**
> O que é o pacote SharedPreferences em Flutter e como ele funciona?

**Resposta da IA:**

SharedPreferences é um armazenamento chave-valor simples que persiste dados localmente no dispositivo. É assíncrono e funciona com tipos primitivos: `String`, `int`, `double`, `bool` e `List<String>`.

Por baixo usa `NSUserDefaults` no iOS e `SharedPreferences` no Android.

```yaml
# pubspec.yaml
dependencies:
  shared_preferences: ^2.2.0
```

```dart
import 'package:shared_preferences/shared_preferences.dart';

// salvar
Future<void> salvar() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('nome', 'João');
  await prefs.setInt('idade', 25);
  await prefs.setBool('logado', true);
}

// ler
Future<void> ler() async {
  final prefs = await SharedPreferences.getInstance();
  final nome = prefs.getString('nome') ?? 'sem nome';
  final idade = prefs.getInt('idade') ?? 0;
  final logado = prefs.getBool('logado') ?? false;
  print('$nome, $idade anos, logado: $logado');
}

// remover
Future<void> remover() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('nome');
  // ou limpar tudo
  await prefs.clear();
}
```

---

## 4. Quais são as limitações do SharedPreferences?

**Pergunta feita à IA:**
> Quais são as limitações do SharedPreferences em termos de armazenamento de dados?

**Resposta da IA:**

- **Só tipos primitivos**: não armazena objetos Dart diretamente. Para salvar uma classe, é preciso converter para JSON string primeiro.
- **Não é banco de dados**: sem consultas, filtros, ordenação ou relacionamentos.
- **Não é seguro**: os dados ficam em texto plano — não use para senhas ou tokens. Use `flutter_secure_storage` para isso.
- **Não recomendado para grandes volumes**: é para preferências e configs, não para listas de centenas de itens.
- **Assíncrono**: `getInstance()` precisa de `await` — não pode ser chamado em construtores síncronos sem cuidado.
- **Sem tipagem forte**: você define a chave como string e pode errar o nome sem aviso do compilador.

---

## 5. Quando usar SharedPreferences em vez de outras opções?

**Pergunta feita à IA:**
> Quando devo usar SharedPreferences em vez de outras opções de persistência de dados?

**Resposta da IA:**

Use SharedPreferences quando:
- Os dados são simples e poucos: tema escolhido, idioma, nome do usuário, flag de onboarding.
- Não precisa de consultas ou relacionamentos.
- O dado não é sensível.
- Quer a solução mais simples e rápida de implementar.

Não use quando:
- Precisa salvar listas de objetos complexos — use sqflite ou Hive.
- Os dados são sensíveis — use flutter_secure_storage.
- O volume de dados é grande — SharedPreferences não é otimizado para isso.
- Precisa de sincronização com servidor — use Firebase ou API própria.

---

## 6. Como lidar com erros ao usar SharedPreferences?

**Pergunta feita à IA:**
> Como posso lidar com erros ao usar SharedPreferences?

**Resposta da IA:**

SharedPreferences raramente lança exceções em operações normais de leitura/escrita, mas é boa prática tratar o `getInstance()` e operações de escrita:

```dart
Future<bool> salvarNome(String nome) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString('nome', nome);
  } catch (e) {
    print('Erro ao salvar: $e');
    return false;
  }
}

Future<String> lerNome() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('nome') ?? '';
  } catch (e) {
    print('Erro ao ler: $e');
    return '';
  }
}
```

O retorno dos métodos `set*` é um `Future<bool>` — `true` se salvou com sucesso. Verificar esse retorno é uma forma simples de detectar falha sem try/catch.

---

## 7. Quais são as melhores práticas para usar SharedPreferences?

**Pergunta feita à IA:**
> Quais são as melhores práticas para usar SharedPreferences de forma eficiente?

**Resposta da IA:**

- **Centralize as chaves em constantes** para evitar typos:
```dart
class PrefsKeys {
  static const nome = 'usuario_nome';
  static const tema = 'app_tema';
  static const logado = 'usuario_logado';
}
```

- **Crie uma classe de serviço** que encapsula todas as operações:
```dart
class PrefsService {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String get nome => _prefs?.getString(PrefsKeys.nome) ?? '';
  static Future<void> setNome(String v) async => _prefs?.setString(PrefsKeys.nome, v);
}
```

- **Inicialize uma única vez** em `main()` e reutilize a instância.
- **Não salve objetos complexos diretamente** — converta para JSON string com `jsonEncode`.
- **Não use para dados sensíveis**.

---

## 8. App para salvar nome e sobrenome com SharedPreferences

**Pergunta feita à IA:**
> Crie um app que permita ao usuário salvar seu nome e sobrenome usando SharedPreferences e exibi-los na tela.

**Resposta da IA:**

```dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MaterialApp(home: NomeScreen()));

class NomeScreen extends StatefulWidget {
  const NomeScreen({super.key});
  @override
  State<NomeScreen> createState() => _NomeScreenState();
}

class _NomeScreenState extends State<NomeScreen> {
  final _nomeCtrl = TextEditingController();
  final _sobrenomeCtrl = TextEditingController();
  String _nomeSalvo = '';
  String _sobrenomeSalvo = '';

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  Future<void> _carregar() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nomeSalvo = prefs.getString('nome') ?? '';
      _sobrenomeSalvo = prefs.getString('sobrenome') ?? '';
    });
  }

  Future<void> _salvar() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nome', _nomeCtrl.text.trim());
    await prefs.setString('sobrenome', _sobrenomeCtrl.text.trim());
    await _carregar();
    _nomeCtrl.clear();
    _sobrenomeCtrl.clear();
  }

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _sobrenomeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meu Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            if (_nomeSalvo.isNotEmpty)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: Text('$_nomeSalvo $_sobrenomeSalvo'),
                  subtitle: const Text('dados salvos'),
                ),
              ),
            const SizedBox(height: 24),
            TextField(
              controller: _nomeCtrl,
              decoration: const InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _sobrenomeCtrl,
              decoration: const InputDecoration(
                labelText: 'Sobrenome',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _salvar,
              icon: const Icon(Icons.save),
              label: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## 9. App de lista de tarefas com SharedPreferences

**Pergunta feita à IA:**
> Crie um app de lista de tarefas que salve as tarefas em SharedPreferences e as exiba na tela, mantendo as tarefas mesmo após o aplicativo ser fechado.

**Resposta da IA:**

SharedPreferences suporta `List<String>`, então as tarefas podem ser salvas diretamente como lista de strings.

```dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MaterialApp(home: TarefasScreen()));

class TarefasScreen extends StatefulWidget {
  const TarefasScreen({super.key});
  @override
  State<TarefasScreen> createState() => _TarefasScreenState();
}

class _TarefasScreenState extends State<TarefasScreen> {
  final _controller = TextEditingController();
  List<String> _tarefas = [];
  static const _chave = 'tarefas';

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  Future<void> _carregar() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _tarefas = prefs.getStringList(_chave) ?? [];
    });
  }

  Future<void> _salvar() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_chave, _tarefas);
  }

  Future<void> _adicionar() async {
    final texto = _controller.text.trim();
    if (texto.isEmpty) return;
    setState(() => _tarefas.add(texto));
    _controller.clear();
    await _salvar();
  }

  Future<void> _remover(int index) async {
    setState(() => _tarefas.removeAt(index));
    await _salvar();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas'),
        actions: [
          if (_tarefas.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              onPressed: () async {
                setState(() => _tarefas.clear());
                await _salvar();
              },
            ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Nova tarefa...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _adicionar(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: _adicionar,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          Expanded(
            child: _tarefas.isEmpty
                ? const Center(child: Text('Nenhuma tarefa ainda'))
                : ListView.builder(
                    itemCount: _tarefas.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.check_box_outline_blank),
                        title: Text(_tarefas[index]),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _remover(index),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
```

As tarefas persistem mesmo após fechar o app porque são salvas como `List<String>` no SharedPreferences a cada adição ou remoção.
