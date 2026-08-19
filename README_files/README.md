# Renaissance Press — static site (Markdown + bslib)

A static rebuild of **renaissancepress.co.uk** (the Edinburgh poetry-and-art
publisher), reconciled against the WordPress export
`renaissancepress.WordPress.20260719.xml`. Every page is plain Markdown — no
raw HTML — and the theme, fonts and Bootstrap styling are supplied by **bslib**
(Bootstrap 5), reproducing the site's WordPress "Twenty Sixteen" theme
*including its Customizer overrides*.

The site is **information only** — no cart, checkout, or prices. Enquiries go to
the contact page.

## Build it

```r
install.packages(c("rmarkdown", "bslib", "sass"))
Rscript build.R
```

Output lands in `./_site`. Deploy that folder to any static host.

One step: `render_site()` reads `_site.yml` (bslib theme + header/footer
includes) and renders every `.md` in this directory into `_site`.

**Keep every page in the root directory.** rmarkdown's site generator only
renders the root; a page moved into a sub-folder is copied out as raw Markdown
instead of being rendered.

## Pages (all from the export)

```
index.md                              Home — "From the press" (the news of
                                      Lucina Prestige's passing) + latest titles
contact.md                            Contact (Milngavie address, per the export)
books.md / prints.md / folios.md      Catalogue pages
people.md                             Artists & Authors index
elizabeth-blackadder-1931-2021.md     Blackadder memorial page
<title-slug>.md                       The 11 catalogue pages (real copy, ISBNs,
                                      dimensions, editions, images) and the 6
                                      biography pages (from the 6 posts), each
                                      named for its WordPress slug
```

The 11 catalogue items: 9 books, plus the two Bruce & Bellany portfolios
(*Woman of the North Sea*, *The Sacred Sea*), which are listed under both
**Folios** (the full portfolios) and **Prints** (individual etchings).

## Page markup

Pages stay as plain Markdown as possible. A page has, at most, four kinds of
Pandoc **fenced div** (`::: name … :::`) marking out blocks that need a CSS
hook — nothing else is HTML:

- `::: hero` — the page's title block: an eyebrow label, the `# Heading`, and
  sometimes an ISBN/date line, in that order.
- `::: catalogue` — wraps a run of `::: item` cards on a listing page.
- `::: item` — one catalogue card: a `### [Title](link.html)`, a "by" line,
  and a description, in that order.
- `::: figure` — a captioned photo (an image line, then a caption line). Used
  on the two pages with a real photo caption; ordinary cover images are just
  `![Title](assets/x.jpg)`.
- `::: contact-card` on contact.md.

Everything *inside* those blocks is unstyled Markdown text — no `<span
class="...">`, no `<p class="...">`. styles.css picks it out **by position**
instead: `.hero > p:first-child` is the eyebrow, `.hero h1 + p` is the ISBN
line, `.item h3 + p` is the "by" line, `.item h3 + p + p` is the description.
Section headers (`##`), links, emphasis, block quotes and thematic breaks
(`---`) are all plain Markdown — pandoc's default fenced-div and
link-attribute extensions (both on by default) are all this needs.

Pandoc's HTML5 writer turns a fenced div whose first block is a heading into a
`<section>` rather than a `<div>` (that's why `::: item` cards render as
`<section class="item">`) — harmless, since every selector above is
class-based, but worth knowing if you inspect the built HTML.

`_site.yml` sets `md_extensions: -implicit_figures`, because Pandoc's default
behaviour auto-wraps *any* image alone in a paragraph in `<figure>` — which
would otherwise put a redundant caption under every book cover. With it off,
a bare `![Title](assets/x.jpg)` stays a plain image, and `::: figure` is used
explicitly for the two pages that want a real caption.

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
| Site title   | enlarged (`#333`) | custom CSS `.site-title` |
| Hairline/`hr`| `#d1d1d1` · 1px | theme |
| Content sheet / page | `#ffffff` on `#d5d5d5` | theme + default background |

`_site.yml` carries the theme as a bslib spec (YAML); `theme.R` is the same as R
code; `styles.css` reproduces the layout + the overrides above, plus the
structural selectors described in "Page markup".

### Header & footer partials

The masthead and footer mirror the Twenty Sixteen markup rather than using a
generic Bootstrap navbar:

- **`header.html`** — `<header class="site-header">` with the custom header
  **banner image** (`assets/cropped-Untitled-design-1.png`), the site title
  ("Renaissance Press"), the tagline ("Edinburgh, Scotland"), and the primary
  **Main** menu from the export (Home · Books · Prints · Folios · Contact us).
  Includes a mobile menu toggle.
- **`footer.html`** — `<footer class="site-footer">` with a `.site-info` block
  (footer menu, contact line, and memorial note).

Both are injected before/after the body. `head.html` is the `<head>` include
(meta + font preconnect). A small script in `header.html` derives the path back
to the site root from the `styles.css` link and rewrites the menu links **and
the banner image `src`**; with a flat site that resolves to `""`, so it is a
no-op — it is kept so the partials keep working if pages are ever nested.

## Reconciliation notes

- **Source of truth is the export** (2026-07-19). At the time of writing, the
  live site serves an older build: its home page is headed "Some of our
  favourites" and its contact page still shows the former Edinburgh address
  (4 Warriston Crescent · 0131 556 3118). The export's Milngavie address and the
  "From the press" home page are the current ones and are what this site uses.
- **Contact:** *c/o 59 Hunter Rd, Milngavie, Scotland G62 7DJ ·
  (+44) 07813 309150 · info@renaissancepress.co.uk*.
- **Home page** leads with the news of Lucina Prestige's passing, then the four
  titles the export's home page features (`ids 333, 256` and `88, 101`):
  *Letters from the Winding Nile*, *Thirteen ways of looking at Tulips*,
  *A Brush with Burns*, *Greatrex*. The export's third shortcode
  (`ids 12, 61`, under "Prints") refers to products that no longer exist, so it
  is replaced by a link to the Prints page.
- **Prints/Folios** show only the two Bruce & Bellany portfolios, as in the
  export.
- **Stock:** *An Eye on the Street* is no longer available through Renaissance
  Press — its page points to Street Level Photoworks.
- **Prices removed.** The export carries WooCommerce prices (£7.99–£10.00 for
  books; £2,000 / £1,500 for the portfolios, £400 / £250 for individual
  etchings). These are deliberately not shown; the portfolio and etching pages
  ask purchasers to contact the Press for prices and availability.
- **Stale phone number dropped.** The export's *Woman of the North Sea* and
  *The Sacred Sea* copy embeds the old `0131 556 3118` number; those pages now
  just say to contact the Press.
- **Images** are local, in `assets/` (from the export's 52 attachments).
- **Customer orders** (107 `shop_order` records in the export) were deliberately
  **not** used — they contain personal data and don't belong on a public site.
- **Nav** matches the live primary menu (Home · Books · Prints · Folios ·
  Contact). Artists & Authors and the memorial are reached from the home page
  and footer, as on the live site.

## Still to check before publishing

1. Delete `_site/` and rebuild before deploying, so nothing stale ships.
2. `README.html` / `README_files/` at the repo root are leftovers of a stray
   render and can be deleted.
3. Several `assets/` files are very large (`greatrex-cover001.jpg` is 5.6 MB).
   Only the resized versions are referenced; the originals could be dropped.
