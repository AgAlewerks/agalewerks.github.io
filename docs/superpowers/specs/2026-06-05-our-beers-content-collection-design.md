# Our Beers — Content Collection Migration Design

**Date:** 2026-06-05

## Goal

Restructure `our-beers` to work exactly like `blog`: a content collection drives both the index page and individual detail pages. The manually-maintained hardcoded index and static `.astro` detail pages are replaced by dynamic Astro routes powered by `getCollection('beers')`.

---

## Content Collection

**Location:** `src/content/beers/`

**Registration:** Add a `beers` collection to `src/content.config.ts` using the same glob loader and Zod schema as `blog`:

```ts
const beers = defineCollection({
  loader: glob({ base: './src/content/beers', pattern: '**/*.{md,mdx}' }),
  schema: z.object({
    title: z.string(),
    description: z.string(),
    pubDate: z.coerce.date(),
    updatedDate: z.coerce.date().optional(),
    heroImage: z.string().optional(),
    tags: z.array(z.string()).default([]),
    categories: z.array(z.string()).default([]),
  }),
});
```

Export: `export const collections = { blog, beers };`

---

## Content Files

Convert existing beer pages to collection files (all filenames lowercase):

| Source | Destination | Notes |
|---|---|---|
| `src/pages/our-beers/strisselspalt-pilsner.astro` | `src/content/beers/strisselspalt-pilsner.mdx` | Inline HTML (`<figure>`, `<figcaption>`) preserved; frontmatter added |
| `src/pages/our-beers/thistle-dew.astro` | `src/content/beers/thistle-dew.mdx` | Same — multiple figures/captions preserved |
| `src/pages/our-beers/Licht-Em-Up.md` | `src/content/beers/licht-em-up.md` | Already has valid frontmatter; just moved and renamed lowercase |

Delete after migration: `strisselspalt-pilsner.astro`, `thistle-dew.astro`, `Licht-Em-Up.md` from `src/pages/our-beers/`.

---

## Layout

**`src/layouts/BeerDetail.astro`** — copy of `BlogPost.astro` with two changes:
1. Type annotation: `CollectionEntry<'beers'>['data']` instead of `CollectionEntry<'blog'>['data']`
2. Back-link: "← Back to our beers" pointing to `${base}our-beers/`

---

## Routes

**`src/pages/our-beers/[...slug].astro`**
- `getStaticPaths`: maps `getCollection('beers')` entries to `{ params: { slug: post.id }, props: post }`
- Renders each entry using `BeerDetail.astro` via `render(post)`

**`src/pages/our-beers/index.astro`**
- Queries `getCollection('beers')`, sorts by `pubDate` descending
- Generates excerpt from `post.body` using the same `stripMarkdown` / `createExcerpt` helpers as the blog index
- Renders the same two-column card grid as the blog index (first card spans full width)
- Links: `${base}our-beers/${post.id}/`

---

## Files Changed

| Action | File |
|---|---|
| Modified | `src/content.config.ts` |
| Created | `src/layouts/BeerDetail.astro` |
| Created | `src/pages/our-beers/[...slug].astro` |
| Modified | `src/pages/our-beers/index.astro` |
| Created | `src/content/beers/strisselspalt-pilsner.mdx` |
| Created | `src/content/beers/thistle-dew.mdx` |
| Created | `src/content/beers/licht-em-up.md` |
| Deleted | `src/pages/our-beers/strisselspalt-pilsner.astro` |
| Deleted | `src/pages/our-beers/thistle-dew.astro` |
| Deleted | `src/pages/our-beers/Licht-Em-Up.md` |
