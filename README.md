# Instructions

## Quarto Chapters


 - [Quarto](https://quarto.org/) is an open-source document preparation system.
 - If you are using the latest version of Rstudio, quarto is included. Otherwise, follow the link to download the standalone version. There is also a VS Code extension.
 - Each chapter is written using quarto in Rstudio.
 - These .qmd files are stored in `chapters_quarto`.
 - Quarto features markdown syntax, and can mix and match code chunks from a range of languages.
 - Figures can be dynamically generated with quarto, which also controls all figure options.
 - Models can be built and cached using quarto, which saves you time.

## Rendering

 - The project is set up to render only latex, but you can change this to render individual pdf/html instances of chapters.
 - Once you have finished writing a chapter, go into `main.tex` and edit the CHAPTERS section to include all your chapters.
 - Authorship, declarations, and abstracts are also handled by `main.tex`.
 - Once all chapters are finished, you are ready to knit your final thesis.
 - I am an R user, so I have written an R script that renders each .qmd chapter, reformats the .tex of each chapter, and then produces the thesis using the .cls file included.
 - **NB: reformatting the `.tex` is important**. Pandoc adds preamables which `main.tex` **does not want**.
 - (Feel free to create a PR to contribute scripts in other languages that achieve this.)
 - My R script uses TinyTex to produce the final thesis, but this is not necessary - uploading a .zip of the thesis to overleaf also works perfectly.
 - Please read the `finalise_thesis.R` script comments before using it, as you may need to manually install additional fonts.

## Quirks

 - Due to the fonts used, LuaLatex must be used to compile.
 - If you use TinyTex like me, you will need to additionally install the luatex85 package (there is a line in `finalise.r` that does this). Overleaf might need you to select this option via the menu.
 - Biber (not BibLatex) must also be used. Overleaf does this automatically, but I had to specify this for TinyTex.
 
## Using Trackdown for Collaborative Editing

 - I have used the [Trackdown](https://github.com/ClaudioZandonella/trackdown) package to enable collaborative editing. Set up is relatively involved. In short:
	- Follow instructions to create Google drive API to sync with local qmd files
	- Authorise using client id and secret from Google drive API
	- I have provided `helper_functions.R` to automate up and down sync between qmds and google docs

## Housekeeping

 - This template is based on the UoM thesis template found on Overleaf and written by Alex Casson.
 - Additional improvements for functionality were made by David Petrescu.
 - Justification for not using Quarto books: this implementation keeps each chapter (potentially including Docker containers etc) separate, and lets Latex (via a pre-existing thesis template) handle the formatting. IMO this is simpler and more language-agnostic. NB this means that most formatting options (margins, fonts etc) are dealt with by `main.tex` or the .cls file.
 - I use Rstudio, but there is no reason why this would not work with any IDE that supports quarto (however I won't be much help re issues for other IDEs).
 - To-Do:
	- Write guide to Dockerising chapters/entire thesis.
	- Write more scripts for finalising thesis

