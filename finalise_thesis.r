# First, run all .qmd chapters

#install.packages("quarto")
#install.packages("tinytex")

library(quarto)
library(tinytex)

quarto_render("chapters_quarto/", output_format = "latex")

################################################################################

# functions to reformat tex are stored in the local directory

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
# an additional package (just uncomment line 30)

#tinytex::tlmgr_install("luatex85")

#sometimes the Tex Gyres Termes font is not found, so manually install it via
#tinytex

#tinytex::tlmgr_install("tex-gyre")

tinytex::lualatex("main.tex", bib_engine = "biber") 












