navbarPage("Analysis of Cholesterol in the United States",
           tabPanel("Graphics",fluidPage(theme = shinytheme("united")),
tags$head(
  tags$style(HTML(".shiny-output-error-validation{color: red;}"))),
pageWithSidebar(
  headerPanel('Apply filters'),
  sidebarPanel(width = 4,
    selectInput('risk', 'Choose heart disease risk level:',
                list("High" = "high",
                     "Medium" = "medium", 
                     "Low" = "low"),
                selected = "High"),
    selectInput('maritalStatus', 'Choose marital status:',
                list("Married",
                     "Widowed", 
                     "Divorced",
                     "Separated",
                     "Never married",
                     "Living with partner"),
                selected = "High"),
   submitButton("Update filters")
  ),
  mainPanel(
    fluidRow(
      splitLayout(cellWidths = c("45%", "55%"), plotlyOutput("riskGender"), plotlyOutput("genderRace"))
    ),
    br(),
    br(),
    fluidRow(
      splitLayout(cellWidths = c("100%"), p(img(src='gganimate02.gif')))
    ),
    br(),
    br(),
    fluidRow(
      splitLayout(cellWidths = c("50%", "50%"), plotlyOutput("marital"), p(img(src='gganimate01.gif')))
    ),
    br(),
    br(),
    fluidRow(
      splitLayout(cellWidths = c("100%"), plotlyOutput("education"))
    ),
    br(),
    br(),
    fluidRow(
      splitLayout(cellWidths = c("100%"), plotlyOutput("income"))
    ),
    br(),
    br(),
    fluidRow(
      splitLayout(cellWidths = c("100%"), plotlyOutput("region"))
    ),
    br(),
    br(),
    p("National Center for Health Statistics - Location",style = "font-size:25px"),
    fluidRow(
      splitLayout(cellWidths = c("100%"), leafletOutput("location"))
    )
  )
)),

tabPanel("About",
         p("Source: National Health and Nutrition Examination Survey",style = "font-size:25px"),
         p(a("https://www.cdc.gov/nchs/index.htm", href="https://www.cdc.gov/nchs/index.htm", target="_blank"),style = "font-size:18px"),
         p("The National Health and Nutrition Examination Survey is a program designed to asses the health and nutritional status of adults and children in the United States. NHANES is a major program of the National Center for Health Statistics (NCHS). NCHS is part of the Centers for Disease Control and Prevention (CDC).",style = "font-size:18px"),
         p("The survey examines a sample of 5,000 persons each year, located in counties across the country. NHANES interview includes demographic, socioeconomic, dietary, and health-related questions. Examination component consists of medical, dental, physiological measurements and laboratory tests.",style = "font-size:18px"),
         hr(),
         p("NHANES 2015–2016 data source was selected since it includes LDL and Triglycerides needed for analysis",style = "font-size:18px"),
         p("Data source was downloaded from the following link:",style = "font-size:25px"),
         p(a("https://wwwn.cdc.gov/nchs/nhanes/search/datapage.aspx?Component=Laboratory&CycleBeginYear=2015", href="https://wwwn.cdc.gov/nchs/nhanes/search/datapage.aspx?Component=Laboratory&CycleBeginYear=2015", target="_blank"),style = "font-size:18px"),
         hr(),
         p("Data source documentation, codebook and frequencies",style = "font-size:25px"),
         p("Demographic data from surveys:",style = "font-size:18px"),
         p(a("https://wwwn.cdc.gov/Nchs/Nhanes/2015-2016/DEMO_I.htm",href="https://wwwn.cdc.gov/Nchs/Nhanes/2015-2016/DEMO_I.htm",target="_blank"),style = "font-size:18px"),
         p("Cholesterol - Low Density Lipoprotein (LDL) and Triglycerides lab results:",style = "font-size:18px"),
         p(a("https://wwwn.cdc.gov/Nchs/Nhanes/2015-2016/TRIGLY_I.htm",href="https://wwwn.cdc.gov/Nchs/Nhanes/2015-2016/TRIGLY_I.htm",target="_blank"),style = "font-size:18px"),
         p("Cholesterol - High Density Lipoprotein (HDL) lab results:",style = "font-size:18px"),
         p(a("https://wwwn.cdc.gov/Nchs/Nhanes/2015-2016/HDL_I.htm",href="https://wwwn.cdc.gov/Nchs/Nhanes/2015-2016/HDL_I.htm",target="_blank"),style = "font-size:18px"),
         hr()
),
 
tabPanel("References",
         p(a("National Center for Health Statistics", href="https://www.cdc.gov/nchs/index.htm", target="_blank"),style = "font-size:18px"),
         p(a("What Your Cholesterol Levels Mean - American Heart Association", href="https://www.heart.org/en/health-topics/cholesterol/about-cholesterol/what-your-cholesterol-levels-mean", target="_blank"),style = "font-size:18px"),
         p(a("Familial Hypercholesterolemia (FH) - American Heart Association", href="https://www.heart.org/en/health-topics/cholesterol/causes-of-high-cholesterol/familial-hypercholesterolemia-fh", target="_blank"),style = "font-size:18px")
),

tabPanel("Developer",
         p(img(src='juan_m_carballo.png')),
         p(a("Juan Carballo", href="https://www.linkedin.com/in/juan-m-carballo-0a5b2149", target="_blank"),style = "font-size:25px"),
         p("e-mail: JCarballo@stu.edu",style = "font-size:20px"),
         p(a("GitHub Repo", href="https://github.com/STUBigDataJuan/cholesterol", target="_blank"),style = "font-size:25px")
         
))




