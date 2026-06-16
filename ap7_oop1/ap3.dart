void main(){
  List<Produto> produtos = [
    Produto("Camiseta", 50.0),
    Produto("Calça", 100.0),
    Produto("Tênis", 200.0),
    Produto("Meia", 15.0),
    Produto("Boné", 35.0),
  ];
  produtos.forEach((produto) {
    double desconto = produto.desconto(25);
    print("Novo preço do produto ${produto.nome} (com desconto): ${desconto}");
  });
}
class Produto{
  String nome;
  double preco;

  Produto(this.nome, this.preco);

  double desconto(double porcentagem){
    return preco - (preco * (porcentagem / 100));
  }
}