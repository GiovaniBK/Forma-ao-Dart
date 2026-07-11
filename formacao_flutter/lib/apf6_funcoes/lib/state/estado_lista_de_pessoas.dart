import 'package:flutter/material.dart';
import 'package:apf6_funcoes/models/pessoa.dart';
import 'package:apf6_funcoes/utils/tipos_sanguineos.dart';

class EstadoListaDePessoas with ChangeNotifier {
	final List<Pessoa> _listaDePessoas = [];

	String _filtroNome = '';
	TipoSanguineo? _filtroTipoSanguineo;

	List<Pessoa> get pessoas => List.unmodifiable(_listaDePessoas);

	String get filtroNome => _filtroNome;

	TipoSanguineo? get filtroTipoSanguineo => _filtroTipoSanguineo;

	List<Pessoa> get pessoasFiltradas {
		return _listaDePessoas.where((pessoa) {
			final nomeConfere = _filtroNome.isEmpty || pessoa.nome.toLowerCase().contains(_filtroNome.toLowerCase());
			final tipoConfere = _filtroTipoSanguineo == null || pessoa.tipoSanguineo == _filtroTipoSanguineo;
			return nomeConfere && tipoConfere;
		}).toList(growable: false);
	}

	void incluir(Pessoa pessoa) {
		_listaDePessoas.add(pessoa);
		notifyListeners();
	}

	void excluir(Pessoa pessoa) {
		_listaDePessoas.remove(pessoa);
		notifyListeners();
	}

	void editar(Pessoa antiga, Pessoa nova) {
		final indice = _listaDePessoas.indexWhere((pessoa) => identical(pessoa, antiga) || pessoa == antiga);
		if (indice == -1) {
			return;
		}

		_listaDePessoas[indice] = nova;
		notifyListeners();
	}

	void definirFiltroNome(String valor) {
		_filtroNome = valor;
		notifyListeners();
	}

	void definirFiltroTipo(TipoSanguineo? valor) {
		_filtroTipoSanguineo = valor;
		notifyListeners();
	}

	void limparFiltros() {
		_filtroNome = '';
		_filtroTipoSanguineo = null;
		notifyListeners();
	}
}
