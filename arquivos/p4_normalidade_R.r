rm(list=ls())
library(MVN)     # para verificar normalidade multivariada (Mardia)

#-------------------------------------------------------------------------------
# exemplo das notas
# gráfico qui quadrado
Nota1 = c(17.2,16.8,25.0,19.0,21.0,15.6,19.0,22.5,18.2,16.7,22.6,22.0,15.8,15.5,21.3,21.2,23.0,22.7,19.6)
Nota2 = c(16.7,15.0,24.6,17.5,24.8,13.4,23.4,24.3,20.3,17.5,20.2,20.6,16.3,17.8,24.8,21.5,24.1,18.9,23.3)
Nota3 = c(15.8,17.2,24.2,18.0,20.8,16.2,22.8,23.5,19.6,15.7,23.6,21.9,17.7,17.7,22.9,18.9,23.5,20.6,20.7)
i = seq(1,19)
X = data.frame(i,Nota1,Nota2,Nota3)
X

X = X[,2:4]   # apenas as notas
# vetores e matrizes amostrais
Xb = sapply(X,mean)
S = cov(X)
cor(X)

# QQ plot multivariado  gráfico qui-quadrado
# e teste de Mardia (multivariado)
resultado = mvn(X, mvnTest='mardia', multivariatePlot='qq')
resultado

# ler o arquivo
mg = read.csv('imrs.csv',h=T)
colnames(mg)

# obter as distâncias entre as observações (municípios da microrregião
# de Varginha)
vgn = subset(mg, micro == 31050)
vgn

# pegando as 10 primeiras variáveis numéricas
vgn1 = vgn[, c(7:10, 12:16, 18)]

colnames(vgn1)

# testes de normalidade
mvn(vgn1, univariateTest='SW', mvnTest='mardia', univariatePlot='qq', multivariatePlot='qq')
#  "persp" for perspective plot, "contour" for contour plot
# Type "mardia" for Mardia’s test, "hz" for Henze-Zirkler’s test, "royston" for Royston’s test, "dh" 
# for Doornik-Hansen’s test and energy for E-statistic

colnames(vgn)
# só 3 variáveis
X = vgn[, c(32, 33, 39)]

# testes de normalidade
mvn(X, univariateTest='SW', mvnTest='mardia', univariatePlot='qq', multivariatePlot='qq')