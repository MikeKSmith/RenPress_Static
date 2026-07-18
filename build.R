# build.R --------------------------------------------------------------------
# Two ways to build the static site. Both keep every page as plain Markdown.
#
# Requirements: R (>= 4.1), Pandoc (bundled with RStudio), and:
#   install.packages(c("rmarkdown", "bslib", "sass"))
# ----------------------------------------------------------------------------

# --- Option A (recommended): the R Markdown site generator ------------------
# Reads _site.yml (navbar + bslib theme), renders every .md into ./_site.
#   Rscript build.R
rmarkdown::render_site(encoding = "UTF-8")

# The finished site is in ./_site — open ./_site/index.html in a browser, or
# deploy that folder to any static host (Netlify, GitHub Pages, S3, etc.).


# --- Option B (optional): render with the bslib theme object directly -------
# Useful if you'd rather drive theming from R than YAML. Uncomment to use.
#
# source("theme.R")   # provides `rp_theme`
# pages <- list.files(pattern = "\\.md$", recursive = TRUE)
# pages <- pages[!basename(pages) %in% c("README.md")]
# for (f in pages) {
#   rmarkdown::render(
#     f,
#     output_format = rmarkdown::html_document(
#       theme        = rp_theme,
#       includes     = rmarkdown::includes(in_header = "head.html"),
#       section_divs = TRUE,
#       self_contained = FALSE
#     ),
#     output_dir = "_site",
#     quiet = TRUE
#   )
# }
