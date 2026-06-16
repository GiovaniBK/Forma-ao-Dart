void main(){
  final anos = [2016, 1988, 2000, 2100, 2300, 1993];
  
  // Para cada ano, verificar se é bissexto usando operador ternário
  for (final ano in anos) {
    print(ehAnoBissexto(ano) ? '$ano é um ano bissexto.' : '$ano não é um ano bissexto.');
  }
}

// Verificar se um ano é bissexto
bool ehAnoBissexto(int ano) {
  // Verificar se é divisível por 4
  if (ano % 4 == 0) {
    // Se divisível por 100, precisa ser divisível por 400 também
    if (ano % 100 == 0) {
      return ano % 400 == 0;
    }
    // Divisível por 4 e não por 100 = bissexto
    return true;
  }
  // Não divisível por 4 = não é bissexto
  return false;
}