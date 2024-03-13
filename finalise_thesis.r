# First, run all .qmd chapters

library(quarto)
library(tinytex)

quarto_render("chapters_quarto/", output_format = "latex")

################################################################################

# reformat tex: remove preambles and replace with subfiles and graphicspath commands
# also removes maketitles that are placed in each chapter

replace_before_document <- function(file_path) {
  lines <- readLines(file_path)
  preamble_index <- grep("\\\\begin\\{document\\}", lines)
  
  if (length(preamble_index) > 0) {
    new_lines <- c("\\documentclass[../main.tex]{subfiles}",
                   lines[(preamble_index):length(lines)])
    
    new_lines <- grep("\\\\maketitle", new_lines, invert = TRUE, value = TRUE)
    
    new_content <- paste(new_lines, collapse = "\n")
    writeLines(new_content, file_path)
    cat("Replaced preamble and removed \\maketitle in", file_path, "\n")
  } else {
    cat("No \\begin{document} found in", file_path, "\n")
  }
}

# create function

replace_before_document_in_folder <- function(folder_path) {
  files <- list.files(folder_path, pattern = "\\.tex$", full.names = TRUE)
  lapply(files, replace_before_document)
}

# run function

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












