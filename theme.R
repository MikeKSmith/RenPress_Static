# theme.R -------------------------------------------------------------------
# The Renaissance Press theme as bslib code — a faithful reproduction of the
# WordPress "Twenty Sixteen" theme (style.css v1.7, default colour scheme).
# This is the exact equivalent of the `theme:` block in _site.yml, provided so
# the theme can be reused programmatically (Shiny, Quarto, or a custom render
# loop — see build.R, "Option B").
#
#   install.packages(c("bslib", "sass"))

library(bslib)
library(sass)

rp_theme <- bs_theme(
  version       = 5,
  bg            = "#ffffff",              # content sheet
  fg            = "#1a1a1a",              # body text
  primary       = "#666666",             # custom CSS: a { color:#666 }
  secondary     = "#686868",             # muted / link-hover grey
  base_font     = font_google("Merriweather"),
  heading_font  = font_google("Montserrat"),
  code_font     = font_google("Inconsolata"),
  "font-size-base"       = "1rem",        # 16px
  "line-height-base"     = 1.75,
  "headings-font-weight" = 700,
  "border-color"         = "#d1d1d1",
  "link-decoration"      = "none"
)

# Fold Twenty Sixteen's layout signature (floating white sheet on #d5d5d5,
# hairline rules, catalogue cards) into the compiled theme.
rp_theme <- bs_add_rules(rp_theme, sass::sass_file("styles.css"))

# Preview without building the whole site:
#   bslib::bs_theme_preview(rp_theme)
