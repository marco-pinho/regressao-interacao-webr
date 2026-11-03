# 03 - Inclinações por grupo, diferença entre grupos e gráfico do modelo
dados <- read.csv("data/dados.csv", stringsAsFactors = TRUE)
dados$fisioterapia <- relevel(dados$fisioterapia, ref = "Nao")
m <- lm(recuperacao ~ fisioterapia * idade, data = dados)

b <- coef(m); V <- vcov(m)

# Inclinação da idade em cada grupo (efeito simples)
incl_nao <- b["idade"]
incl_sim <- b["idade"] + b["fisioterapiaSim:idade"]
ep_sim   <- sqrt(V["idade", "idade"] + V["fisioterapiaSim:idade", "fisioterapiaSim:idade"] +
                 2 * V["idade", "fisioterapiaSim:idade"])
cat("Inclinação da idade SEM fisioterapia:", round(incl_nao, 3), "\n")
cat("Inclinação da idade COM fisioterapia:", round(incl_sim, 3),
    "(IC95%:", round(incl_sim - 1.96 * ep_sim, 3), "a", round(incl_sim + 1.96 * ep_sim, 3), ")\n")

# Diferença Sim - Nao em idades específicas
novo <- expand.grid(idade = c(35, 50, 65), fisioterapia = c("Nao", "Sim"))
novo$fisioterapia <- factor(novo$fisioterapia, levels = c("Nao", "Sim"))
pred <- predict(m, novo, interval = "confidence")
print(cbind(novo, round(pred, 1)))

# Gráfico: retas ajustadas com banda de confiança
cores <- c(Nao = "firebrick", Sim = "steelblue")
plot(dados$idade, dados$recuperacao, col = adjustcolor(cores[as.character(dados$fisioterapia)], 0.4),
     pch = 19, xlab = "Idade (anos)", ylab = "Recuperação (pontos)",
     main = "Interação: o efeito da idade depende da fisioterapia")

grade <- seq(min(dados$idade), max(dados$idade), length.out = 100)

for (g in names(cores)) {
  nd <- data.frame(idade = grade, fisioterapia = factor(g, levels = c("Nao", "Sim")))
  p <- predict(m, nd, interval = "confidence")
  polygon(c(grade, rev(grade)), c(p[, "lwr"], rev(p[, "upr"])),
          col = adjustcolor(cores[g], 0.2), border = NA)
  lines(grade, p[, "fit"], col = cores[g], lwd = 3)
}
legend("topright", legend = names(cores), col = cores, lwd = 3, title = "Fisioterapia")

# Diagnóstico rápido dos resíduos
par(mfrow = c(1, 2)); plot(m, which = 1:2); par(mfrow = c(1, 1))
