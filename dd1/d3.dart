void main(){
  // Texto de exemplo para análise
  final paragrafo = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam venenatis nunc et posuere vehicula. Mauris lobortis quam id lacinia porttitor.";
  
  print("Parágrafo: $paragrafo");
  print("Número de palavras: ${numeroDePalavras(paragrafo)}");
  print("Tamanho: ${tamanhoDoTexto(paragrafo)}");
  print("Número de frases: ${numeroDeFrases(paragrafo)}");
  print("Número de vogais: ${numeroDeVogais(paragrafo)}");
  print("Número de consoantes: ${numeroDeConsoantes(paragrafo).join(", ")}");
}

// Conta o número de palavras contando espaços e adicionando 1 (por conta da ultima palavra)
int numeroDePalavras(String paragrafo){
  int contador = 0;
  for (var i = 0; i < paragrafo.length; i++) {
    if (paragrafo[i] == ' ') {
      contador++;
    }
  }
  return contador + 1;
}

// Conta o tamanho total do texto em caracteres
int tamanhoDoTexto(String paragrafo){
  int contador = 0;
  for (var i = 0; i < paragrafo.length; i++) {
    contador++;
  }
  return contador;
}

// Conta o número de frases contando pontos finais (.)
int numeroDeFrases(String paragrafo){
  int contador = 0;
  for (var i = 0; i < paragrafo.length; i++) {
    if (paragrafo[i] == '.') {
      contador++;
    }
  }
  return contador;
}

// Conta quantas vogais existem no texto
int numeroDeVogais(String paragrafo){
  final vogais = ["a","e","i","o","u"];
  int contador = 0;
  for (var i = 0; i < paragrafo.length; i++) {
    if (vogais.contains(paragrafo[i].toLowerCase())) {
      contador++;
    }
  }
  return contador;
}

// Identifica todas as consoantes únicas no texto
// Retorna lista ordenada de consoantes sem repetição
List<String> numeroDeConsoantes(String paragrafo){
  final naoConsoantes = ["a","e","i","o","u", ".", " ", ","];
  List<String> consoantes = [];
  for (var i = 0; i < paragrafo.length; i++) {
    if (naoConsoantes.contains(paragrafo[i].toLowerCase())) {}
    else{
      if(consoantes.contains(paragrafo[i].toLowerCase())) {}
      else{
      consoantes.add(paragrafo[i].toLowerCase());
      }
    }
  }
  consoantes.sort();
  return consoantes;
}
