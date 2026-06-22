import 'dart:collection';
import 'dart:math';

void main(){
  Album album = Album();
  PacoteDeFigurinhas pacote = PacoteDeFigurinhas();

  while (!album.albumCompleto) {
    List<String> figurinhasPacote = pacote.gerarPacote();
    for (String f in figurinhasPacote) {
      album.adicionarFigurinha(f);
    }
    print('');
  }

  print('Figurinhas repetidas: ${album.figurinhasRepetidas.length}');
  album.mostrarAlbum();

}

class PacoteDeFigurinhas {
  Album figurinhas = Album();
  List<String> get pacote => gerarPacote();

  List<String> gerarPacote() {
    final random = Random();
    List<String> pacote = [];
    for (int i = 0; i < 4; i++) {
      int indiceAleatorio = random.nextInt(20);
      String jogador = figurinhas.jogadores.keys.toList()[indiceAleatorio];
      pacote.add(jogador);
    }
    return pacote;
  }
}

class Album {
  Queue<String> figurinhas = Queue<String>();
  List figurinhasRepetidas = [];
  bool _albumCompletoNotificado = false;
  
  void adicionarFigurinha(String figurinha) {
    if (figurinhas.contains(figurinha)) {
      print('Figurinha repetida: $figurinha');
      figurinhasRepetidas.add(figurinha);
    } else {
      figurinhas.add(figurinha);
      print('Figurinha adicionada ao álbum: $figurinha');
      if (albumCompleto) {
        _notificarAlbumCompleto();
      }
    }
  }

  bool get albumCompleto => figurinhas.length == jogadores.length;

  void _notificarAlbumCompleto() {
    if (_albumCompletoNotificado) {
      return;
    }

    _albumCompletoNotificado = true;
    print('Album completo! Todas as figurinhas foram adicionadas.');
  }

  Random random = Random();
  Map<String, int> jogadores = {"Messi": 2210, "Ronaldo": 7007, "Neymar": 5342, "Mbappé": 2342, "Salah": 7865,
    "Lewandowski": 1345, "Kane": 3452, "De Bruyne": 9871, "Modric": 8651, "Van Dijk": 7543,
    "Alisson": 5123, "Vozinha": 6234, "Courtois": 5487, "Oblak": 3768, "Neuer": 2256,
    "Dembélé": 1003, "Vini Jr.": 8236, "Foden": 4137, "Endrick": 9123, "Pulisic": 2112};

  void mostrarAlbum() {
    print('Figurinhas no álbum:');
    final ordena = jogadores.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));
    Map<String, int> jogadoresOrdenados = Map.fromEntries(ordena);


    for (var jogador in jogadoresOrdenados.keys) {
      if (figurinhas.contains(jogador)) {
        print('$jogador: ${jogadores[jogador]}');
      }
    }
  } 
}