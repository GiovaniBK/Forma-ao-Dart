# Sistema de Relatórios Climáticos — Lince Tech Academy

Aplicação de linha de comando em **Dart** que lê arquivos CSV de sensores meteorológicos e gera relatórios estatísticos comparando os estados de **São Paulo (SP)** e **Santa Catarina (SC)**.

---

## Funcionalidades

- Menu interativo para seleção do tipo de relatório
- **Temperatura:** média, máxima e mínima por ano, mês e horário em °C, °F e K
- **Umidade:** média, máxima e mínima por ano e mês
- **Direção do vento:** direção mais frequente por ano e mês em graus e radianos
- Saída colorida no terminal via `yaansi`
- Exportação opcional do relatório em arquivo `.txt`
- Tratamento de erros na leitura dos arquivos

---

## Formato dos Arquivos CSV

Os arquivos devem estar em: `C:\CLIMA\sensores`

**Nome:** `[ESTADO]_[ANO]_[MÊS].csv`

**Exemplo**: `SC_2024_01.csv`

**Colunas:**
```
Mês,Dia,Hora,Temperatura {C},Umidade {kg/kg},Densidade do ar {kg/m3},Velocidade do Vento {m/s},Direção do Vento {graus}
1,1,1,23.8,0.018474922,1.146,5,220
```

---

Desenvolvido como atividade final do curso de Dart — Lince Tech Academy.
