void main(){
  // Criar conta bancária com titular e saldo inicial
  ContaBancaria conta = ContaBancaria("Carlos", 1000.0);
  // Realizar operações
  conta.depositar(250.0);
  conta.sacar(500.0);
  conta.sacar(1000.0);  // Tentará sacar mas não tem saldo suficiente
}

// Classe que representa uma conta bancária
class ContaBancaria{
  String titular;
  double saldo;

  // Construtor que inicializa titular e saldo
  ContaBancaria(this.titular, this.saldo);

  // Depositar valor na conta
  void depositar(double valor){
    saldo += valor;
    print("Saldo atual: $saldo");
  }

  // Sacar valor da conta (se houver saldo suficiente)
  void sacar(double valor){
    // Validar se há saldo suficiente
    if(valor > saldo){
      print("Saldo insuficiente");
      return;
    }
    saldo -= valor;
    print("Saldo atual: $saldo");
  }

}