void main(){
  final valorProduto = 10.0;
  final valorComDesconto = 7.0;

  final valorDesconto = percentualDesconto(valorProduto, valorComDesconto);
  print("O produto custava $valorProduto e foi vendido por $valorComDesconto, o desconto foi de $valorDesconto%");
}

double percentualDesconto(double valor, double desconto){
  return 100-((desconto * 100)/valor);
}