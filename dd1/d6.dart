void main(){
  // Lista de números decimais para converter
  final lista = [3, 17, 23, 49, 328, 1358, 21, 429, 12, 103, 20021];
  // Ordena a lista em ordem crescente
  lista.sort();

  // Itera sobre cada número e exibe conversões para diferentes bases
  lista.forEach((valor) =>
  print("decimal: $valor, binário: ${converteBinario(valor)}, octal: ${converteOctal(valor)}, hexadecimal: ${converteHexadecimal(valor)}"));
}

// Converte um número decimal para binário
String converteBinario(int valor){
  return valor.toRadixString(2);
}

// Converte um número decimal para octal
String converteOctal(int valor){
  return valor.toRadixString(8);
}

// Converte um número decimal para hexadecimal
String converteHexadecimal(int valor){
  return valor.toRadixString(16);
}
