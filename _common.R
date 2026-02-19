# To check if this file is sourced, add the following line to the file:
#message("_common.R executed successfully!")

set.seed(42)

# R options set globally
# options(width = 60)

options(repos = c(CRAN = "https://cran.rstudio.com"))

# Any package that is required by the script below is given here:
inst_pkgs = load_pkgs = c(
  "bookdown",
  "mltools",
  "knitr",
  "kableExtra", 
  "tidyr",   # for pivot_longer function in ch12
  "mice",    # for imputation in ch13
  "ranger",  # for mice package we need in ch13
  "liver", 
  "ggplot2", 
  "plyr",    # for mutate function
  "dplyr",   # for filter and between functions
  "forcats", # for fct_collapse function in ch4
  "Hmisc",   # for handling missing values
  "naniar",  # for visualizing missing values
  "ROSE",
  "gganimate",  # for animation in ch4
  "ggExtra",   # for marginal plots in ch4
  "plotly",    # for interactive plots in ch4
  "ggcorrplot", # for correlation plot in ch4
  "patchwork",  # for combining ggplots in ch10
  
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
  out.width  = '65%', #fig.width  = 6,
  fig.asp    = 2/3
  )

options(dplyr.print_min = 6, dplyr.print_max = 6)

# for pdf output
options(knitr.graphics.auto_pdf = TRUE)

# =========================================================
# Common ggplot2 Theme for Book
# Springer-style: neutral structure, clear hierarchy, print-safe
# =========================================================

# Base brand colors (for 2-class cases)
book_fill_colors  <- c("#F4A582", "#A8D5BA")
book_color_colors <- c("#F4A582", "#A8D5BA")

# Palette functions that expand to n colors when needed
pal_book_fill <- function(n) {
  base <- book_fill_colors
  if (n <= length(base)) base[seq_len(n)] 
  else grDevices::colorRampPalette(base)(n)  # interpolate extra hues
}
pal_book_color <- function(n) {
  base <- book_color_colors
  if (n <= length(base)) base[seq_len(n)] 
  else grDevices::colorRampPalette(base)(n)
}

# Global defaults for discrete scales (no need to add + scale_* manually)
scale_fill_discrete  <- function(...) ggplot2::discrete_scale("fill",   "book_fill",  palette = pal_book_fill,  ...)
scale_colour_discrete <- function(...) ggplot2::discrete_scale("colour","book_color", palette = pal_book_color, ...)
scale_color_discrete  <- function(...) ggplot2::discrete_scale("color", "book_color", palette = pal_book_color, ...)

# ---- Consistent defaults for geoms ----
# Histogram
ggplot2::update_geom_defaults("histogram", list(colour = "white", fill = "#377EB8"))

# Bar plots (discrete data)
ggplot2::update_geom_defaults("bar", list(colour = "white", fill = "#377EB8"))

# Column plots (used for summarized data, often numeric x)
ggplot2::update_geom_defaults("col", list(colour = "white", fill = "#377EB8"))

# Default (theoretical reference)
ggplot2::update_geom_defaults("abline", list(colour = "#377EB8", linewidth = 1))

# Boxplots (distribution plots)
ggplot2::update_geom_defaults("boxplot", list(
  colour = "#001F3F",      # very dark navy for outlines
  fill   = "#E5F4FB",      # soft light blue fill
  alpha  = 0.6,            # slight transparency
  outlier.colour = "#F4A582",
  outlier.shape  = 16,
  outlier.size   = 2
))

# Boxplots (distribution plots)
ggplot2::update_geom_defaults("violin", list(
  colour = "#001F3F",      # very dark navy for outlines
  fill   = "#E5F4FB",      # soft light blue fill
  alpha  = 0.6,            # slight transparency
  linewidth = 0.4
  #draw_quantiles = c(0.25, 0.5, 0.75)  # show quartiles (consistent summary)
))

# =========================================================
# Global defaults for points, lines, paths, and smooths
# (harmonized with your palette)
# =========================================================

# Points (scatter)
ggplot2::update_geom_defaults("point", list(
  colour = "#377EB8",   # warm accent for series
  size   = 2.2,
  alpha  = 0.85
))

# Jittered points (same look as points)
ggplot2::update_geom_defaults("jitter", list(
  colour = "#377EB8",
  size   = 2.0,
  alpha  = 0.75,
  width  = 0.15,
  height = 0.15
))

# Lines (time series / trends)
ggplot2::update_geom_defaults("line", list(
  colour   = "#377EB8",
  linewidth = 0.8,
  alpha    = 0.95
))

# Paths (polylines without ordering by x)
ggplot2::update_geom_defaults("path", list(
  colour   = "#377EB8",
  linewidth = 0.8,
  alpha    = 0.95
))

# Smooths (regression lines/bands)
ggplot2::update_geom_defaults("smooth", list(
  colour = "#F4A582",   # line
  fill   = "#A8D5BA",   # band
  linewidth = 0.9,
  alpha  = 0.20,        # band transparency
  se     = TRUE,
  method = "loess"      # sensible default for small/medium n
))

# Optional: density (area-style)
ggplot2::update_geom_defaults("density", list(
  colour = NA,
  fill   = "#377EB8",
  alpha  = 0.6,
  linewidth = 0
))
# =========================================================

# ---- Global Springer-style theme ----
ggplot2::theme_set(
  ggplot2::theme_minimal(base_size = 11) +
    ggplot2::theme(
      # Panel background and gridlines
      panel.background = ggplot2::element_rect(fill = "white", colour = NA),
      panel.grid.major = ggplot2::element_line(
        linewidth = 0.25, colour = "gray80", linetype = "solid"
      ),
      panel.grid.minor = ggplot2::element_line(
        linewidth = 0.15, colour = "gray90", linetype = "solid"
      ),
      
      # Axis lines — clear and dark for structure
      # axis.line = ggplot2::element_line(colour = "black", linewidth = 0.4, lineend = "square"),
      
      # Axis text and titles
      axis.text  = ggplot2::element_text(size = 11, colour = "black"),
      axis.title = ggplot2::element_text(size = 12, face = "bold", colour = "black"),
      
      # Plot titles and subtitles
      plot.title = ggplot2::element_text(
        size = 14, face = "bold", hjust = 0.5, colour = "black"
      ),
      plot.subtitle = ggplot2::element_text(
        size = 11, hjust = 0.5, colour = "gray20"
      ),
      
      # Legends — simple and light
      legend.title = ggplot2::element_text(size = 11, face = "bold", colour = "black"),
      legend.text  = ggplot2::element_text(size = 10, colour = "black"),
      legend.background = ggplot2::element_rect(fill = "white", colour = "white"),
      
      # Margins
      plot.margin = ggplot2::margin(6, 6, 6, 6, "pt")
    )
)

# =========================================================

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
    "gifski",     # for rendering gifs in ch4 
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
