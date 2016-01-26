
# Le but de l'exercice est d'examiner l'utilisation de l'énergie chez les 
# ménage sur une période de 2 jours (celle de fevrier 2007) sachant que les 
# données sont collectés par minutes. Ce qui fait que la base entière contient
# pas moins de 2 075 259 lignes. L'exercice demande d'utiliser que les données datant des 
# 01 et 02 février 2007. Pour se faire nous réaliserons une série de graphiques pour les différentes
# observations. 

# 1. Définir=tion du repertoire de travail ####
setwd("C:/Users/Guy Martial BAI/Desktop/Exploratory data analysis")

# 2. Importation de la base ####
# Le nom du fichier est assez long donc lastuce est de l'affecter à une variable
dataname <- "./exdata_data_household_power_consumption/household_power_consumption.txt"

# Je décide d'ouvrir ma base en 2 étapes : 
# Etape 1 : Bien que mon PC pourrait supporter d'afficher la base de données, 
# j'estime que celle-ci est bien trop large et vu que je n'ai pas besoin des 
# 2 millions de lignes mais seulement de quelques une d'entres-elles, je 
# procederais comme suit : 
# J'ouvre seulement 10 observations de la base de données 
pseudo.data <- read.table(dataname, header=T, sep=";", na.strings = "?", nrows=10)

# Je cherche à obtenir la structure de mes données, i.e. la classe de chacune
# des 9 variables
dataClass <- sapply(pseudo.data, class)

# Etape 2 : J'ouvre ma base de 2 jours pour les dates du 01 et du 02 de fevrier 2007
# Je calcule le nombre de ligens qu'il me faut. Les données sont par min : 
# en une heure j'obtiens : 1min * 60 = 60
# en une journée : 60*24 = 1440 ; et en 2 jours : 2880
# Je dois donc lire 2880 lignes pour les 2 premiers du mois de fevrier
# Sachant que les données début le 16 decembre 2006, je refais les calculs :
# Ainsi du 16 decembre 2006 à 17h 24mn au 01 fevrier 2007 à 00h00mn,
# j'obtiens 1 mois 15 jours 6 heures et 37 minutes comme écart. Nous 
# avons fait 01/02/2007 00h00min - 16/12/2006 17h23min
# Si l'on convertis le tout en minutes, nous obtenons : 66637 minutes à ne 
# pas lire dans la base et 2880 données à lire.

feb.data <- read.table(dataname, colClasses = dataClass, nrows=2880, skip = 66637, sep=";", na.strings = "?", header=F, col.names = names(pseudo.data))

# 3. Je concatène les colones Date et Heure en une seule avec le format
# qui convient ####
feb.data$Date_Heure <- strptime(paste(feb.data$Date, feb.data$Time, " "), "%d/%m/%Y %H:%M:%S")

# 4. Créer un graphique : plot2 : Global active power selon le jour ####
png("plot2.png", width = 480, height = 480, units = "px")
with(feb.data, plot(feb.data$Date_Heure, type="l", feb.data[ ,3], ylab="Global Active Power (kilowatts)", xlab = ""))
dev.off()
