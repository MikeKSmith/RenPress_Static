# AGENTS.md — working notes for automated contributors

Static rebuild of renaissancepress.co.uk. Markdown in, HTML out, rendered by R
(`rmarkdown` + `bslib`) reproducing the WordPress "Twenty Sixteen" theme.

## Ground rules

- **The WordPress export is the source of truth** for copy, not the live site.
  The live site currently serves an older build (see README, "Reconciliation
  notes"). Don't "fix" the contact address back to the Edinburgh one.
- **Information only.** No cart, checkout, PayPal buttons, or prices. Anything
  commercial in the export (`shop_order`, `product` prices, WooCommerce
  shortcodes) is out of scope. The 107 `shop_order` records contain personal
  data — never use them.
- **Don't hand-edit `_site/`.** It is build output.
- **No raw HTML in `.md` files.** Structure comes from a small set of Pandoc
  fenced divs (`::: hero`, `::: catalogue`/`::: item`, `::: figure`,
  `::: contact-card`); everything else — eyebrow labels, "by" lines,
  descriptions — is unstyled Markdown text, picked out by CSS position
  selectors in styles.css (`.hero > p:first-child`, `.item h3 + p`, etc). If a
  new page needs a look none of the existing four blocks give it, add a new
  fenced-div class and a matching selector — don't reach for `<div>`/`<span>`/
  `<p class="...">`.

## Layout

```
*.md                 every page, flat — root pages, the 11 catalogue pages and
                     the 6 biographies, each named for its WordPress slug
assets/              images from the export
styles.css           Twenty Sixteen layout + Customizer overrides
header.html/footer.html   masthead and colophon partials
head.html            <head> include
```

**Keep pages flat.** `rmarkdown::render_site()` only renders the root
directory; a page moved into a sub-folder gets copied to `_site` as raw
Markdown. New pages go in the root and are linked as `slug.html`.

## Link conventions

- Page → page: `slug.html` (no directory prefix, no `../`)
- Page → image: `assets/x.jpg`

Any non-page file added to the root needs an entry in `_site.yml`'s `exclude:`,
or `render_site()` will copy it into `_site`.

## Page markup patterns

```
::: hero
Eyebrow label

# Page Title

Optional lede line (ISBN, date, etc.)
:::
```
Eyebrow and lede are plain paragraphs — no class attribute. styles.css targets
them positionally (`.hero > p:first-child`, `.hero h1 + p`).

```
::: catalogue

::: item
### [Title](slug.html)

By-line

One-sentence description.
:::

(repeat ::: item blocks)

:::
```
Same idea: the "by" line and description are plain paragraphs, styled via
`.item h3 + p` / `.item h3 + p + p`.

```
::: figure
![Alt text](assets/photo.jpg)

Caption text
:::
```
Only for photos that need a real caption. A plain `![Title](assets/x.jpg)`
(no div) is a bare cover image — `md_extensions: -implicit_figures` in
_site.yml stops Pandoc auto-wrapping it in `<figure>`.

Image sizing goes through a class, not an inline style:
`![Alt](assets/x.jpg){.portrait}`.

## Build

```sh
Rscript build.R     # equivalently: rmarkdown::render_site()
```

## After changing pages

Check that every internal `href`/`src` resolves to a file that exists, and that
`:::` fences balance in each `.md` (an unclosed fenced div silently swallows
the rest of the page into one `<div>`).
