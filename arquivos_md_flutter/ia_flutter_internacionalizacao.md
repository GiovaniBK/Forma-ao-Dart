# IA como apoio – Flutter: Internacionalização

Atividade da Lince Tech Academy sobre internacionalização, arquivos ARB e pacote intl.

---

## 1. O que é internacionalização e qual sua importância?

**Pergunta feita à IA:**
> O que é internacionalização e o qual sua importância?

**Resposta da IA:**

Internacionalização (i18n) é o processo de preparar um app para suportar múltiplos idiomas, regiões e culturas sem precisar reescrever o código para cada um. O nome "i18n" vem de "internationalization" — 18 letras entre o "i" e o "n".

Localização (l10n) é a etapa seguinte: adaptar o app para um idioma/região específico, fornecendo as traduções e formatos corretos.

A importância é clara: um app disponível só em inglês exclui grande parte dos usuários potenciais. Além de traduções, internacionalização cobre:
- Formatos de data: `12/31/2024` (EUA) vs `31/12/2024` (Brasil)
- Formatos de moeda: `$1,000.50` vs `R$ 1.000,50`
- Direção do texto: esquerda para direita (português) vs direita para esquerda (árabe)
- Pluralização: "1 item" vs "2 itens"

---

## 2. Como funciona a internacionalização no Flutter?

**Pergunta feita à IA:**
> Como funciona a internacionalização no Flutter?

**Resposta da IA:**

O Flutter usa o pacote `flutter_localizations` (já incluso no SDK) junto com o `intl` para internacionalização. O fluxo básico é:

1. Adicionar dependências no `pubspec.yaml`.
2. Criar arquivos `.arb` com as strings traduzidas para cada idioma.
3. Rodar o gerador de código que cria as classes Dart a partir dos ARBs.
4. Configurar o `MaterialApp` com os delegates de localização.
5. Usar as strings no código via a classe gerada.

```yaml
# pubspec.yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  intl: ^0.19.0

flutter:
  generate: true  # habilita geração automática das classes
```

```dart
// l10n.yaml (na raiz do projeto)
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
```

---

## 3. Quais as dicas de uso dos arquivos ARB?

**Pergunta feita à IA:**
> Quais as dicas de uso dos arquivos ARB?

**Resposta da IA:**

ARB (Application Resource Bundle) são arquivos JSON com extensão `.arb` que contêm as strings traduzidas de cada idioma.

**Estrutura básica:**
```json
// lib/l10n/app_pt.arb
{
  "@@locale": "pt",
  "titulo": "Meu Aplicativo",
  "@titulo": {
    "description": "Título principal do app"
  },
  "bemVindo": "Bem-vindo, {nome}!",
  "@bemVindo": {
    "description": "Mensagem de boas-vindas",
    "placeholders": {
      "nome": {
        "type": "String"
      }
    }
  },
  "itensNoCarrinho": "{quantidade, plural, =0{Carrinho vazio} =1{1 item} other{{quantidade} itens}}",
  "@itensNoCarrinho": {
    "placeholders": {
      "quantidade": { "type": "int" }
    }
  }
}
```

**Dicas:**
- O arquivo template (geralmente `app_en.arb`) define todas as chaves — os outros idiomas precisam ter as mesmas chaves.
- Sempre adicione `@chave` com `description` — ajuda tradutores a entender o contexto.
- Use placeholders para valores dinâmicos — nunca concatene strings fora do ARB.
- Mantenha as chaves em camelCase e descritivas.
- Não traduza as chaves — só os valores.

---

## 4. Quais cuidados devo ter ao usar o INTL?

**Pergunta feita à IA:**
> Quais cuidados devo ter ao usar o INTL?

**Resposta da IA:**

- **Sempre inicialize o locale antes de usar**: em alguns casos é necessário chamar `Intl.defaultLocale` ou configurar via `MaterialApp`.

- **Não hardcode strings na UI**: qualquer texto visível ao usuário deve vir do ARB, não diretamente no código.

- **Cuide com pluralização**: cada idioma tem regras diferentes. Russo tem 4 formas de plural, árabe tem 6. Use a sintaxe ICU do ARB para cobrir todos os casos.

- **Datas e horas precisam de locale**: `DateFormat` sem locale usa o padrão do sistema — especifique sempre:
```dart
DateFormat.yMMMd('pt_BR').format(DateTime.now());
```

- **Rodar o gerador após cada mudança no ARB**: use `flutter gen-l10n` ou deixe o `generate: true` no pubspec para geração automática ao buildar.

- **Versione os arquivos ARB**: são parte do código, não gerados — devem estar no repositório.

- **Não misture lógica com tradução**: a classe gerada deve ser usada só para strings, não para lógica de negócio.

---

## 5. Como adicionar suporte para diferentes idiomas em Flutter?

**Pergunta feita à IA:**
> Como posso adicionar suporte para diferentes idiomas em meu aplicativo Flutter?

**Resposta da IA:**

**Passo 1 — configurar o MaterialApp:**
```dart
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

MaterialApp(
  localizationsDelegates: const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: const [
    Locale('pt', 'BR'),
    Locale('en', 'US'),
    Locale('es'),
  ],
  home: const HomeScreen(),
)
```

**Passo 2 — criar os ARBs:**
```json
// lib/l10n/app_en.arb
{
  "@@locale": "en",
  "hello": "Hello",
  "save": "Save"
}

// lib/l10n/app_pt.arb
{
  "@@locale": "pt",
  "hello": "Olá",
  "save": "Salvar"
}
```

**Passo 3 — usar no widget:**
```dart
@override
Widget build(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  return Text(l10n.hello);
}
```

O Flutter detecta automaticamente o idioma do dispositivo e usa o locale correspondente se suportado.

---

## 6. Formulário de cadastro com internacionalização

**Pergunta feita à IA:**
> Mostre o exemplo de um formulário de cadastro usando internacionalização?

**Resposta da IA:**

**Arquivo ARB (app_pt.arb):**
```json
{
  "@@locale": "pt",
  "cadastroTitulo": "Cadastro",
  "campoNome": "Nome",
  "campoEmail": "E-mail",
  "campoSenha": "Senha",
  "botaoCadastrar": "Cadastrar",
  "erroNomeObrigatorio": "Nome é obrigatório",
  "erroEmailInvalido": "E-mail inválido",
  "erroSenhaCurta": "Senha deve ter ao menos 6 caracteres"
}
```

**Arquivo ARB (app_en.arb):**
```json
{
  "@@locale": "en",
  "cadastroTitulo": "Sign Up",
  "campoNome": "Name",
  "campoEmail": "Email",
  "campoSenha": "Password",
  "botaoCadastrar": "Sign Up",
  "erroNomeObrigatorio": "Name is required",
  "erroEmailInvalido": "Invalid email",
  "erroSenhaCurta": "Password must be at least 6 characters"
}
```

**Widget do formulário:**
```dart
class CadastroForm extends StatefulWidget {
  const CadastroForm({super.key});
  @override
  State<CadastroForm> createState() => _CadastroFormState();
}

class _CadastroFormState extends State<CadastroForm> {
  final _formKey = GlobalKey<FormState>();
  final _nomeCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _senhaCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.cadastroTitulo)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeCtrl,
                decoration: InputDecoration(labelText: l10n.campoNome),
                validator: (v) =>
                    v == null || v.isEmpty ? l10n.erroNomeObrigatorio : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailCtrl,
                decoration: InputDecoration(labelText: l10n.campoEmail),
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || !v.contains('@')) return l10n.erroEmailInvalido;
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _senhaCtrl,
                decoration: InputDecoration(labelText: l10n.campoSenha),
                obscureText: true,
                validator: (v) =>
                    v == null || v.length < 6 ? l10n.erroSenhaCurta : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // processar cadastro
                  }
                },
                child: Text(l10n.botaoCadastrar),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## 7. Como lidar com formatos de data, hora e moeda em diferentes idiomas?

**Pergunta feita à IA:**
> Como posso lidar com diferentes formatos de data, hora e moeda em diferentes idiomas?

**Resposta da IA:**

O pacote `intl` fornece `DateFormat` e `NumberFormat` para isso:

**Datas:**
```dart
import 'package:intl/intl.dart';

final data = DateTime.now();

// formato por locale
print(DateFormat.yMMMd('pt_BR').format(data)); // 28 de mai. de 2024
print(DateFormat.yMMMd('en_US').format(data)); // May 28, 2024
print(DateFormat.yMMMd('ja').format(data));    // 2024年5月28日

// formatos específicos
print(DateFormat('dd/MM/yyyy', 'pt_BR').format(data)); // 28/05/2024
print(DateFormat('MM/dd/yyyy', 'en_US').format(data)); // 05/28/2024

// hora
print(DateFormat.jm('pt_BR').format(data)); // 14:30
print(DateFormat.jm('en_US').format(data)); // 2:30 PM
```

**Moeda:**
```dart
// moeda formatada por locale
print(NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(1500.5));
// R$ 1.500,50

print(NumberFormat.currency(locale: 'en_US', symbol: '\$').format(1500.5));
// $1,500.50

print(NumberFormat.currency(locale: 'de_DE', symbol: '€').format(1500.5));
// 1.500,50 €

// número simples com separadores do locale
print(NumberFormat.decimalPattern('pt_BR').format(1234567.89));
// 1.234.567,89

print(NumberFormat.decimalPattern('en_US').format(1234567.89));
// 1,234,567.89
```

**Usando o locale do contexto Flutter:**
```dart
@override
Widget build(BuildContext context) {
  final locale = Localizations.localeOf(context).toString();
  final preco = NumberFormat.currency(locale: locale).format(99.90);
  return Text(preco);
}
```
