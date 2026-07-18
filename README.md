# Renaissance Press — static site (Markdown + bslib)

A static rebuild of **renaissancepress.co.uk** (the Edinburgh poetry-and-art
publisher), reconciled against the WordPress export `renaissancepress_WordPress_2026-07-18.xml`.
Every page is plain Markdown; the theme, fonts and Bootstrap styling are supplied
by **bslib** (Bootstrap 5) and reproduce the site's WordPress "Twenty Sixteen"
theme *including its Customizer overrides*.

## Build it

```r
install.packages(c("rmarkdown", "bslib", "sass"))
rmarkdown::render_site(encoding = "UTF-8")   # or: Rscript build.R
```

Output lands in `./_site`. Deploy that folder to any static host.

## Pages (all from the export)

```
index.md                              Home — "From the press" (incl. the news of
                                      Lucina Prestige's passing) + latest titles
contact.md                            Contact (Milngavie address, per the export)
books.md / prints.md / folios.md      Catalogue pages
people.md                             Artists & Authors index
people/{george-bruce, elizabeth-blackadder, john-bellany,
        alan-spence, david-bruce, david-peat}.md    bio pages (from the 6 posts)
elizabeth-blackadder-1931-2021.md     Blackadder memorial page
products/*.md                         All 11 product pages, generated from the
                                      export (real copy, ISBNs, prices, images)
```

The 11 products: 9 books, plus the two Bruce & Bellany portfolios
(*Woman of the North Sea*, *The Sacred Sea*), which are categorised as both
**Folios** (the full portfolios) and **Prints** (individual etchings).

## Theme fidelity

Reproduces "Twenty Sixteen" (`style.css` v1.7) **plus** the active theme's
Customizer CSS from the export (the `twentysixteen` custom_css record; the other
custom_css belongs to the unused `twentynineteen` theme and was ignored):

| Token        | Value | Source |
|--------------|-------|--------|
| Body font    | Merriweather, Georgia, serif · 16px / 1.75 | theme |
| Heading font | Montserrat, "Helvetica Neue", sans-serif · 700 | theme |
| Code font    | Inconsolata | theme |
| Body text    | `#1a1a1a` | theme |
| **Headings** | **`#333333`** | custom CSS `h1–h4 { color:#333 }` |
| **Links**    | **`#666666`**, underline on hover | custom CSS `a { color:#666 }` |
| **Prices**   | **`#000000`** | custom CSS `.price { color:#000 }` |
| Site title   | enlarged (`#333`) | custom CSS `.site-title` |
| Hairline/`hr`| `#d1d1d1` · 1px | theme |
| Content sheet / page | `#ffffff` on `#d5d5d5` | theme + default background |

`_site.yml` carries the theme as a bslib spec (YAML); `theme.R` is the same as R
code; `styles.css` reproduces the layout + the overrides above.