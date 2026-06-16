void main(){
  // Tentar converter string válida
  converteParaInt("123");

  // Tentar converter string inválida
  converteParaInt("abc");
}

// Converter string para inteiro com tratamento de erro
void converteParaInt(String valor){
  try {
    // Tentar converter valor para int
    print("Valor convertido: ${int.parse(valor)}");
  } catch (e) {
    // Capturar exceção se conversão falhar
    print("Entrada invalida. Digite apenas números inteiros.");
  }
}