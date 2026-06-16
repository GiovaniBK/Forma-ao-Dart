void main(){
  ContaBancaria conta = ContaBancaria("Carlos", 1000.0);
  conta.depositar(250.0);
  conta.sacar(500.0);
  conta.sacar(1000.0);
}

class ContaBancaria{
  String titular;
  double saldo;

  ContaBancaria(this.titular, this.saldo);

  void depositar(double valor){
    saldo += valor;
    print("Saldo atual: $saldo");
  }
  void sacar(double valor){
    if(valor > saldo){
      print("Saldo insuficiente");
      return;
    }
    saldo -= valor;
    print("Saldo atual: $saldo");
  }

}