void main(){
  final valorProduto = 10.0;  // Preço original
  final valorComDesconto = 7.0;  // Preço com desconto

  // Calcular percentual de desconto
  final valorDesconto = percentualDesconto(valorProduto, valorComDesconto);
  print("O produto custava $valorProduto e foi vendido por $valorComDesconto, o desconto foi de $valorDesconto%");
}

// Calcular percentual de desconto aplicado
double percentualDesconto(double valor, double desconto){
  return 100-((desconto * 100)/valor);
}