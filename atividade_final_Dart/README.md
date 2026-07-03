# Sistema para Relatórios Climáticos — Lince Tech Academy

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

## Arquivos

Os arquivos CSV devem estar em: `C:\CLIMA\sensores`

**Nome:** `[ESTADO]_[ANO]_[MÊS].csv`

**Exemplo**: `SC_2024_01.csv`

**Colunas:**
```
Mês,Dia,Hora,Temperatura {C},Umidade {kg/kg},Densidade do ar {kg/m3},Velocidade do Vento {m/s},Direção do Vento {graus}
1,1,1,23.8,0.018474922,1.146,5,220
```
- A exportação dos relatórios em arquivo `.txt` é opcional, e eles serão salvos automaticamente na subpasta `relatorios\` do projeto, nomeados no formato `[TIPO]_[DATA]_[HORA].txt` (**Ex**: CLIMA_2026-06-24_16-05.txt)
---

Desenvolvido como atividade final do curso de Dart da Lince Tech Academy.
