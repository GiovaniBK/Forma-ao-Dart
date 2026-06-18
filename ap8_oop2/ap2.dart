void main(){
  // Cria uma instância de Cavalo
  final cavalo = Cavalo();
  // Chama métodos herdados da classe abstrata Animal
  cavalo.comer();
  cavalo.beber();
  // Chama método específico da classe Cavalo
  cavalo.correr();
}

// Classe abstrata que define comportamentos comuns a todos os animais
abstract class Animal{
  // Método para simular alimentação
  void comer(){
    print("O animal está comendo");
  }
  
  // Método para simular hidratação
  void beber(){
    print("O animal está bebendo");
  }
}

// Classe Cavalo que herda de Animal
class Cavalo extends Animal{
  // Método específico do cavalo
  void correr(){
    print("O cavalo esta correndo");
  }
}