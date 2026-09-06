# Quarto Mobile Categories Extension

[Quarto listing category filters](https://quarto.org/docs/websites/website-listings.html#categories) live in the margin sidebar, which is awkward on small screens. This extension mirrors those categories as an inline dropdown you can place in the page body. Choosing an option calls Quarto's existing `quartoListingCategory` handler so filtering stays in sync.

On desktop the dropdown is hidden and the margin UI remains. On mobile the dropdown is shown and the margin category list is hidden when the embed is present.

## Prerequisites

Requires Quarto `>= 1.4.0` and a page with listing `categories: true` (so Quarto emits `.quarto-listing-category` in the margin).

## Install

```bash
quarto add beck-chan/quarto-mobile-categories
```

## Usage

Add the filter to the YAML frontmatter on a `.qmd` file or your top-level `_quarto.yml`:

```yaml
filters:
  - mobile-categories
```

### Example

Enable listing categories, then embed the dropdown where it should appear on mobile:

```markdown
---
listing:
  - id: posts
    contents: "posts"
    categories: true
filters:
  - mobile-categories
---

::: {.mobile-categories}
:::
```

Extra classes on the div are preserved if you want to style the embed in your theme:

```markdown
::: {.mobile-categories .my-filter-styles}
:::
```

## Reference

| Class | Notes |
|---|---|
| `.mobile-categories` | Required fenced-div class that becomes the dropdown |

The extension ships structural CSS only (layout, mobile/desktop visibility). Colors, fonts, and borders are left to your project theme.

## Support

> If you liked this extension and found it useful, please consider donating via Ko-fi: [https://ko-fi.com/beckchan](https://ko-fi.com/beckchan)
