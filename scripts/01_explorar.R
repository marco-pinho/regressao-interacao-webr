# 01 - Exploração dos dados (dataset sintético)
dados <- read.csv("data/dados.csv", stringsAsFactors = TRUE)
dados$fisioterapia <- relevel(dados$fisioterapia, ref = "Nao")

str(dados)
summary(dados)

# Média e DP da recuperação por grupo
aggregate(recuperacao ~ fisioterapia, dados, function(x) c(media = mean(x), dp = sd(x)))

# Dispersão: recuperação x idade, por grupo
cores <- c(Nao = "firebrick", Sim = "steelblue")

plot(dados$idade, dados$recuperacao,
     col = cores[as.character(dados$fisioterapia)], pch = 19,
     xlab = "Idade (anos)", ylab = "Recuperação (pontos)",
     main = "Recuperação segundo idade e fisioterapia")
legend("topright", legend = names(cores), col = cores, pch = 19, title = "Fisioterapia")
