################################################
##### R para usuários de python ################
################################################

###########################################
### Apresentação do R #####################
###########################################

# apresentar RStudio, R
# console, script, calculadora
# variáveis
a = 4
b = 6
a + b
c = a + b
c
# vetores, matrizes e dataframes
peso = c(55, 60, 78, 44, 56)
peso
peso + 6
peso * 1000
nome = c('ana', 'joao', 'carla', 'rita', 'jose')
nome
dados = data.frame(nome,peso)
dados
dados$nome
dados$peso
mean(dados$peso)
# attach(dados)
mean(peso)


####################################################
######  Python e R: semelhanças e diferenças   #####
####################################################

# algumas semelhanças e diferenças

# criar funções
soma = function(a, b){
  return(a + b)
}

# estruturas

# for
for(i in 1:5){
  print(i)
}

# while
i = 1
while(i < 5){
  print(i)
  i = i + 1
}

# if
x = 4
if (x >= 0){
  print('não negativo')
} else {
  print('negativo')
}

########################################################################
##################### LEITURA DE ARQUIVOS ##############################
########################################################################

# definir a pasta de trabalho - ou CTRL+SHIFT+H
# setwd(' ')

# carregar pacotes
library(dplyr)
library(ggplot2)
# se for necessário instalar pacotes
# install.packages('dplyr')

# ler conjuntos de dados
# os códigos abaixo assumem que os arquivos estão na sua pasta de trabalho
# definida em setwd() CTRL SHIFT H

# ler arquivo a partir de um site
read.delim('http://www.sthda.com/upload/boxplot_format.txt')
# outra opção: carregar de forma interativa
# ler csv
read.csv(file.choose())

# Se os dados têm uma coluna de texto, o R vai assumir 
# que tal coluna é um 'factor' 
# Se esse não é o objetivo, usar stringsAsFactor = FALSE
# e tal coluna será uma string

# salvar dados em rdata
# save(atlas,file='atlas.RData')
# carregar RData
# load('atlas.RData')

# selecionar parte do dataframe
# ler arquivo
rest = read.csv('restaurante1.csv')
# usando subset
subset(rest, mes == 'agosto')  # é preciso usar dois sinais de igual
# usando dplyr
rest %>% filter(mes == 'agosto')
# usando apenas índices
rest$mes == 'agosto'
rest[rest$mes == 'agosto',]

# atlas
atlas = read.csv('atlas.csv', encoding='latin1')

str(atlas)
# para que os nomes dos municípios não sejam factors
atlas = read.csv('atlas.csv', encoding='latin1', stringsAsFactors=F)
# número de linhas e colunas do dataframe
dim(atlas)
# nomes das variáveis
names(atlas)
# uma variável
atlas$MUN
# uma coluna
atlas[, 5]
# uma linha
atlas[4, ]
# primeiras linhas
head(atlas)
# primeiras linhas, algumas colunas
head(atlas[, 10:15])
# últimas linhas
tail(atlas)
# últimas linhas, algumas colunas
tail(atlas[, c('RAZDEP', 'E_ANOSESTUDO')])

# selecionar apenas os municípios mineiros
atlas$UF
table(atlas$UF)
table(atlas$UF == 31)

# usando subset
subset(atlas, UF == 31)  # é preciso usar dois sinais de igual
# usando dplyr
atlas %>% filter(UF == 31)
# usando apenas índices
atlas$UF == 31
atlas[atlas$UF == 31,]

# salvando no objeto mg
mg = subset(atlas, UF == 31)
dim(mg)

# salvar conjunto de dados na pasta de trabalho
# ou redefinir com setwd() ou CTRL SHIFT H
save(mg, file='mg.RData')

# diagrama de dispersão: esperança de vida e renda per capita
plot(atlas$FECTOT ~ atlas$RDPC)
plot(ESPVIDA ~ RDPC, data=atlas)
plot(ESPVIDA ~ RDPC, data=mg)

# diagrama de dispersão: esperança de vida e mortalidade infantil
plot(ESPVIDA ~ MORT1, data=atlas)
plot(ESPVIDA ~ MORT1, data=mg)

# resumo estatístico
summary(atlas$FECTOT)
summary(mg$FECTOT)
summary(mg)

# histograma
hist(atlas$FECTOT)
# esperança de vida no Brasil?

# esperança de vida em MG?


# regressão simples
modelo1 = lm(ESPVIDA ~ FECTOT, data=atlas)
summary(modelo1)

modelo2 = lm(ESPVIDA ~ MORT1, data=atlas)
summary(modelo2)

plot(ESPVIDA ~ MORT1, data=atlas)
abline(modelo2, col='red')

plot(ESPVIDA ~ FECTOT, data=atlas)
# cuidado: usar abline com o modelo apropriado
abline(modelo1, col='blue')

# exercício: fazer o mesmo para MG


# obter diagramas de dispersão para várias variáveis de uma vez
names(atlas)
# correlação entre duas variáveis
plot(ESPVIDA ~ MORT1, data=atlas)
cor(atlas$ESPVIDA, atlas$MORT1)
# entre todas
cor(atlas)
cor(atlas[, 7:79])
# entre algumas
cor(atlas[, c(7:10, 15:20)])

plot(atlas[, 7:10])
cor(atlas[, 7:10])

# para MG
names(mg)
plot(mg[, 7:10])

# obter coeficientes de correlação para todas as variáveis numéricas
cor(mg)
str(mg)
cor(mg[, 7:79])
cor(mg[, -c(1:6)])
round(cor(mg[,-c(1:6)]), 2)

R = cor(mg[,-c(1:6)])
R > .6 | R < (-.6)

R.t = as.data.frame(as.table(R))
R.t
subset(R.t, abs(Freq) > 0.6 & abs(Freq) != 1)
subset(R.t, abs(Freq) > 0.8 & abs(Freq) != 1)

########################################################
###########   GRÁFICOS    ##############################
########################################################

#############   R básico

# tipos de linhas e símbolos no R básico
x = 1:20
y = x ** 3
plot(x, y)
plot(x, y, type='l')
plot(x, y, type='b')
plot(x, y, type='o')
plot(x, y, type='s')
plot(x, y, type='c')
plot(x, y, type='h')

# ler arquivo csv definindo a codificação e stringAsFactors falso
pref = read.csv('pref.csv', h=T, encoding='UTF-8', stringsAsFactors=F)

# se for necessário salvar como RData
save(pref, file='pref.RData')
# carregar RData
load('pref.RData')

# gráfico de colunas
cont = table(pref$reeleito)
barplot(cont, main='Prefeito reeleito', xlab='')

# mudar a ordem
cont = sort(table(pref$reeleito))
barplot(cont, main='Prefeito reeleito', xlab='')

# dicas de gráficos de barras: 
# https://www.statmethods.net/graphs/bar.html

# gráfico de barras
barplot(cont, main='Prefeito reeleito', horiz=T)
# mudando a rotação do texto
barplot(cont, main='Reeleito', horiz=T, las=2)

# gráfico de barras empilhadas
cont = table(pref$reeleito, pref$sexo)
barplot(cont, main='Distribuição de prefeitos por sexo e reeleito',
        xlab='sexo', col=c('yellow', 'black'),
        legend = rownames(cont))

# mudar o local da legenda
cont = table(pref$reeleito, pref$sexo)
barplot(cont, main='Distribuição de prefeitos por sexo e reeleito',
        xlab='sexo', col=c('yellow', 'black'),
        args.legend = list(x='topleft'),legend = rownames(cont))

# gráfico de colunas agrupadas
cont = table(pref$reeleito, pref$sexo)
barplot(cont, main='Distribuição de prefeitos por sexo e reeleito',
        xlab='sexo', col=c('yellow', 'black'),
        legend = rownames(cont), beside=T)

# gráfico de pizza
cont = table(pref$escolaridade)
n = dim(cont)
pie(cont, main='Escolaridade dos prefeitos', col=topo.colors(n))
# paletas de cores em https://www.r-bloggers.com/color-palettes-in-r/

# boxplot
boxplot(pref$idade, data=pref, main='Idade')
# problema?

# introduzir NA
pref$idade = as.numeric(as.character(pref$idade))

boxplot(pref$idade, data=pref, main='Idade')

# boxplot de duas variáveis
boxplot(pref$idade ~ pref$sexo)

# histograma
hist(pref$idade)

# histograma colorido com número de classes definida
hist(pref$idade, breaks=5, col='red')

# tabela de frequência de dupla entrada
tab = table(pref$sexo, pref$escolaridade) 
tab

# inverter linhas e colunas
tab = table(pref$escolaridade, pref$sexo) 
tab

# porcentagens
prop.table(tab)*100      # em relação ao total geral
prop.table(tab, 1)*100   # em relação ao total das linhas
prop.table(tab, 2)*100   # em relação ao total das colunas

#########################   ggplot

library(ggplot2)
library(ggthemes)

h = ggplot(pref, aes(escolaridade, sexo))
h + geom_jitter() + theme_few()

# carrega arquivo
# read.csv('atlas.csv', encoding='latin1', stringsAsFactors=F)
# read.csv('pref.csv', h=T, encoding='UTF-8', stringsAsFactors=F)
dados = read.csv('atlas.csv', encoding='latin1', stringsAsFactors=F)
dados
dim(dados)
names(dados)
str(dados)
summary(dados)

# filtra apenas SP
sp = dados[dados$UF == 35, ]
sp
dim(sp)

# ou usando dplyr
rj = dados %>% filter(UF == 33)
rj
rj$MUN
dim(rj)

# filtra apenas sudeste
se = dados[dados$UF == 31 | dados$UF == 32 | dados$UF == 33 | dados$UF == 35, ]
se
dim(se)

# geom_point indica que são pontos
ggplot(data=se, aes(x=ESPVIDA, y=RDPC)) + geom_point()

ggplot(data=se, aes(x=ESPVIDA, y=RDPC, color=as.factor(UF))) + 
  geom_point(alpha=0.5)

# usando também tamanho
medidas = read.csv('medidas.csv')
medidas = medidas[ , 2:5]
medidas
ggplot(data=medidas, aes(x=cintura, y=quadril, color=sexo, 
                       size=torax)) + geom_point()

# muda o tamanho, a cor e a forma dos pontos
ggplot(data=se, aes(x=ESPVIDA, y=RDPC)) + 
  geom_point(color='darkblue', shape=21, size = 5)

# densidade
ggplot(data=se, aes(x=RDPC)) + geom_density(fill = 'darkred')

# boxplot
ggplot(data=se, aes(x=ESPVIDA, y=RDPC)) + geom_boxplot(aes(fill=as.factor(UF))) +
  scale_fill_discrete(name = 'estado', labels = c('MG', 'ES', 'RJ', 'SP'))

# aes(color) compartilhado
ggplot(se, aes(x=ESPVIDA, y=RDPC, color=as.factor(UF))) + geom_point() + 
  geom_smooth(method='lm')

# personalizando
media = mean(log(se$RDPC))
dp = sd(log(se$RDPC))
ggplot(data=se, aes(x=log(RDPC))) + 
  geom_histogram(aes(y = ..density..), binwidth=0.3, fill='lightblue', col='black') +
  stat_function(fun=dnorm, args=list(mean=media, sd=dp), color='red') +
  geom_rug() + # adiciona rug no eixo x
  xlab('log da renda per capita') + # adiciona descrição do eixo x
  ylab('densidade') + # adiciona descrição do eixo y
  ggtitle('Histograma - renda per capita') + # adiciona título
  theme_bw() # adiciona tema 'Black and White'

# tirar títulos, rótulos e marcações dos eixos
grafico = ggplot(data=atlas, aes(x=ESPVIDA, y=RDPC, color=as.factor(UF))) + 
  geom_point(alpha=0.5)
grafico
grafico + theme(axis.ticks=element_blank(), 
                axis.text.x = element_blank(), axis.text.y=element_blank(), 
                axis.title.x = element_blank(), axis.title.y=element_blank()) 

# ggthemes
# install.packages('ggthemes')
library(ggthemes)
data(mpg)
grafico = ggplot(mpg, aes(displ, hwy, col=factor(cyl))) + geom_point() + 
  geom_smooth(method = 'lm', se = F) + 
  ggtitle('Cilindradas, cilindros e Milhas por Galão') + 
  ylab('milhas por galão') + xlab('cilindradas')
grafico

# tema 'The Economist' com respectiva escala de cores
grafico + theme_economist() + scale_color_economist()

# Tema 'The Wall Street Journal' com respectiva escala de cores
grafico + theme_wsj() + scale_color_wsj()

# Tema 'Excel' com respectiva escala de cores
grafico + theme_excel() + scale_color_excel()

# Tema 'fivethirtyeight'
grafico + theme_fivethirtyeight() 

# Tema 'highcharts' com respectiva escala de cores
grafico + theme_hc()  + scale_color_hc()

# Tema 'Tufte' 
grafico + theme_tufte() 

# Tema 'Stata' com respectiva escala de cores
grafico + theme_stata() + scale_color_stata()