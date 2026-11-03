# 02 - Regressão linear com interação (categórica x numérica)
dados <- read.csv("data/dados.csv", stringsAsFactors = TRUE)
dados$fisioterapia <- relevel(dados$fisioterapia, ref = "Nao")

# Modelo aditivo (sem interação) e com interação
m_aditivo   <- lm(recuperacao ~ fisioterapia + idade, data = dados)
m_interacao <- lm(recuperacao ~ fisioterapia * idade, data = dados)

summary(m_interacao)
confint(m_interacao)

# A interação melhora o ajuste? (teste F entre modelos aninhados)
anova(m_aditivo, m_interacao)

# Interpretação dos coeficientes:
# (Intercept)            recuperação esperada aos 0 anos sem fisioterapia
# fisioterapiaSim        diferença Sim - Nao aos 0 anos (extrapolação)
# idade                  inclinação da idade no grupo SEM fisioterapia
# fisioterapiaSim:idade  quanto a inclinação da idade muda no grupo COM fisioterapia
