library(FactoMineR)
library(Hmisc)
library(missMDA)
library(factoextra)
library(pathviewr)
data <- read.csv("Dataset.csv", header = TRUE, sep = ",")

data <- data[ , !(names(data) %in% c("country_code","uuid","age","weight","question_bbi_2016wave4_basicincome_effect", "question_bbi_2016wave4_basicincome_argumentsagainst", "question_bbi_2016wave4_basicincome_argumentsfor"))]
data <- data[!is.na(data$dem_education_level), ]

data$age_group <- gsub('_',' to ',data$age_group)
data$dem_education_level <- gsub('^','edu level ',data$dem_education_level)
data$dem_full_time_job <- gsub('yes','full-time job',data$dem_full_time_job)
data$dem_full_time_job <- gsub('no','no full-time job',data$dem_full_time_job)
data$dem_has_children <- gsub('yes','has children',data$dem_has_children)
data$dem_has_children <- gsub('no','no children',data$dem_has_children)

#summary(data)
#ncol(data)
#describe(data)

#freq <- lapply(data,table)
#freq
#nrow(data)

#barplot(table(data$rural), main = "Breakdown by residential area", border=NA, col = "#0060b1", ylab = "Nombre d'individus")
#barplot(table(data$dem_full_time_job), main = "Répartition par travail en plein temps", border=NA, col = "#0060b1", ylab = "Nombre d'individus")
#barplot(table(data$dem_education_level), main = "Répartition par niveau d'éducation", border=NA, col = "#0060b1", ylab = "Nombre d'individus")
#barplot(table(data$dem_has_children), main = "Répartition par possession d'enfant", border=NA, col = "#0060b1", ylab = "Nombre d'individus")
#barplot(table(data$question_bbi_2016wave4_basicincome_vote), main = "Répartition des votes pour le revenu de base", border=NA, col = "#0060b1", ylab = "Nombre d'individus")
#barplot(table(data$age_group), main = "Répartition par groupe d'age", border=NA, col = "#0060b1", ylab = "Nombre d'individus")

disj_data <- model.matrix(~ . + 0, data = data)

afcm = MCA(data)