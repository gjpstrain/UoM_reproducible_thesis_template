library(quarto)
library(tinytex)

# Following command renders all quarto chapters:

quarto_render("chapters_quarto/", output_format = "latex")

# Following command renders only a single chapter:

quarto_render("chapters_quarto/example_chapter.qmd", output_format = "latex")

# functions to reformat tex are stored in the local directory
# these must be run before rendering the final pdf

source("reformat_tex.R")

folder_path <- "chapters_tex/chapters_quarto/"
replace_before_document_in_folder(folder_path)

################################################################################

# Use the below command to render the final pdf

tinytex::lualatex("main.tex", bib_engine = "biber")