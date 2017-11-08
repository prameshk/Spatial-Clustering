# Spatial-Clustering
There are two scripts in this repository which uses two different types of clustering.
1. Greedy_Clustering 
This R script is used for spatial clustering using Greedy Algorithm. Follwing are the steps.
1. Install and setup postgreSQL server for U-Pass Data
2. Set your working directory to the location where script is located using following command 
setwd('mylocation')
3. Install various packages
install.packages('shiny')
install.packages('data.table')
install.packages('leaflet')
install.packages('RPostgreSQL')
4. Make an R file named "keys.R" with folowing information about the PostgreSQL server
keys.R
db <- ""
id <- ""
pw <- ""
port <- 
host = ""
