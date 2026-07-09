# IA como apoio – Flutter: Formulários

Atividade da Lince Tech Academy sobre TextField, validação, CheckBox e Radio.

---

## 1. O que é um widget TextField em Flutter e para que ele serve?

**Pergunta feita à IA:**
> O que é um widget TextField em Flutter e para que ele serve?

**Resposta da IA:**

`TextField` é o widget básico de entrada de texto no Flutter. Permite que o usuário digite informações — nome, email, senha, mensagem, etc.

```dart
TextField(
  decoration: InputDecoration(
    labelText: 'Nome',
    hintText: 'Digite seu nome',
    border: OutlineInputBorder(),
  ),
)
```

Por padrão não faz nada com o texto digitado — é preciso conectar um `TextEditingController` ou usar o callback `onChanged` para capturar o valor.

---

## 2. Como posso obter o valor digitado pelo usuário em um TextField?

**Pergunta feita à IA:**
> Como posso obter o valor digitado pelo usuário em um TextField?

**Resposta da IA:**

Há duas formas:

**Com `TextEditingController` (mais comum):**
```dart
final _controller = TextEditingController();

TextField(controller: _controller)

// lê o valor quando quiser
print(_controller.text);

// lembre de liberar no dispose
@override
void dispose() {
  _controller.dispose();
  super.dispose();
}
```

**Com `onChanged` (reage a cada tecla digitada):**
```dart
String _valor = '';

TextField(
  onChanged: (texto) {
    setState(() => _valor = texto);
  },
)
```

O `controller` é melhor quando você precisa do valor num momento específico (ao clicar em salvar). O `onChanged` é melhor para validação em tempo real.

---

## 3. Qual a diferença entre TextField e TextFormField?

**Pergunta feita à IA:**
> Qual a diferença entre um TextField e um TextFormField?

**Resposta da IA:**

- **`TextField`** — widget básico de entrada de texto. Sem integração com formulário.
- **`TextFormField`** — extende o `TextField` e se integra com o widget `Form`. Suporta validação via parâmetro `validator` e é controlado pelo `FormState`.

```dart
// com Form + TextFormField — validação integrada
final _formKey = GlobalKey<FormState>();

Form(
  key: _formKey,
  child: TextFormField(
    validator: (valor) {
      if (valor == null || valor.isEmpty) return 'campo obrigatório';
      return null;
    },
  ),
)

// para validar
_formKey.currentState!.validate();
```

Para formulários com múltiplos campos e validação, `TextFormField` dentro de um `Form` é o caminho certo. Para campos isolados simples, `TextField` basta.

---

## 4. Quais os parâmetros importantes do TextField?

**Pergunta feita à IA:**
> Quais parâmetros importantes do TextField?

**Resposta da IA:**

| Parâmetro | Descrição |
|---|---|
| `controller` | Controla e lê o texto |
| `decoration` | Aparência: label, hint, borda, ícones, erro |
| `keyboardType` | Tipo de teclado: `text`, `number`, `emailAddress`, `phone` |
| `obscureText` | Oculta o texto (para senhas) |
| `maxLength` | Limite de caracteres |
| `maxLines` | Número de linhas (null = ilimitado) |
| `onChanged` | Callback chamado a cada caractere |
| `onSubmitted` | Callback ao pressionar enter/confirmar |
| `enabled` | Habilita ou desabilita o campo |
| `readOnly` | Permite ver mas não editar |
| `autofocus` | Foca automaticamente ao abrir a tela |
| `textCapitalization` | Capitalização automática |
| `inputFormatters` | Máscara e filtros de entrada |

---

## 5. O que significa validar um campo de texto em Flutter?

**Pergunta feita à IA:**
> O que significa validar um campo de texto em Flutter?

**Resposta da IA:**

Validar significa verificar se o conteúdo digitado atende às regras esperadas antes de processar ou enviar os dados. Exemplos: campo não pode estar vazio, email precisa ter `@`, senha precisa ter pelo menos 8 caracteres.

No Flutter, a validação de formulários usa `Form` + `TextFormField` + `validator`:

```dart
TextFormField(
  validator: (valor) {
    if (valor == null || valor.isEmpty) {
      return 'este campo é obrigatório';
    }
    if (valor.length < 3) {
      return 'mínimo de 3 caracteres';
    }
    return null; // null = válido
  },
)
```

A função `validator` retorna uma `String` com a mensagem de erro, ou `null` se o valor for válido. A mensagem aparece automaticamente abaixo do campo.

---

## 6. Qual a diferença entre validação síncrona e assíncrona?

**Pergunta feita à IA:**
> Qual a diferença entre validação síncrona e assíncrona?

**Resposta da IA:**

- **Síncrona** — a validação acontece imediatamente, sem esperar por nada externo. É o padrão do `validator` no `TextFormField`. Verifica formato, tamanho, regex, etc.

```dart
validator: (valor) {
  if (valor!.isEmpty) return 'obrigatório';
  return null;
}
```

- **Assíncrona** — precisa consultar algo externo antes de validar: verificar se um email já está cadastrado no banco, checar disponibilidade de um username, etc.

O `TextFormField` não suporta `validator` assíncrono nativamente. A abordagem comum é validar ao sair do campo (`onEditingComplete` ou `onFieldSubmitted`) e atualizar o estado com a mensagem de erro manualmente:

```dart
String? _erroEmail;

TextFormField(
  decoration: InputDecoration(errorText: _erroEmail),
  onChanged: (valor) async {
    final existe = await verificarEmail(valor);
    setState(() {
      _erroEmail = existe ? 'email já cadastrado' : null;
    });
  },
)
```

---

## 7. O que é um widget CheckBox em Flutter e para que ele serve?

**Pergunta feita à IA:**
> O que é um widget CheckBox em Flutter e para que ele serve?

**Resposta da IA:**

`Checkbox` é um widget de seleção binária — marcado ou desmarcado. Usado para aceitar termos, ativar opções, selecionar itens de uma lista.

```dart
bool _aceito = false;

Checkbox(
  value: _aceito,
  onChanged: (valor) {
    setState(() => _aceito = valor!);
  },
)
```

O `Checkbox` sozinho não tem label — para combinar com texto, use `CheckboxListTile`:

```dart
CheckboxListTile(
  title: Text('Aceitar termos e condições'),
  value: _aceito,
  onChanged: (valor) => setState(() => _aceito = valor!),
  controlAffinity: ListTileControlAffinity.leading, // checkbox à esquerda
)
```

---

## 8. Como posso alterar a cor e a forma de um CheckBox?

**Pergunta feita à IA:**
> Como posso alterar a cor e a forma de um CheckBox?

**Resposta da IA:**

```dart
Checkbox(
  value: _aceito,
  onChanged: (v) => setState(() => _aceito = v!),

  // cor do check e do fundo quando marcado
  activeColor: Colors.green,
  checkColor: Colors.white,

  // borda customizada
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(4),
  ),

  // cor da borda quando desmarcado
  side: BorderSide(color: Colors.grey, width: 2),
)
```

Para mudar globalmente no app, configure no `ThemeData`:
```dart
ThemeData(
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.all(Colors.deepPurple),
    shape: CircleBorder(), // checkbox circular
  ),
)
```

---

## 9. O que é um widget Radio em Flutter e qual sua aplicabilidade?

**Pergunta feita à IA:**
> O que é um widget Radio em Flutter e qual sua aplicabilidade?

**Resposta da IA:**

`Radio` é um widget de seleção exclusiva dentro de um grupo — selecionar um desseleciona os outros automaticamente. Ideal para opções mutuamente exclusivas: sexo, método de pagamento, tamanho de camiseta.

```dart
String? _opcao;

Column(
  children: [
    Radio<String>(
      value: 'sim',
      groupValue: _opcao,
      onChanged: (v) => setState(() => _opcao = v),
    ),
    Radio<String>(
      value: 'nao',
      groupValue: _opcao,
      onChanged: (v) => setState(() => _opcao = v),
    ),
  ],
)
```

O `groupValue` é o valor atualmente selecionado. Quando `value == groupValue`, o radio aparece marcado. Para combinar com label, use `RadioListTile`.

---

## 10. Como posso alterar a cor e a forma de um Radio?

**Pergunta feita à IA:**
> Como posso alterar a cor e a forma de um Rádio?

**Resposta da IA:**

```dart
Radio<String>(
  value: 'opcao',
  groupValue: _selecionado,
  onChanged: (v) => setState(() => _selecionado = v),

  activeColor: Colors.deepOrange, // cor quando selecionado
  fillColor: MaterialStateProperty.resolveWith((states) {
    if (states.contains(MaterialState.selected)) return Colors.green;
    return Colors.grey;
  }),
)
```

O `Radio` não tem parâmetro de `shape` direto como o `Checkbox`. Para personalização visual mais profunda, é comum criar um widget customizado usando `InkWell` + `Container` com a aparência desejada.

---

## 11. Como limitar o número de caracteres em um TextField?

**Pergunta feita à IA:**
> Como posso limitar o número de caracteres que o usuário pode digitar em um TextField?

**Resposta da IA:**

```dart
TextField(
  maxLength: 50, // mostra contador e bloqueia após 50 caracteres
  decoration: InputDecoration(
    labelText: 'Bio',
    counterText: '', // esconde o contador se não quiser exibir
  ),
)
```

Para limitar sem mostrar contador:
```dart
import 'package:flutter/services.dart';

TextField(
  inputFormatters: [
    LengthLimitingTextInputFormatter(50),
  ],
)
```

---

## 12. Como alterar o tipo de teclado exibido para um TextField?

**Pergunta feita à IA:**
> Como posso alterar o tipo de teclado exibido para um TextField (numérico, email etc.)?

**Resposta da IA:**

Usando o parâmetro `keyboardType`:

```dart
// teclado numérico
TextField(keyboardType: TextInputType.number)

// teclado com @ e .com para email
TextField(keyboardType: TextInputType.emailAddress)

// teclado de telefone
TextField(keyboardType: TextInputType.phone)

// teclado com URL
TextField(keyboardType: TextInputType.url)

// texto com múltiplas linhas
TextField(
  keyboardType: TextInputType.multiline,
  maxLines: null, // ilimitado
)
```

---

## 13. Como adicionar um ícone ao lado do texto em um TextField?

**Pergunta feita à IA:**
> Como posso adicionar um ícone ao lado do texto em um TextField?

**Resposta da IA:**

Através do `InputDecoration`:

```dart
TextField(
  decoration: InputDecoration(
    // ícone fora do campo (à esquerda, antes da borda)
    icon: Icon(Icons.person),

    // ícone dentro do campo à esquerda
    prefixIcon: Icon(Icons.search),

    // ícone dentro do campo à direita
    suffixIcon: IconButton(
      icon: Icon(Icons.clear),
      onPressed: () => _controller.clear(),
    ),

    // texto antes do input
    prefixText: 'R\$ ',

    // texto depois do input
    suffixText: 'kg',
  ),
)
```

---

## 14. Como exibir mensagens de erro para o usuário se a validação falhar?

**Pergunta feita à IA:**
> Como posso exibir mensagens de erro para o usuário se a validação falhar?

**Resposta da IA:**

**Com Form + TextFormField (recomendado):**
```dart
final _formKey = GlobalKey<FormState>();

Form(
  key: _formKey,
  child: Column(
    children: [
      TextFormField(
        validator: (v) => v!.isEmpty ? 'campo obrigatório' : null,
      ),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // tudo válido, prosseguir
          }
        },
        child: Text('Enviar'),
      ),
    ],
  ),
)
```

**Manualmente com `errorText`:**
```dart
String? _erro;

TextField(
  decoration: InputDecoration(
    errorText: _erro, // null = sem erro, String = exibe o erro
  ),
  onChanged: (v) {
    setState(() {
      _erro = v.isEmpty ? 'obrigatório' : null;
    });
  },
)
```

---

## 15. Formulário com CheckBox para aceitar termos e condições

**Pergunta feita à IA:**
> Crie um formulário com um CheckBox para 'Aceitar termos e condições'.

**Resposta da IA:**

```dart
class TermosForm extends StatefulWidget {
  const TermosForm({super.key});
  @override
  State<TermosForm> createState() => _TermosFormState();
}

class _TermosFormState extends State<TermosForm> {
  bool _aceitouTermos = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CheckboxListTile(
            title: const Text('Aceito os termos e condições'),
            value: _aceitouTermos,
            onChanged: (v) => setState(() => _aceitouTermos = v!),
            controlAffinity: ListTileControlAffinity.leading,
          ),
          ElevatedButton(
            onPressed: () {
              if (!_aceitouTermos) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Aceite os termos para continuar')),
                );
                return;
              }
              // prosseguir
            },
            child: const Text('Cadastrar'),
          ),
        ],
      ),
    );
  }
}
```

---

## 16. Grupo de Radios para seleção de preferência

**Pergunta feita à IA:**
> Crie um grupo de Radios para permitir que o usuário selecione sua preferência (Aceita ketchup: Não, Sim).

**Resposta da IA:**

```dart
class PreferenciaKetchup extends StatefulWidget {
  const PreferenciaKetchup({super.key});
  @override
  State<PreferenciaKetchup> createState() => _PreferenciaKetchupState();
}

class _PreferenciaKetchupState extends State<PreferenciaKetchup> {
  String? _aceitaKetchup;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Aceita ketchup?', style: TextStyle(fontWeight: FontWeight.bold)),
        RadioListTile<String>(
          title: const Text('Não'),
          value: 'nao',
          groupValue: _aceitaKetchup,
          onChanged: (v) => setState(() => _aceitaKetchup = v),
        ),
        RadioListTile<String>(
          title: const Text('Sim'),
          value: 'sim',
          groupValue: _aceitaKetchup,
          onChanged: (v) => setState(() => _aceitaKetchup = v),
        ),
        if (_aceitaKetchup != null)
          Text('Selecionado: $_aceitaKetchup'),
      ],
    );
  }
}
```

---

## 17. Como verificar se o texto digitado é um email válido?

**Pergunta feita à IA:**
> Como posso verificar se o texto digitado em um campo é um email válido?

**Resposta da IA:**

Usando regex dentro do `validator`:

```dart
TextFormField(
  keyboardType: TextInputType.emailAddress,
  decoration: const InputDecoration(
    labelText: 'Email',
    prefixIcon: Icon(Icons.email),
  ),
  validator: (valor) {
    if (valor == null || valor.isEmpty) {
      return 'informe seu email';
    }

    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(valor)) {
      return 'email inválido';
    }

    return null;
  },
)
```

Para validações mais robustas, pacotes como `email_validator` fazem isso com mais casos cobertos do que um regex simples. Mas para a maioria dos casos o regex básico resolve bem.
