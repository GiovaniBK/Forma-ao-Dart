import 'dart:math';

void main(){
  final random = Random();
  // Seleciona um gênero musical aleatoriamente da lista de valores do enum
  final generoMusicalFavarito = GeneroMusical.values[random.nextInt(GeneroMusical.values.length)];
  // Exibe o nome do gênero selecionado
  print('Meu gênero musical preferido é o ${generoMusicalFavarito.name}');
}

// Define um enum com 8 gêneros musicais diferentes
enum GeneroMusical{
  rock,
  pop,
  jazz,
  clasica,
  trap,
  rap,
  samba,
  pagode
}