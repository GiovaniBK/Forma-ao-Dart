import 'package:flutter/material.dart';
import 'package:apf6_funcoes/models/pessoa.dart';
import 'package:apf6_funcoes/state/estado_lista_de_pessoas.dart';
import 'package:apf6_funcoes/utils/tipos_sanguineos.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

const String _githubPrefix = 'https://github.com/';

class TelaFormulario extends StatefulWidget {
  const TelaFormulario({super.key, this.pessoa});

  final Pessoa? pessoa;

  @override
  State<TelaFormulario> createState() => _TelaFormularioState();
}

class _TelaFormularioState extends State<TelaFormulario> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nomeController;
  late final TextEditingController _emailController;
  late final TextEditingController _telefoneController;
  late final TextEditingController _githubController;
  TipoSanguineo? _tipoSanguineo;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.pessoa?.nome ?? '');
    _emailController = TextEditingController(text: widget.pessoa?.email ?? '');
    _telefoneController = TextEditingController(
      text: widget.pessoa?.telefone ?? '',
    );
    _githubController = TextEditingController(
      text: widget.pessoa?.github ?? _githubPrefix,
    );
    _tipoSanguineo = widget.pessoa?.tipoSanguineo;
    if (widget.pessoa == null) {
      _githubController.selection = TextSelection.collapsed(
        offset: _githubPrefix.length,
      );
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _githubController.dispose();
    super.dispose();
  }

  bool get _editando => widget.pessoa != null;

  String? _validarNomeCompleto(String? valor) {
    final erroBase = _validarTextoObrigatorio(valor, 'nome');
    if (erroBase != null) {
      return erroBase;
    }

    final nome = valor!.trim();
    final nomeValido = RegExp(
      r'^[A-Za-zÀ-ÿ]+([ .][A-Za-zÀ-ÿ]+)*$',
    ).hasMatch(nome);
    if (!nomeValido) {
      return 'Use somente letras, espaço e ponto no nome.';
    }

    return null;
  }

  String? _validarTelefone(String? valor) {
    final erroBase = _validarTextoObrigatorio(valor, 'telefone');
    if (erroBase != null) {
      return erroBase;
    }

    final telefone = valor!.trim();
    if (!RegExp(r'^\d{8,13}$').hasMatch(telefone)) {
      return 'Informe um telefone válido.';
    }

    return null;
  }

  String? _validarGithub(String? valor) {
    final erroBase = _validarTextoObrigatorio(valor, 'link do GitHub');
    if (erroBase != null) {
      return erroBase;
    }

    final github = valor!.trim();
    if (!github.startsWith(_githubPrefix) ||
        github.length <= _githubPrefix.length) {
      return 'Informe um link válido do GitHub.';
    }

    return null;
  }

  Future<void> _salvar() async {
    if (!(_formKey.currentState?.validate() ?? false) ||
        _tipoSanguineo == null) {
      if (_tipoSanguineo == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Selecione um tipo sanguíneo.')),
        );
      }
      return;
    }

    final pessoa = Pessoa(
      nome: _nomeController.text.trim(),
      email: _emailController.text.trim(),
      telefone: _telefoneController.text.trim(),
      github: _githubController.text.trim(),
      tipoSanguineo: _tipoSanguineo!,
    );

    final estado = context.read<EstadoListaDePessoas>();
    if (_editando) {
      estado.editar(widget.pessoa!, pessoa);
    } else {
      estado.incluir(pessoa);
    }

    if (mounted) {
      FocusScope.of(context).unfocus();
      Navigator.of(context).pop();
    }
  }

  String? _validarTextoObrigatorio(String? valor, String campo) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Informe o $campo.';
    }
    return null;
  }

  String? _validarEmail(String? valor) {
    final erro = _validarTextoObrigatorio(valor, 'e-mail');
    if (erro != null) {
      return erro;
    }

    final email = valor!.trim();
    final emailValido = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
    if (!emailValido) {
      return 'Informe um e-mail válido.';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editando ? 'Editar pessoa' : 'Incluir pessoa'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                TextFormField(
                  controller: _nomeController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"[A-Za-zÀ-ÿ .]")),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Nome completo',
                    border: OutlineInputBorder(),
                  ),
                  validator: _validarNomeCompleto,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder(),
                  ),
                  validator: _validarEmail,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _telefoneController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: 'Telefone (Somente números)',
                    border: OutlineInputBorder(),
                  ),
                  validator: _validarTelefone,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _githubController,
                  keyboardType: TextInputType.url,
                  decoration: const InputDecoration(
                    labelText: 'Link do GitHub',
                    helperText: _githubPrefix,
                    border: OutlineInputBorder(),
                  ),
                  validator: _validarGithub,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<TipoSanguineo>(
                  value: _tipoSanguineo,
                  decoration: const InputDecoration(
                    labelText: 'Tipo sanguíneo',
                    border: OutlineInputBorder(),
                  ),
                  items: TipoSanguineo.values
                      .map(
                        (tipo) => DropdownMenuItem<TipoSanguineo>(
                          value: tipo,
                          child: Text(tipo.label),
                        ),
                      )
                      .toList(),
                  onChanged: (valor) {
                    setState(() {
                      _tipoSanguineo = valor;
                    });
                  },
                  validator: (valor) =>
                      valor == null ? 'Selecione um tipo sanguíneo.' : null,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _salvar,
                    icon: const Icon(Icons.save),
                    label: const Text('Salvar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
