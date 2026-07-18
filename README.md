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

### Header & footer partials

The site masthead and footer mirror the Twenty Sixteen markup rather than using a
generic Bootstrap navbar:

- **`header.html`** — `<header class="site-header">` with the custom header
  **banner image** (`assets/cropped-Untitled-design-1.png`), the site title
  ("Renaissance Press"), the tagline ("Edinburgh, Scotland"), and the primary
  **Main** menu from the export (Home · Books · Prints · Folios · Contact us).
  Includes a mobile menu toggle.
- **`footer.html`** — `<footer class="site-footer">` with a `.site-info` block
  (footer menu, contact line, and memorial note).

Both are injected via `_site.yml` (`before_body` / `after_body`), so the auto
Bootstrap navbar is disabled. A tiny script in `header.html` rewrites the menu
links **and the banner image `src`** for pages in sub-folders (`products/`,
`people/`) so they resolve at any depth, and drives the mobile toggle. `head.html` remains the `<head>` include
(meta + font preconnect).

## Reconciliation notes (what changed after the export)

- **Contact corrected.** The export's current address is *c/o 59 Hunter Rd,
  Milngavie, G62 7DJ · (+44) 07813 309150*. The earlier Edinburgh/Warriston
  address (from a stale cache) has been removed.
- **Prints/Folios corrected.** The Elizabeth Blackadder prints and the two £45
  folios in my first draft were from old cached pages and are **not** in the
  current shop. Prints/Folios now show only the two Bruce & Bellany portfolios,
  as in the export.
- **Home page** now leads with the news of Lucina Prestige's passing, matching
  the live "From the press" page.
- **Stock:** *An Eye on the Street* is marked out of stock (and its own page notes
  it is no longer available through Renaissance Press — contact Street Level
  Photoworks).
- **Prices** display the real WooCommerce values (£7.99–£10.00 for books; the
  portfolios are £2,000 / £1,500 with individual etchings £400 / £250).

## Please check before publishing

1. **Images** are referenced from the live `renaissancepress.co.uk/wp-content/…`
   URLs (from the export). For a fully self-contained site, download the 52
   attachments into an `assets/` folder and repoint the `<img src>`/`![]()` paths.
2. **A stale phone number** (`0131 556 3118`) is embedded in the *Woman of the
   North Sea* and *The Sacred Sea* product descriptions — this is your original
   copy, left verbatim. Update it to the Milngavie number if you wish.
3. **Cart/checkout** are omitted (this is static); product pages link to
   "Order or enquire" → Contact, matching the portfolios' existing guidance.
   For a live basket, a commerce backend (e.g. Snipcart) can be added.
4. **Customer orders** (107 `shop_order` records in the export) were deliberately
   **not** used — they contain personal data and don't belong on a public site.
5. **Nav** matches the live primary menu (Home · Books · Prints · Folios ·
   Contact). Artists & Authors and the memorial are reached from the home page
   and footer, as on the live site.
