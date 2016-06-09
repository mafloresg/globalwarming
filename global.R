Sys.setlocale("LC_ALL","en_GB.UTF-8")

if (!file.exists("1880-2016-Africa_land_temp_anomalies.csv")){
    fileUrl <- "https://www.ncdc.noaa.gov/cag/time-series/global/africa/land/ytd/12/1880-2016.csv";
    download.file(fileUrl, destfile="1880-2016-Africa_land_temp_anomalies.csv", method="curl");
}

africaTempAnomalies <- read.csv("1880-2016-Africa_land_temp_anomalies.csv", 
                                header = TRUE, skip = 3);
africaTempAnomalies$direction <- ifelse(africaTempAnomalies$Value > 0, 1, 0)

if (!file.exists("1880-2016-Asia_land_temp_anomalies.csv")){
    fileUrl <- "https://www.ncdc.noaa.gov/cag/time-series/global/asia/land/ytd/12/1880-2016.csv";
    download.file(fileUrl, destfile="1880-2016-Asia_land_temp_anomalies.csv", method="curl");
}

asiaTempAnomalies <- read.csv("1880-2016-Asia_land_temp_anomalies.csv", 
                              header = TRUE, skip = 3);
asiaTempAnomalies$direction <- ifelse(asiaTempAnomalies$Value > 0, 1, 0)

if (!file.exists("1880-2016-Europe_land_temp_anomalies.csv")){
    fileUrl <- "https://www.ncdc.noaa.gov/cag/time-series/global/europe/land/ytd/12/1880-2016.csv";
    download.file(fileUrl, destfile="1880-2016-Europe_land_temp_anomalies.csv", method="curl");
}

europeTempAnomalies <- read.csv("1880-2016-Europe_land_temp_anomalies.csv", 
                                header = TRUE, skip = 3);
europeTempAnomalies$direction <- ifelse(europeTempAnomalies$Value > 0, 1, 0)

if (!file.exists("1880-2016-North_America_land_temp_anomalies.csv")){
    fileUrl <- "https://www.ncdc.noaa.gov/cag/time-series/global/northAmerica/land/ytd/12/1880-2016.csv";
    download.file(fileUrl, destfile="1880-2016-North_America_land_temp_anomalies.csv", method="curl");
}

nAmericaTempAnomalies <- read.csv("1880-2016-North_America_land_temp_anomalies.csv", 
                                  header = TRUE, skip = 3);
nAmericaTempAnomalies$direction <- ifelse(nAmericaTempAnomalies$Value > 0, 1, 0)

if (!file.exists("1880-2016-Oceania_land_temp_anomalies.csv")){
    fileUrl <- "https://www.ncdc.noaa.gov/cag/time-series/global/oceania/land/ytd/12/1880-2016.csv";
    download.file(fileUrl, destfile="1880-2016-Oceania_land_temp_anomalies.csv", method="curl");
}

oceaniaTempAnomalies <- read.csv("1880-2016-Oceania_land_temp_anomalies.csv", 
                                 header = TRUE, skip = 3);
oceaniaTempAnomalies$direction <- ifelse(oceaniaTempAnomalies$Value > 0, 1, 0)

if (!file.exists("1880-2016-South_America_land_temp_anomalies.csv")){
    fileUrl <- "https://www.ncdc.noaa.gov/cag/time-series/global/southAmerica/land/ytd/12/1880-2016.csv";
    download.file(fileUrl, destfile="1880-2016-South_America_land_temp_anomalies.csv", method="curl");
}

sAmericaTempAnomalies <- read.csv("1880-2016-South_America_land_temp_anomalies.csv", 
                                  header = TRUE, skip = 3);
sAmericaTempAnomalies$direction <- ifelse(sAmericaTempAnomalies$Value > 0, 1, 0)

xxx <- seq(1910, 2026, by=1)

