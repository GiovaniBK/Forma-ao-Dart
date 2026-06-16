void main(){
  // Criar lista de produtos
  List<Produto> produtos = [
    Produto("Camiseta", 50.0),
    Produto("Calça", 100.0),
    Produto("Tênis", 200.0),
    Produto("Meia", 15.0),
    Produto("Boné", 35.0),
  ];
  // Iterar sobre cada produto e calcular desconto
  produtos.forEach((produto) {
    // Calcular preço com desconto de 25%
    double desconto = produto.desconto(25);
    print("Novo preço do produto ${produto.nome} (com desconto): ${desconto}");
  });
}

// Classe que representa um produto
class Produto{
  String nome;
  double preco;

  // Construtor que inicializa nome e preço
  Produto(this.nome, this.preco);

  // Calcular preço com desconto em porcentagem
  double desconto(double porcentagem){
    return preco - (preco * (porcentagem / 100));
  }
}