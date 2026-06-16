import 'dart:math';

void main() {
  final random = Random();

  // Gerar 15 números aleatórios
  final lista = List.generate(15, (_) => random.nextInt(5000));

  // Imprimir números em diferentes bases
  imprimeNumeros(lista);
}

// Função para imprimir lista de números em diferentes bases numéricas
void imprimeNumeros(List<int> lista){
  // Ordenar lista
  lista.sort();
  for (var numero in lista) {
    print(
      'decimal: $numero, '
      'binário: ${binaria(numero)}, '
      'octal: ${octal(numero)}, '
      'hexadecimal: ${hexadecimal(numero)}',
    );
  }
}

// Converter número decimal para binário 
String binaria(int numero){
  return numero.toRadixString(2);
}

// Converter número decimal para octal 
String octal(int numero){
  return numero.toRadixString(8);
}

// Converter número decimal para hexadecimal
String hexadecimal(int numero){
  return numero.toRadixString(16);
}

