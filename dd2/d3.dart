import 'dart:io';

void main(){
  final listaDeMusicas = [
    Musica('Bohemian Rhapsody', 'Queen', 'A Night at the Opera', 354),
    Musica('Imagine', 'John Lennon', 'Imagine', 183),
    Musica('Stairway to Heaven', 'Led Zeppelin', 'Led Zeppelin IV', 482),
    Musica('Hotel California', 'Eagles', 'Hotel California', 391),
    Musica('Comfortably Numb', 'Pink Floyd', 'The Wall', 432),
    Musica('Another One Bites the Dust', 'Queen', 'The Game', 217),
    Musica('Sweet Child O Mine', 'Guns N Roses', 'Appetite for Destruction', 356),
    Musica('Smells Like Teen Spirit', 'Nirvana', 'Nevermind', 301),
    Musica('Like a Rolling Stone', 'Bob Dylan', 'Highway 61 Revisited', 369),
    Musica('What is Love', 'Haddaway', 'What is Love', 247),
    Musica('Bitter Sweet Symphony', 'The Verve', 'Urban Hymns', 344),
    Musica('Eye of the Tiger', 'Survivor', 'Eye of the Tiger', 247),
    Musica('Wonderwall', 'Oasis', '(What is the Story) Morning Glory?', 258),
    Musica('Black', 'Pearl Jam', 'Vitalogy', 343),
    Musica('Come As You Are', 'Nirvana', 'Nevermind', 219),
  ];

  print("Musicas cadastradas: \n");
  for (var musica in listaDeMusicas) {
    print(musica.titulo);
  }

  print("\nNúmero total de músicas: ${listaDeMusicas.length}");
  
  double tempoTotal = 0.0;
  for (var musica in listaDeMusicas) {
    tempoTotal += musica.duracaoSegundos;
  }
  tempoTotal /= 3600;

  print("Tempo total das músicas, em horas: ${tempoTotal.toStringAsFixed(2)}");

  while (true) {
    // Executa busca interativa repetidamente até o usuário desejar sair.
    buscarMusica(listaDeMusicas);

    bool resposta = continuar();
    if (resposta) {
      continue;
    }else{
      print("Até logo");
      break;
    }
  }
}

class Musica {
  final String titulo;
  final String artista;
  final String album;
  final int duracaoSegundos;

  Musica(this.titulo, this.artista, this.album, this.duracaoSegundos);
}

void buscarMusica(List<Musica> lista){
  // Pergunta ao usuário qual método de busca deseja utilizar.
  stdout.write("Você quer buscar música pelo título, nome do artista ou nome do album (Digite T = título  N = nome do artista  A = nome do album): ");
  String resposta = (stdin.readLineSync()!).toUpperCase();
  switch (resposta) {
    case "T":
      stdout.write("Digite o título da música que você quer pesquisar: ");
      resposta = (stdin.readLineSync()!).toUpperCase();
      buscarTitulo(resposta, lista);
      break;
    case "N":
      stdout.write("Digite o nome do artista da música que você quer pesquisar: ");
      resposta = (stdin.readLineSync()!).toUpperCase();
      buscarArtista(resposta, lista);
      break;
    case "A":
      stdout.write("Digite o nome do album da música que você quer pesquisar: ");
      resposta = (stdin.readLineSync()!).toUpperCase();
      buscarAlbum(resposta, lista);
      break;
    default:
      print("Opção inválida, tente novamente");
  }
}

void buscarTitulo(String titulo, List<Musica> lista){
  for (var musica in lista) {
    if (titulo == (musica.titulo).toUpperCase()) {
      // Encontrou música com título exato
      print("Música encontrada no cadastro");
      print("${musica.titulo} - Album: ${musica.album} - Autor: ${musica.artista}");
      return;
    }
  }
  print("Está música não foi encontrada");
}

void buscarArtista(String artista, List<Musica> lista) {
  bool encontrou = false;
  for (var musica in lista) {
    if (artista == musica.artista.toUpperCase()) {
      if (!encontrou) print("Música(s) encontrada(s) no cadastro:");
      print("${musica.titulo} - Album: ${musica.album} - Autor: ${musica.artista}");
      encontrou = true;
    }
  }
  if (!encontrou) print("Nenhuma música deste artista foi encontrada");
}

void buscarAlbum(String album, List<Musica> lista) {
  bool encontrou = false;
  for (var musica in lista) {
    if (album == musica.album.toUpperCase()) {
      if (!encontrou) print("Música(s) encontrada(s) no cadastro:");
      print("${musica.titulo} - Album: ${musica.album} - Autor: ${musica.artista}");
      encontrou = true;
    }
  }
  if (!encontrou) print("Nenhuma música deste artista foi encontrada");
}

bool continuar(){
  while (true) {
    stdout.write("Você quer continuar buscando outra música:  S (sim)  ou  N (não): ");
    String resposta = (stdin.readLineSync()!).toUpperCase();
    switch (resposta) {
      case "S":
        return true;
      case "N":
        return false;
      default:
        print("Opção inválida, digite S ou N");
    } 
  }
}