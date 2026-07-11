import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apf6_funcoes/models/pessoa.dart';
import 'package:apf6_funcoes/state/estado_lista_de_pessoas.dart';
import 'package:apf6_funcoes/utils/tipos_sanguineos.dart';

class TelaListagem extends StatefulWidget {
  const TelaListagem({super.key});

  @override
  State<TelaListagem> createState() => _TelaListagemState();
}

class _TelaListagemState extends State<TelaListagem> {
  late final TextEditingController _filtroNomeController;

  @override
  void initState() {
    super.initState();
    final estado = context.read<EstadoListaDePessoas>();
    _filtroNomeController = TextEditingController(text: estado.filtroNome);
  }

  @override
  void dispose() {
    _filtroNomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final estado = context.watch<EstadoListaDePessoas>();
    final pessoas = estado.pessoasFiltradas;

    // mantém o controller sincronizado quando o filtro muda por fora (ex: "Limpar filtros")
    if (_filtroNomeController.text != estado.filtroNome) {
      _filtroNomeController.text = estado.filtroNome;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de pessoas'),
        actions: [
          IconButton(
            tooltip: 'Limpar filtros',
            onPressed: estado.limparFiltros,
            icon: const Icon(Icons.filter_alt_off),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: _filtroNomeController,
              onChanged: estado.definirFiltroNome,
              decoration: const InputDecoration(
              labelText: 'Filtrar por nome',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButtonFormField<TipoSanguineo?>(
              value: estado.filtroTipoSanguineo,
              decoration: const InputDecoration(
                labelText: 'Filtrar por tipo sanguíneo',
                border: OutlineInputBorder(),
              ),
              items: [
                const DropdownMenuItem<TipoSanguineo?>(
                  value: null,
                  child: Text('Todos'),
                ),
                ...TipoSanguineo.values.map(
                  (tipo) => DropdownMenuItem<TipoSanguineo?>(
                    value: tipo,
                    child: Text(tipo.label),
                  ),
                ),
              ],
              onChanged: estado.definirFiltroTipo,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: pessoas.isEmpty
                ? const Center(
                    child: Text('Nenhuma pessoa encontrada.'),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: pessoas.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final pessoa = pessoas[index];
                      return _PessoaCard(pessoa: pessoa);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _PessoaCard extends StatelessWidget {
  const _PessoaCard({required this.pessoa});

  final Pessoa pessoa;

  @override
  Widget build(BuildContext context) {
    final estado = context.read<EstadoListaDePessoas>();

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Container(
        color: pessoa.tipoSanguineo.cor,
        child: ListTile(
          title: Text(pessoa.nome),
          subtitle: Text(
            'E-mail: ${pessoa.email}\n'
            'Telefone: ${pessoa.telefone}\n'
            'GitHub: ${pessoa.github}\n'
            'Tipo sanguíneo: ${pessoa.tipoSanguineo.label}',
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.pushNamed(context, '/formulario', arguments: pessoa);
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  final confirmar = await showDialog<bool>(
                    context: context,
                    builder: (dialogContext) {
                      return AlertDialog(
                        title: const Text('Excluir pessoa'),
                        content: Text('Deseja excluir ${pessoa.nome}?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(dialogContext, false),
                            child: const Text('Cancelar'),
                          ),
                          FilledButton(
                            onPressed: () => Navigator.pop(dialogContext, true),
                            child: const Text('Excluir'),
                          ),
                        ],
                      );
                    },
                  );

                  if (confirmar == true) {
                    estado.excluir(pessoa);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
