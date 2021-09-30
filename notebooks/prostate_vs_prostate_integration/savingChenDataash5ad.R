setwd('/lustre/scratch117/cellgen/team297/kt16/Prostate_analysis/scanpy/')
library(readr)
df <- readr::read_tsv('dataset/Chen/13sample-PRAD.RawData.txt')
df_n <- readr::read_tsv('dataset/Chen/11Sample-CRPC-Normal.txt')

library(reticulate)
ad = import("anndata")

obs <- data.frame(row.names = colnames(df[,2:ncol(df)]), barcode = colnames(df[2:ncol(df)]))
var <- data.frame(row.names = df$GeneID, GeneID = df$GeneID)
X <- as(as.matrix(df[,2:ncol(df)]), "dgCMatrix")
X <- Matrix::t(X)

adata1 <- ad$AnnData(X = X, obs = obs, var = var)
adata1$write_h5ad('dataset/Chen/chen_13.h5ad', compression = 'gzip')

obs_n <- data.frame(row.names = colnames(df_n[,2:ncol(df_n)]), barcode = colnames(df_n[2:ncol(df_n)]))
var_n <- data.frame(row.names = df_n$GeneID, GeneID = df_n$GeneID)
X_n <- as(as.matrix(df_n[,2:ncol(df_n)]), "dgCMatrix")
X_n <- Matrix::t(X_n)

adata2 <- ad$AnnData(X = X_n, obs = obs_n, var = var_n)
adata2$write_h5ad('dataset/Chen/chen_11.h5ad', compression = 'gzip')