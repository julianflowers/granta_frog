library(tidyverse)
library(fs)


f <- dir_ls("data", regexp = "nhmp")
gran <- map(f, read_csv, skip = 7)
gran <- map(1:6, \(x) gran[[x]] |> mutate(date = ym(month)))
gran <- map(1:6, \(x) gran[[x]] |> filter(date >= "1981-12-01"))

gran <- map(1:6, \(x) gran[[x]] |> pivot_longer(names_to = "metric", values_to = "value", cols = 2:8))
list_rbind(gran) |>
  mutate(index = str_extract(metric, "^\\w{3}"), 
         period = abs(parse_number(metric)))

nhmp_spi_nrfa_33053_1_ <- read_csv("data/nhmp-spi-nrfa-33053 (1).csv", skip = 7)
nhmp_spi_nrfa_33055_1_ <- read_csv("data/nhmp-spi-nrfa-33055 (1).csv", skip = 7)
nhmp_spi_nrfa_33066_1_ <- read_csv("data/nhmp-spi-nrfa-33066 (1).csv", skip = 7)
nhmp_ssi_nrfa_33053_1_ <- read_csv("data/nhmp-ssi-nrfa-33053 (1).csv", skip = 7)
nhmp_ssi_nrfa_33055_1_ <- read_csv("data/nhmp-ssi-nrfa-33055 (1).csv", skip = 7)
nhmp_ssi_nrfa_33066_1_ <- read_csv("data/nhmp-ssi-nrfa-33066 (1).csv", skip = 7)





nhmp_spi_nrfa_33053_1_ |>
  ggplot() +
  geom_line(aes(month, `spi-1`, group = 1)) +
  geom_smooth(aes(month, `spi-1`), method = "lm", colour = "blue") +
  geom_hline(yintercept = 0)
  

nhmp_spi_nrfa_33053_1_ |>
  mutate(date = ym(month)) |>
  ggplot() +
  geom_line(aes(date, `spi-1`, group = 1)) +
  geom_smooth(aes(date, `spi-1`), method = "gam", colour = "blue") +
  geom_hline(yintercept = 0)
