# To check if this file is sourced, add the following line to the file:
#message("_common.R executed successfully!")

set.seed(42)

# R options set globally
# options(width = 60)

# Any package that is required by the script below is given here:
inst_pkgs = load_pkgs = c(
    "bookdown",
    "mltools",
    "knitr",
    "kableExtra", 
    "tidyr",   # for pivot_longer function in ch12
    "mice",    # for imputation in ch13
    "liver", 
    "ggplot2", 
    "plyr",    # for mutate function
    "dplyr",   # for filter and between functions
    "forcats", # for fct_collapse function in ch4
    "Hmisc",   # for handling missing values
    "naniar",  # for visualizing missing values
    "ROSE",
    "gganimate", # for animation in ch4
    "ggcorrplot", # for correlation plot in ch4
    "dslabs",    # for gapminder dataset in ch4
    
    "pROC", 
    "neuralnet",
    "psych", 
    "rpart", 
    "rpart.plot", 
    "C50", 
    "randomForest",
    "naivebayes",
    "factoextra",
    "here")

inst_pkgs = inst_pkgs[!(inst_pkgs %in% installed.packages()[,"Package"])]
if (length(inst_pkgs)) install.packages(inst_pkgs)

# Dynamically load packages
pkgs_loaded = lapply(load_pkgs, require, character.only = TRUE)

# Set output options
if (is_html_output()) {
  options(width = 120)
}
if (is_latex_output()){
  options(width = 80)
}
options(digits = 7, bookdown.clean_book = TRUE, knitr.kable.NA = "NA")

# Activate crayon output
options(
  #crayon.enabled = TRUE,
  pillar.bold = TRUE,
  stringr.html = FALSE
)

# example chunk options set globally
knitr::opts_chunk$set(
  tidy = FALSE,
  out.width = "\\textwidth",
  comment = NA,
  fig.pos = 'H',
  fig.retina = 1,
  comment    = "  ",
  collapse   = TRUE,
  echo       = TRUE, 
  message    = FALSE, 
  warning    = FALSE, 
  error      = FALSE,
  fig.show   = 'hold',
  fig.align  = 'center',
  out.width  = '70%', #fig.width  = 6,
  fig.asp    = 2/3
  )

options(dplyr.print_min = 6, dplyr.print_max = 6)

# for pdf output
options(knitr.graphics.auto_pdf = TRUE)

ggplot2::theme_set(ggplot2::theme( 
                            panel.background = ggplot2::element_rect(fill = "white", colour = "white", linewidth = 0.5, linetype = "solid"),
                            panel.grid.major = ggplot2::element_line(linewidth = 0.2, linetype = 'solid', colour = "gray77"), 
                            panel.grid.minor = ggplot2::element_line(linewidth = 0.1, linetype = 'solid', colour = "gray90"),
                            axis.text  = ggplot2::element_text(size = 11), 
                            axis.title = ggplot2::element_text(size = 12, face = "bold"),
                            title = ggplot2::element_text(size = 14, face = "bold"), 
                            plot.title = ggplot2::element_text(hjust = 0.5)
                  ))

# For LaTeX output
options(tinytex.verbose = TRUE)

# To get kable tables to print nicely in .tex file
if (is_latex_output()) {
  options(kableExtra.auto_format = FALSE, knitr.table.format = "latex")
}

# Automatically create a bib database for R packages
write_bib(
  c(
    .packages(), 
    "bookdown", "knitr", "rmarkdown",
    "kableExtra", 
    "DMwR2", 
    "liver", 
    "ggplot2", 
    "plyr",    # for mutate function
    "dplyr",   # for filter and between functions
    "forcats", # for fct_collapse function in ch4
    "Hmisc",   # for handling missing values
    "naniar",  # for visualizing missing values
    "ROSE",
    "gganimate", # for animation in ch4
    "ggcorrplot", # for correlation plot in ch4
    "dslabs",    # for gapminder dataset in ch4
    
    "pROC", 
    "neuralnet",
    "psych", 
    "rpart", 
    "rpart.plot", 
    "C50", 
    "randomForest",
    "naivebayes",
    "factoextra",
    "here"
  ),
  here::here("packages.bib")
)
