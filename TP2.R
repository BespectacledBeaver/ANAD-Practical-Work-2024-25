# Charger les bibliothèques nécessaires
library(FactoMineR)
library(factoextra)
library(mlbench)

#Les prétraitement nécessaires
data <- read.csv("data.csv", header = TRUE, sep = ",")
data[data == "NULL"] <- NA
data <- na.omit(data)
data[, -c(1, 10, 11)] <- lapply(data[, -c(1, 10, 11)], function(x) as.numeric(as.character(x)))

'weights <- c(5/30, 4/30, 4/30, 3/30, 3/30, 2/30, 3/30, 5/30)

summary(data)

#ACP
PCA_ALL <- PCA(data[-c(1, 10, 11)], col.w = weights, scale.unit = TRUE)
PCA_ALL$eig
PCA_ALL$var
fviz_eig(PCA_ALL, addlabels = TRUE, ylim = c(0, 60))
'

summary(data)

#ACP
PCA_ALL <- PCA(data[-c(1, 10, 11)],graph = FALSE)
PCA_ALL$eig
PCA_ALL$var
fviz_eig(PCA_ALL, addlabels = TRUE, ylim = c(0, 60))

fviz_pca_ind(PCA_ALL, 
             geom.ind = "point",
             col.ind = data$Affect,   
             palette = "Set1",        
             addEllipses = TRUE,      
             legend.title = "Classe", 
             repel = FALSE            
)
fviz_pca_var(PCA_ALL, 
             col.var = "contrib",  
             repel = TRUE          
)

#Traitement des données aberrantes
num_cols <- sapply(data, is.numeric)
for (col in names(data)[num_cols]) {
  z_scores <- scale(data[[col]])
  outliers <- which(abs(z_scores) > 3)
  if (length(outliers) > 0) {
    data_No_Outliers <- data[-outliers, ]
  }
}

data_Outliers <- data[outliers,]

#ACP sans les données aberrantes
data_No_Outliers$Affect <- as.factor(data_No_Outliers$Affect)

PCA_No_Outliers <- PCA(data_No_Outliers[-c(1, 10, 11)]
                       ,graph = FALSE)

fviz_pca_ind(PCA_No_Outliers, 
             geom.ind = "point",
             col.ind = data_No_Outliers$Affect,   
             palette = "Set1",        
             addEllipses = TRUE,      
             legend.title = "Classe", 
             repel = FALSE            
)
fviz_pca_var(PCA_No_Outliers, 
             col.var = "contrib",  
             repel = TRUE          
)
PCA_No_Outliers$eig
PCA_No_Outliers$var

fviz_eig(PCA_No_Outliers, addlabels = TRUE, ylim = c(0, 60))

colors <- rep("Le reste", nrow(data))
colors[data$Matricule == "21/0186"] <- "DJEGHRI LOTFI"
colors[data$Matricule == "21/0267"] <- "ARROUCHE Abdellah"

# Visualize the PCA individuals
fviz_pca_ind(PCA_ALL, 
             geom.ind = "point",          
             col.ind = colors,            
             legend.title = "Classe",     
             repel = FALSE                
)