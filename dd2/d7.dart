import 'dart:collection';
import 'dart:math';

void main(){
  Fila fila = Fila();

  
  for (int i = 0; i < 10; i++) {
    Pessoa pessoa = Pessoa();
    pessoa.nome = pessoa.gerarNomeCompleto();
    fila.adicionarPessoa(pessoa);
    print('${pessoa.nome} entrou na fila.');
  }
  print('');
  
  for (int i = 0; i < 11; i++) {
    fila.atenderPessoa();
  }
}

class Fila {
  Queue<Pessoa> pessoas = Queue<Pessoa>();
  
  void adicionarPessoa(Pessoa pessoa) {
    pessoas.add(pessoa);
  }

  void atenderPessoa() {
    if (pessoas.isNotEmpty) {
      Pessoa pessoaAtendida = pessoas.removeFirst();
      print('${pessoaAtendida.nome} foi atendido(a).');
    } else {
      print('A fila está vazia.');
    }
  }
}


class Pessoa {
  String nome = '';

  String gerarNomeCompleto() {
    final listaNomes = ['Ana', 'Francisco', 'Joao', 'Pedro', 'Gabriel', 'Rafaela', 'Marcio', 'Jose', 'Carlos', 'Patricia', 'Helena', 'Camila', 'Mateus', 'Gabriel', 'Maria', 'Samuel', 'Karina', 'Antonio', 'Daniel', 'Joel', 'Cristiana', 'Sebastião', 'Paula'];
    final listaSobrenomes = ['Silva', 'Ferreira', 'Almeida', 'Azevedo', 'Braga', 'Barros', 'Campos', 'Cardoso', 'Teixeira', 'Costa', 'Santos', 'Rodrigues', 'Souza', 'Alves', 'Pereira', 'Lima', 'Gomes', 'Ribeiro', 'Carvalho', 'Lopes', 'Barbosa'];

    final random = Random();
    final indiceNomeAleatorio = random.nextInt(listaNomes.length);
    final indiceSobrenomeAleatorio = random.nextInt(listaSobrenomes.length);
    final nomeCompleto = '${listaNomes[indiceNomeAleatorio]} ${listaSobrenomes[indiceSobrenomeAleatorio]}';
    return nomeCompleto;
  }
}