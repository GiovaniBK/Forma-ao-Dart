void main(){
  final List<String> listaValores = ['10', '2XXL7', 'JOJ0', '99', '381',
   'AD44', '47', '2B', '123', '78' ];

  final List<int> listaNumeros = converteLista(listaValores);
  print("Lista de convertida: $listaNumeros");
}

List<int> converteLista(List<String> lista){
  List<int> listaConvertida = [];
  for(String valor in lista){
    int? numero = int.tryParse(valor);
    numero != null ? listaConvertida.add(numero) : listaConvertida.add(0);
  }
  return listaConvertida;
}