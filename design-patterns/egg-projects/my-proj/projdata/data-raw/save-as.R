library(readxl)
library(devtools)
laser_incidents <- read_excel("data-raw/laser_incidents_2010-2014.xls")
use_data(laser_incidents)
