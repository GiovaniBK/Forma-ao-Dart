void main(){
  // Lista com alguns valores válidos e inválidos
  final List<String> listaValores = ['10', '2XXL7', 'JOJ0', '99', '381',
   'AD44', '47', '2B', '123', '78' ];

  // Converter lista com tratamento de valores inválidos
  final List<int> listaNumeros = converteLista(listaValores);
  print("Lista de convertida: $listaNumeros");
}

// Converter lista de strings para inteiros
// Valores inválidos são substituídos por 0
List<int> converteLista(List<String> lista){
  List<int> listaConvertida = [];
  for(String valor in lista){
    // tryParse retorna null se conversão falhar
    int? numero = int.tryParse(valor);
    // Adicionar número ou 0 se conversão falhou
    numero != null ? listaConvertida.add(numero) : listaConvertida.add(0);
  }
  return listaConvertida;
}