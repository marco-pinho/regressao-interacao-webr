# Regressão linear com interação no navegador

Exemplo de regressão linear com interação (variável categórica × numérica) que roda
inteiramente no navegador, sem instalar o R, usando [webR](https://docs.r-wasm.org/webr/latest/)
e o pacote [webrarian](https://github.com/coatless-wasm/webrarian).

**Site:** https://marco-pinho.github.io/regressao-interacao-webr/

## O que o exemplo mostra

Dados sintéticos (400 pacientes): o efeito da idade sobre a recuperação depende de a pessoa ter feito fisioterapia.

| | Inclinação da idade (pontos/ano) |
|---|---|
| Sem fisioterapia | −0,43 |
| Com fisioterapia | +0,08 (IC95% 0,02 a 0,14) |

A interação (`fisioterapia * idade`) é 0,51 (p < 2e-16) e melhora o ajuste em relação ao modelo aditivo (F = 143,6).

## Arquivos

- `data/dados.csv`: `fisioterapia` (Nao/Sim), `idade`, `recuperacao`
- `scripts/01_explorar.R`: exploração e gráfico de dispersão
- `scripts/02_modelo_interacao.R`: `lm(recuperacao ~ fisioterapia * idade)` e comparação com o modelo aditivo
- `scripts/03_efeitos_e_grafico.R`: inclinações por grupo, predições e gráfico com bandas de confiança

## Rodar localmente

```r
pak::pak(c("coatless-wasm/webrarian", "httpuv"))
webrarian::bind(".")
webrarian::reading_room(".")
```

## Observações

- No GitHub Pages o Ctrl+C não interrompe o R; use o botão **Restart R**.
- O engine do webR é carregado do CDN, então é preciso estar online na primeira visita.
