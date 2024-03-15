# First, run all .qmd chapters

library(quarto)
library(tinytex)

quarto_render("chapters_quarto/", output_format = "latex")

################################################################################

# reformat tex: remove preambles and replace with subfiles and graphicspath commands
# also removes maketitles that are placed in each chapter
# relevant functions are stored locally

source("reformat_tex.r")

folder_path <- "chapters_tex/chapters_quarto/"
replace_before_document_in_folder(folder_path)

################################################################################

# now we can use tinytex to compile the thesis
# if this is your first time using the template,
# you will need to install tinytex (the package), and
# then TinyTex (the engine)

#install.packages("tinytex")
#tinytex::install_tinytex()

# because the UoM template uses lualatex, we may have to manually install
# an additional package (just uncomment line 50)


#tinytex::tlmgr_install("luatex85")

tinytex::lualatex("main.tex", bib_engine = "biber") 












