# build.R --------------------------------------------------------------------
# Builds the static site. Every page is plain Markdown, and every page lives in
# the root directory, so the whole site renders in a single step.
#
# Requirements: R (>= 4.1), Pandoc (bundled with RStudio), and:
#   install.packages(c("rmarkdown", "bslib", "sass"))
#
# Run:
#   Rscript build.R          # or, in R:  rmarkdown::render_site()
#
# render_site() reads _site.yml (bslib theme + header/footer includes) and
# renders every .md in this directory into ./_site. Keep pages flat: the site
# generator only renders the root directory, so a page in a sub-folder would be
# copied out as raw Markdown instead of being rendered.
#
# Page content is plain Markdown with a handful of Pandoc fenced divs
# (::: hero, ::: catalogue / ::: item, ::: figure, ::: contact-card) — no raw
# HTML. _site.yml sets md_extensions: -implicit_figures so a bare cover image
# stays a plain <img> rather than being auto-wrapped in <figure>. See
# AGENTS.md for the authoring conventions.
# ----------------------------------------------------------------------------

rmarkdown::render_site(encoding = "UTF-8")

# The finished site is in ./_site — open ./_site/index.html in a browser, or
# deploy that folder to any static host (Netlify, GitHub Pages, S3, etc.).


# --- Optional: render with the bslib theme object directly ------------------
# Useful if you'd rather drive theming from R than from YAML. `rp_theme` in
# theme.R is the exact equivalent of the `theme:` block in _site.yml.
#
# source("theme.R")
# pages <- setdiff(list.files(pattern = "\\.md$"), c("README.md", "AGENTS.md"))
# for (f in pages) {
#   rmarkdown::render(
#     f,
#     md_extensions = "-implicit_figures",
#     output_format = rmarkdown::html_document(
#       theme    = rp_theme,
#       includes = rmarkdown::includes(
#         in_header   = "head.html",
#         before_body = "header.html",
#         after_body  = "footer.html"
#       ),
#       css            = "styles.css",
#       section_divs   = TRUE,
#       self_contained = FALSE
#     ),
#     output_dir = "_site",
#     quiet = TRUE
#   )
# }
