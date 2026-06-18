import 'dart:async';
Future<void> main() async {
  // Lista de URLs para download
  List<String> urls = [
    'https://example.com/imagem1.jpg',
    'https://example.com/imagem2.jpg',
    'https://example.com/imagem3.jpg',
  ];

  // Aguarda o término de todos os downloads
  await baixarImagens(urls);
}

// Função assíncrona que simula o download de uma imagem
// Retorna a URL após o download ser completado
Future<String> baixarImagem(String url) async {
  // Simula o delay do download
  await Future.delayed(Duration(seconds: 2));
  return url;
}

// Função assíncrona que baixa múltiplas imagens sequencialmente
Future<void> baixarImagens(List<String> urls) async {
  print("Baixando imagens...");

  // Itera sobre cada URL na lista
  for (String url in urls) {
    // Aguarda o download de cada imagem antes de prosseguir
    await baixarImagem(url);
    print("Imagem <$url> baixada com sucesso!");
  }

  // Exibido após todas as imagens serem baixadas
  print("Download concluído!");
}
