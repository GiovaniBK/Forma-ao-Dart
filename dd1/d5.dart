import 'dart:math';

void main(){
  // Lista de nomes
  final listaNomes = ['Ana', 'Francisco', 'Joao', 'Pedro', 'Gabriel', 'Rafaela', 'Marcio', 'Jose', 'Carlos', 'Patricia', 'Helena', 'Camila', 'Mateus', 'Gabriel', 'Maria', 'Samuel', 'Karina', 'Antonio', 'Daniel', 'Joel', 'Cristiana', 'Sebastião', 'Paula'];
  // Lista de sobrenomes
  final listaSobrenomes = ['Silva', 'Ferreira', 'Almeida', 'Azevedo', 'Braga', 'Barros', 'Campos', 'Cardoso', 'Teixeira', 'Costa', 'Santos', 'Rodrigues', 'Souza', 'Alves', 'Pereira', 'Lima', 'Gomes', 'Ribeiro', 'Carvalho', 'Lopes', 'Barbosa'];

  print(listaNomes.length);
  // Gera um nome completo aleatório combinando nome e sobrenome
  print('Nome: ${nomeAleatorio(listaNomes)} ${nomeAleatorio(listaSobrenomes)}');
}

// Seleciona aleatoriamente um elemento de uma lista
String nomeAleatorio(List<String> lista){
  final random = Random();
  final indiceAleatorio = random.nextInt(lista.length); // Gera um indice aleatório
  return lista[indiceAleatorio]; // Retorna um item aleatório da lista a partir do indice
}

