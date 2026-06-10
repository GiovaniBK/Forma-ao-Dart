import 'dart:math';

void main() {
  final random = Random();

  final lista = List.generate(15, (_) => random.nextInt(5000));

  imprimeNumeros(lista);
}

void imprimeNumeros(List<int> lista){
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

String binaria(int numero){
  return numero.toRadixString(2);
}

String octal(int numero){
  return numero.toRadixString(8);
}

String hexadecimal(int numero){
  return numero.toRadixString(16);
}

