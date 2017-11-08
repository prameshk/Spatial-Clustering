# Spatial-Clustering
There are two scripts in this repository which uses two different types of clustering.<br />
I. Greedy_Clustering <br />
This R script is used for spatial clustering using Greedy Algorithm. Follwing are the steps.
1. Install and setup postgreSQL server for U-Pass Data
2. Set your working directory to the location where script is located using following command <br />
setwd('mylocation')<br />
3. Install various packages<br />
install.packages('shiny')<br />
install.packages('data.table')<br />
install.packages('leaflet')<br />
install.packages('RPostgreSQL')<br />
4. Make an R file in working directory named "keys.R" with folowing information about the PostgreSQL server <br />

db <- ""<br />
id <- ""<br />
pw <- ""<br />
port <- <br />
host = ""<br />
5. Run the script <br />

II. DBSCAN_Clustering <br />
1. This script requires processed data. This data contains csv files for different semesters. Please run the following command to create a dataframe named "cl_data" <br />
options(stringsAsFactors = FALSE)<br />
fileList <- list.files(path="directory where data is located", pattern=".csv")<br />
cl_data <- do.call(rbind,lapply(fileList,read.csv))<br />
2. Install following packages <br />
install.packages('shiny')<br />
install.packages('dplyr')<br />
install.packages('leaflet')<br />
install.packages('dbscan')<br />
install.packages('fpc')<br />
Run the script "shiny_app.R"
3. Select value of n,epsilon for the clustering, semester and time range for the clustering.
4. This script runs DBSCAN in background. Please do not select the high range of time for this tyoe of clustering



Feel free to email kumar372@umn.edu in case of questions.
