library(rgdal)
library(dplyr)
library(readxl)
library(janitor)

my_shape <- readRDS("my_shape")
ico_common <- read_excel("./ico_project.xlsx", sheet = 1)
ico_applicable <- read_excel("./ico_project.xlsx", sheet = 3)
ico_time <- read_excel("./ico_project.xlsx", sheet = 5)



      ####make common table with all country names as in shape file ####
temp <- match(ico_common$Country, my_shape$NAME_RU)
names <- my_shape$NAME_RU[-temp]
Country <- ico_common$Country

### create table with all countries
Country1 <- as.data.frame(c(Country, names))

### name column in this table the same as x table for full_join
colnames(Country1) = "Country"
new_table <- full_join(ico_common, Country1, by = "Country", copy = FALSE)



###match shape file names and new table names
ico_common <- new_table[order(match(new_table$Country, my_shape$NAME_RU)),]
names(ico_common) <-tolower(names(ico_common))
ico_common <- as.data.frame(ico_common)
remove(new_table, names, temp, Country1)


      ####make applicable table with all country names as in shape file####

temp <- match(ico_applicable$Country, my_shape$NAME_RU)
names <- my_shape$NAME_RU[-temp]
Country <- ico_applicable$Country

### create table with all countries
Country1 <- as.data.frame(c(Country, names))

### name column in this table the same as x table for full_join
colnames(Country1) = "Country"
new_table <- full_join(ico_applicable, Country1, by = "Country", copy = FALSE)



###match shape file names and new table names
ico_applicable <- new_table[order(match(new_table$Country, my_shape$NAME_RU)),]
names(ico_applicable) <-tolower(names(ico_applicable))
ico_applicable <- as.data.frame(ico_applicable)
remove(new_table, names, temp, Country1)

                       #### make ico_time table ####
#make it as numeric
for (i in c(2,3,4,8,11,13:21)){
 ico_time[,i] <- as.numeric(unlist(ico_time[,i]))
}
#make it as date
for (i in c(2,3,4,8,11,13:21)){
  ico_time[,i] <- excel_numeric_to_date(unlist(ico_time[,i]))
}
ico_time[,2:22] <- lapply(ico_time[,2:22], as.Date)

#make appropriate date order
ico_time <- as.data.frame(ico_time)
for (i in colnames(ico_time[,2:22])){
  ico_time[,i] <- format(ico_time[,i], '%d-%m-%Y')
}

