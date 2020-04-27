# Required libraries and packages
# libraries = c("shiny", "shinydashboard", "shinythemes", "plotly", "shinycssloaders","tidyverse",
#             "scales", "knitr", "dplyr", "plotly", "SASxport", "gifski", "gganimate", "leaflet")
# 
# # Verifiy that the required packages are installed. Missing packages will be installed automatically
# package.check <- lapply(libraries, FUN = function(x) {
#   if (!require(x, character.only = TRUE)) {
#     install.packages(x, dependencies = TRUE)
#   }
# })

library("shiny")
library("shinydashboard")
library("shinythemes")
library("plotly")
library("shinycssloaders")
library("tidyverse")
library("scales")
library("knitr")
library("dplyr")
library("plotly")
library("SASxport")
library("gifski")
library("gganimate")
library("leaflet")
library("maps")

# Loading data
### Loading cholesterol - LDL and Triglycerides lab results
trigly <- read.xport("TRIGLY_I.XPT")

### Loading cholesterol - HDL lab results
hdl <- read.xport("HDL_I.XPT")


### Loading demographic data
demo <- read.xport("DEMO_I.XPT")


### Loading map data from usa map
usa <- map_data("usa")

### Exploratory data analysis
#### Coding heart disease risk based on LDL score
trigly <- trigly %>%
  mutate(
    RISK = case_when(
      LBDLDL <= 130 ~ "low",
      LBDLDL >= 190 ~ "high",
      TRUE ~ "medium"
    )
  )

# table with risk values
table(trigly$RISK)

#### Getting race and gender demographics about patients with LDL data
# joining trigly data with demographic by respondent sequence number
demo_trigly <- trigly %>%
  inner_join(demo) %>%
  mutate(
    RIDRETH1 = case_when(
      RIDRETH1 == 1 ~ "Mexican American",
      RIDRETH1 == 2 ~ "Other Hispanic",
      RIDRETH1 == 3 ~ "Non-Hispanic White",
      RIDRETH1 == 4 ~ "Non-Hispanic Black",
      RIDRETH1 == 5 ~ "Other Race"
    ),
    RIAGENDR = case_when(
      RIAGENDR == 1 ~ "Male",
      RIAGENDR == 2 ~ "Female"
    )
  )

# table with risk values and gender
table(demo_trigly$RIAGENDR, demo_trigly$RISK)

# table with risk values and race/ethnicity
table(demo_trigly$RIDRETH1, demo_trigly$RISK)

#### Coding Marital status
demo_trigly <- demo_trigly %>%
  mutate(
    DMDMARTL = case_when(
      DMDMARTL == 1 ~ "Married",
      DMDMARTL == 2 ~ "Widowed",
      DMDMARTL == 3 ~ "Divorced",
      DMDMARTL == 4 ~ "Separated",
      DMDMARTL == 5 ~ "Never married",
      DMDMARTL == 6 ~ "Living with partner"
    )
  )

# table marital status and heart disease risk
table(demo_trigly$DMDMARTL,demo_trigly$RISK)

#### Education level and heart disease risk
# table marital status and heart disease risk
table(demo_trigly$DMDHREDU,demo_trigly$RISK)

