# Spatial-Clustering
There are two scripts in this repository which uses two different types of clustering.
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
1
