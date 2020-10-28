library(rgdal)
library(dplyr)
library(readxl)


my_shape <- readRDS("my_shape")
ico_common <- read_excel("./ico_project.xlsx", sheet = 1)

###make a table with all country names as in shape file

temp <- match(ico_common$Country, my_shape$NAME_RU)
names <- my_shape$NAME_RU[-temp]
Country <- ico_common$Country
x <- ico_common
### create table with all countries
Country1 <- as.data.frame(c(Country, names))

### name column in this table the same as x table for full_join
colnames(Country1) = "Country"
new_table <- full_join(x, Country1, by = "Country")



###match shape file names and new table names
ico_common <- new_table[order(match(new_table$Country, my_shape$NAME_RU)),]
names(ico_common) <-tolower(names(ico_common))
ico_common <- as.data.frame(ico_common)
remove(new_table, x, names, temp, Country1)
                                            


