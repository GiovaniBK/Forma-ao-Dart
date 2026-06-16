void main(){
  // Criar retângulo com dimensões
  Retangulo retangulo = Retangulo(10.0, 5.0);
  // Calcular e exibir área
  double area = retangulo.calcularArea();
  print("Área do retângulo: $area");
}

// Classe que representa um retângulo
class Retangulo{
  double largura;
  double altura;

  // Construtor que inicializa dimensões
  Retangulo(this.largura, this.altura);

  // Calcular área do retângulo
  double calcularArea(){
    double area = largura * altura;
    return area;
  }
}