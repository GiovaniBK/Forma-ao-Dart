void main(){
  converteParaInt("123");

  converteParaInt("abc");
}

void converteParaInt(String valor){
  try {
    print("Valor convertido: ${int.parse(valor)}");
  } catch (e) {
    print("Entrada invalida. Digite apenas números inteiros.");
  }
}