void main(){
  // Lista de temperaturas em graus Celsius
  final lista = [0.0, 4.2, 15.0, 18.1, 21.7, 32.0, 40.0, 41.0];

  // Itera sobre cada temperatura e exibe as conversões com 2 casas decimais
  lista.forEach((valor) =>
  print("Celcius: $valor, fahrenheit: ${calculaFahrenheit(valor).toStringAsFixed(2)}, kelvin: ${calculaKelvin(valor).toStringAsFixed(2)}"));
}

// Converte graus Celsius para Fahrenheit
double calculaFahrenheit(valor){
  return (valor * 1.8) + 32;
}

// Converte graus Celsius para Kelvin
double calculaKelvin(valor){
  return valor + 273.15;
}
