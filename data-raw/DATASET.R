# usethis::use_readme_md()
#usethis::use_package("PerformanceAnalytics")
# usethis::use_pipe()
library(tidyverse)
library(tidyquant)
sp500_desc <- tq_index("SP500") %>% dplyr::filter(!stringr::str_detect(symbol,"BRK.B|BF.B|KEYS|WEC|XRAY"))
sp500_prices <- tidyquant::tq_get("AIG",
                                  get  = "stock.prices",
                                  from = "2008-08-01",
                                  to = "2088-09-30") %>%
  stats::na.omit() %>%
  dplyr::group_by(symbol) %>%
  dplyr::select(symbol, date, close = adjusted) %>%
  tidyquant::tq_transmute(select = close, mutate_fun = to.monthly, indexAt = "lastof")
usethis::use_data(sp500_desc, overwrite = T)
usethis::use_data(sp500_prices, overwrite = T)


# tweets

# http://www.trumptwitterarchive.com/archive
# use geany text editor in Linux for very large files
twtrump <- fromJSON("./data-raw/twtrump.json")
twtrump <- twtrump %>%
   dplyr::mutate(created_at = as.POSIXct(created_at,tz = "GMT",format=c("%a %b %d %H:%M:%S +0000 %Y"))) %>%
   dplyr:::rename(favoriteCount = favorite_count, created = created_at, id = id_str) %>%
   as_tibble()
usethis::use_data(twtrump, overwrite = T)

# Global
devtools::document()










