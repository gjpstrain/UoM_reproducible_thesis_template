replace_before_document <- function(file_path) {
  lines <- readLines(file_path)
  preamble_index <- grep("\\\\begin\\{document\\}", lines)
  
  if (length(preamble_index) > 0) {
    # Replace preamble
    new_lines <- c("\\documentclass[../main.tex]{subfiles}",
                   lines[(preamble_index):length(lines)])
    
    # Remove \maketitle
    new_lines <- grep("\\\\maketitle", new_lines, invert = TRUE, value = TRUE)
    
    # Combine lines to process \pandocbounded
    combined <- paste(new_lines, collapse = "\n")
    
    # Remove \pandocbounded{...}
    combined <- gsub(
      "\\\\pandocbounded\\{((?>[^{}]+|\\{[^}]*\\})*)\\}",
      "\\1",
      combined,
      perl = TRUE
    )
    
    # Split back into lines
    new_lines <- unlist(strsplit(combined, "\n", fixed = TRUE))
    
    # Fix \includegraphics
    new_lines <- sapply(new_lines, function(line) {
      match <- regexpr("(\\\\includegraphics)(\\[[^\\]]*\\])?(\\{[^\\}]+\\})", line, perl = TRUE)
      
      if (match[1] != -1) {
        original <- regmatches(line, match)[1]
        
        # Extract optional args and filename
        parts <- regmatches(original, gregexpr("\\\\includegraphics|\\[[^\\]]*\\]|\\{[^\\}]+\\}", original))[[1]]
        cmd <- parts[1]
        opts <- ifelse(length(parts) > 1 && grepl("^\\[", parts[2]), parts[2], "")
        path <- parts[length(parts)]
        
        # Clean options
        opts <- gsub("keepaspectratio,?", "", opts)
        opts <- gsub(",\\s*\\]", "]", opts)
        opts <- gsub("\\[\\s*\\]", "", opts)
        
        # Add width=\textwidth if not present
        if (!grepl("width=", opts)) {
          if (nzchar(opts)) {
            opts <- gsub("^\\[", "[width=\\textwidth,", opts)
          } else {
            opts <- "[width=\\textwidth]"
          }
        }
        
        # Rebuild
        new_graphics <- paste0(cmd, opts, path)
        regmatches(line, match) <- new_graphics
      }
      
      line
    }, USE.NAMES = FALSE)
    
    writeLines(new_lines, file_path)
    cat("Updated", file_path, "\n")
  } else {
    cat("No \\begin{document} found in", file_path, "\n")
  }
}

replace_before_document_in_folder <- function(folder_path) {
  files <- list.files(folder_path, pattern = "\\.tex$", full.names = TRUE)
  lapply(files, replace_before_document)
}
