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

## Build

```sh
Rscript build.R     # equivalently: rmarkdown::render_site()
```

## After changing pages

Check that every internal `href`/`src` resolves to a file that exists, and that
`<div>` tags balance in each `.md` (the `hero` block is hand-written HTML).
