void main(){
  Retangulo retangulo = Retangulo(10.0, 5.0);
  double area = retangulo.calcularArea();
  print("Área do retângulo: $area");
}

class Retangulo{
  double largura;
  double altura;

  Retangulo(this.largura, this.altura);

  double calcularArea(){
    double area = largura * altura;
    return area;
  }
}