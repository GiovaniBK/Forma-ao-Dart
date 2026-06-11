void main(){
  final anos = [2016, 1988, 2000, 2100, 2300, 1993];
  
  for (final ano in anos) {
    print(ehAnoBissexto(ano) ? '$ano é um ano bissexto.' : '$ano não é um ano bissexto.');
  }
}

bool ehAnoBissexto(int ano) {
  if (ano % 4 == 0) {
    if (ano % 100 == 0) {
      return ano % 400 == 0;
    }
    return true;
  }
  return false;
}