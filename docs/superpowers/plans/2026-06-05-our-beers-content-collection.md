# Our Beers Content Collection Migration — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the hardcoded `our-beers` pages with a content collection that drives a dynamic index and detail routes, mirroring the `blog` section.

**Architecture:** Add a `beers` Astro content collection sourced from `src/content/beers/`. Convert the three existing beer pages to `.md`/`.mdx` collection files. A new `BeerDetail.astro` layout and two new route files (`[...slug].astro` and a rewritten `index.astro`) replace the static `.astro` pages.

**Tech Stack:** Astro 6, `@astrojs/mdx`, Tailwind CSS v4, `astro:content` (`getCollection`, `render`)

---

## File Map

| Action | Path | Responsibility |
|---|---|---|
| Modify | `src/content.config.ts` | Register `beers` collection |
| Create | `src/content/beers/licht-em-up.md` | Licht 'Em Up beer entry |
| Create | `src/content/beers/strisselspalt-pilsner.mdx` | Strisselspalt Pilsner beer entry |
| Create | `src/content/beers/thistle-dew.mdx` | Thistle Dew beer entry |
| Create | `src/layouts/BeerDetail.astro` | Detail page layout for a single beer |
| Create | `src/pages/our-beers/[...slug].astro` | Dynamic detail route |
| Modify | `src/pages/our-beers/index.astro` | Dynamic index from collection |
| Delete | `src/pages/our-beers/strisselspalt-pilsner.astro` | Replaced by collection entry |
| Delete | `src/pages/our-beers/thistle-dew.astro` | Replaced by collection entry |
| Delete | `src/pages/our-beers/Licht-Em-Up.md` | Replaced by collection entry |

---

### Task 1: Register `beers` collection

**Files:**
- Modify: `src/content.config.ts`

- [ ] **Step 1: Add the `beers` collection definition**

Replace the entire file content:

```ts
import { glob } from 'astro/loaders';
import { defineCollection, z } from 'astro:content';

const blog = defineCollection({
  loader: glob({ base: './src/content/blog', pattern: '**/*.{md,mdx}' }),
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

export const collections = { blog, beers };
```

- [ ] **Step 2: Commit**

```bash
git add src/content.config.ts
git commit -m "feat: register beers content collection"
```

---

### Task 2: Create beer content files

**Files:**
- Create: `src/content/beers/licht-em-up.md`
- Create: `src/content/beers/strisselspalt-pilsner.mdx`
- Create: `src/content/beers/thistle-dew.mdx`

- [ ] **Step 1: Create `src/content/beers/licht-em-up.md`**

This is the existing `src/pages/our-beers/Licht-Em-Up.md` content moved into the collection. File is already valid — just copy the content verbatim:

```markdown
---
title: "Licht 'Em Up"
description: "A sour, smoked, lower-gravity historical central European wheat beer. Complex yet refreshing character due to high attenuation and carbonation, along with low bitterness and moderate sourness."
pubDate: 2026-06-05
categories: ["brewing"]
tags: [Historical]
---

<a href="https://www.vectorbrewing.com/beer-1" target="_blank">Vector Brewing</a> produced a very delightful <a href="https://www.bjcp.org/style/2021/27/27A/historical-beer-lichtenhainer/" target="_blank">Lichtenhainer</a> back in 2021 and we were smitten.
```

- [ ] **Step 2: Create `src/content/beers/strisselspalt-pilsner.mdx`**

The content comes from `src/pages/our-beers/strisselspalt-pilsner.astro` (strip the `import Page` and `<Page>` wrapper; keep only inner content). Date is inferred from the recipe screenshot filename (`Screen-Shot-2019-01-01-at-7.30.36-PM.png`):

```mdx
---
title: "Strisselspalt Pilsner"
description: "Our hoppy pilsner brewed for Bluebonnet Brew-off 2019, inspired by a Beckham Street Hoppy Pilsner at Wort Hog Brewing."
pubDate: 2019-01-01
tags: []
categories: ["brewing"]
---

Our new for Bluebonnet Brew-off 2019 pilsner was inspired by a beverage that we sampled
while vacationing in Virginia. A former Dallas area brewer had taken up shop at
<a href="http://www.whbrew.com/">Wort Hog Brewing</a> so we ducked in to see what Jeremy
had gotten himself into.

We sampled all of the current wares and I was smitten by the
<a href="http://www.whbrew.com/beer-menu.html">BECKHAM STREET — HOPPY PILSNER</a>.
The "hoppy" bit was supplied using a French hop —
<a href="https://beerandbrewing.com/dictionary/SNdWvdNSAt/">Strisselspalt</a>. The beer
had a wonderful aroma, a crisp hop bite, plenty of fizzy bubbles, and a quenching dry
finish.

We entered a pilsner into Bluebonnet Brew-off last year, but it was a bit rushed and it
didn't do as well as we had hoped. This libation was sure to become our secret weapon in
2019.

<figure>
  <img
    src="/images/Screen-Shot-2019-01-01-at-7.30.36-PM.png"
    alt="Strisselspalt Pilsner recipe sheet"
  />
</figure>
```

- [ ] **Step 3: Create `src/content/beers/thistle-dew.mdx`**

Content from `src/pages/our-beers/thistle-dew.astro` (same stripping). Date from recipe screenshot filename (`Screen-Shot-2018-12-28-at-9.19.46-PM.png`):

```mdx
---
title: "Thistle Dew"
description: "An 80 Shilling Scottish Ale born out of Cobra Brewing's Hopped Challenge, earning a stein at Bluebonnet Brew-off in 2017 and 2018."
pubDate: 2018-12-28
tags: []
categories: ["brewing"]
---

This beer was born out of a "Hopped Challenge" sponsored by Cobra Brewing in Lewisville,
Texas. We were handed a brown sack full of honey malt, about a pound and a half, along
with a jar of dark malt extract and told that we had to use the ingredients somewhere in
our brewing process. Most of the competitors opted to use the malt extract for their
yeast starter and use very little of the honey malt.

Silvia embraced the ingredients in the spirit of Chopped or Iron Chef. She went looking
for recipes that used significant amounts of honey malt and settled on an 80 Shilling
Scottish Ale. Once we settled on a Scottish ale, Silvia did some more research for a
name. After learning that the national flower of Scotland is a
<a href="https://www.visitscotland.com/about/uniquely-scottish/thistle/">thistle</a>
we knew that we must work that into the beer name and Thistle Dew was tagged.

Since we were not interested in continuing to use dark liquid malt extract going forward,
I reworked the recipe for a 5.5-gallon batch replace the extract with the constituent
malts and settled on this all grain recipe.

<figure>
  <img
    src="/images/Screen-Shot-2018-12-28-at-9.19.46-PM.png"
    alt="Thistle Dew recipe sheet"
  />
</figure>

<figure>
  <img
    src="/images/bluebonnet_2017_stein_scottish_export-e1490906948393.jpg"
    alt="Stein for Thistle Dew"
  />
  <figcaption><em>Stein Winner for Scottish Ale — Our Scottish Export "Thistle Dew"</em></figcaption>
</figure>

<figure>
  <img
    src="/images/Bluebonnet-2018-2.jpg"
    alt="Bluebonnet 2018"
  />
  <figcaption><em>Bluebonnet 2018, with Brad Sheehan</em></figcaption>
</figure>

This first batch from this recipe was entered in the
<a href="http://bbbrewoff.com/bluebonnetbrewoff/">Bluebonnet Brew-off</a> in 2017 and
2018, earning us a stein each year. It can be found on
<a href="https://untappd.com/b/ag-alewerks-thistle-dew/1609874">Untappd</a>.
```

- [ ] **Step 4: Commit**

```bash
git add src/content/beers/
git commit -m "feat: add beers content collection files"
```

---

### Task 3: Create `BeerDetail.astro` layout

**Files:**
- Create: `src/layouts/BeerDetail.astro`

- [ ] **Step 1: Create the layout**

This is `BlogPost.astro` with `CollectionEntry<'beers'>` and a "Our Beers" back-link. Create `src/layouts/BeerDetail.astro`:

```astro
---
import type { CollectionEntry } from 'astro:content';
import BaseHead from '../components/BaseHead.astro';
import Header from '../components/Header.astro';
import Footer from '../components/Footer.astro';
import FormattedDate from '../components/FormattedDate.astro';
const base = import.meta.env.BASE_URL;

type Props = CollectionEntry<'beers'>['data'];

const { title, description, pubDate, updatedDate, heroImage, tags, categories } = Astro.props;
---

<html lang="en">
  <head>
    <BaseHead title={title} description={description} image={heroImage} />
  </head>
  <body>
    <Header />
    <main>
      <article>
        {
          heroImage && (
            <div class="w-full max-w-5xl mx-auto px-4 mt-8">
              <img
                src={heroImage}
                alt=""
                width="1020"
                height="510"
                class="block mx-auto rounded-xl shadow-lg w-full h-auto object-cover"
              />
            </div>
          )
        }

        <div class="max-w-3xl mx-auto px-4 py-8">
          <header class="text-center mb-10">
            <div class="text-muted text-sm">
              <FormattedDate date={pubDate} />
              {
                updatedDate && (
                  <div class="italic">
                    Last updated on <FormattedDate date={updatedDate} />
                  </div>
                )
              }
            </div>

            <h1 class="mt-3 mb-4 text-4xl md:text-5xl font-bold text-ink leading-tight">
              {title}
            </h1>

            {
              ((categories && categories.length > 0) || (tags && tags.length > 0)) && (
                <div class="flex flex-wrap justify-center gap-2 text-sm text-muted">
                  {categories.map((c) => (
                    <span class="px-2 py-0.5 rounded bg-ale-cream text-ale-dark">#{c}</span>
                  ))}
                  {tags.map((t) => (
                    <span class="px-2 py-0.5 rounded bg-muted-light text-muted-dark">#{t}</span>
                  ))}
                </div>
              )
            }

            <div class="mt-6 text-left">
              <a href={`${base}our-beers/`} class="text-ale-amber hover:text-ale-dark no-underline">&larr; Back to our beers</a>
            </div>
            <hr class="mt-4 border-muted-light" />
          </header>

          <div class="prose prose-stone max-w-none prose-img:rounded-lg prose-img:shadow-md prose-a:text-ale-amber hover:prose-a:text-ale-dark">
            <slot />
          </div>
        </div>
      </article>
    </main>
    <Footer />
  </body>
</html>
```

- [ ] **Step 2: Commit**

```bash
git add src/layouts/BeerDetail.astro
git commit -m "feat: add BeerDetail layout"
```

---

### Task 4: Create `[...slug].astro` detail route

**Files:**
- Create: `src/pages/our-beers/[...slug].astro`

- [ ] **Step 1: Create the dynamic detail route**

Create `src/pages/our-beers/[...slug].astro`:

```astro
---
import { type CollectionEntry, getCollection, render } from 'astro:content';
import BeerDetail from '../../layouts/BeerDetail.astro';

export async function getStaticPaths() {
  const beers = await getCollection('beers');
  return beers.map((beer) => ({
    params: { slug: beer.id },
    props: beer,
  }));
}

type Props = CollectionEntry<'beers'>;

const beer = Astro.props;
const { Content } = await render(beer);
---

<BeerDetail {...beer.data}>
  <Content />
</BeerDetail>
```

- [ ] **Step 2: Commit**

```bash
git add src/pages/our-beers/[...slug].astro
git commit -m "feat: add our-beers dynamic detail route"
```

---

### Task 5: Rewrite `our-beers` index page

**Files:**
- Modify: `src/pages/our-beers/index.astro`

- [ ] **Step 1: Replace the hardcoded index with a collection-driven one**

Replace the entire contents of `src/pages/our-beers/index.astro`:

```astro
---
import BaseHead from "../../components/BaseHead.astro";
import Header from "../../components/Header.astro";
import Footer from "../../components/Footer.astro";
import { SITE_TITLE, SITE_DESCRIPTION } from "../../consts";
import { getCollection } from "astro:content";
import FormattedDate from "../../components/FormattedDate.astro";

const beers = (await getCollection("beers")).sort(
  (a, b) => b.data.pubDate.valueOf() - a.data.pubDate.valueOf(),
);

const stripMarkdown = (content: string): string =>
  content
    .replace(/```[\s\S]*?```/g, " ")
    .replace(/`[^`]*`/g, " ")
    .replace(/!\[[^\]]*\]\([^)]*\)/g, " ")
    .replace(/\[([^\]]*)\]\([^)]*\)/g, "$1")
    .replace(/<[^>]+>/g, " ")
    .replace(/(^|\s)[#>*_~\-]+/g, " ")
    .replace(/\s+/g, " ")
    .trim();

const createExcerpt = (content: string, maxLength = 180): string => {
  const plainText = stripMarkdown(content);
  if (plainText.length <= maxLength) {
    return plainText;
  }
  const clipped = plainText.slice(0, maxLength);
  const lastSpace = clipped.lastIndexOf(" ");
  return `${(lastSpace > 0 ? clipped.slice(0, lastSpace) : clipped).trim()}...`;
};

const beersWithPreview = beers.map((beer) => {
  const body = typeof beer.body === "string" ? beer.body : "";
  return {
    ...beer,
    excerpt: createExcerpt(body),
  };
});

const base = import.meta.env.BASE_URL;
---

<!doctype html>
<html lang="en">
  <head>
    <BaseHead title={`Our Beers — ${SITE_TITLE}`} description={SITE_DESCRIPTION} />
  </head>
  <body>
    <Header />
    <main class="max-w-5xl mx-auto px-4 py-12">
      <section>
        <h1 class="text-4xl md:text-5xl font-bold text-ink mb-8 text-center">Our Beers</h1>
        <ul class="grid grid-cols-1 md:grid-cols-2 gap-6 list-none p-0 m-0">
          {
            beersWithPreview.map((beer, idx) => (
              <li class:list={[idx === 0 ? "md:col-span-2 text-center" : ""]}>
                <a
                  href={`${base}our-beers/${beer.id}/`}
                  class="block p-5 rounded-lg no-underline transition-colors hover:bg-muted-light/60 group"
                >
                  <h4
                    class:list={[
                      "m-0 font-bold text-ink leading-tight group-hover:text-ale-amber transition-colors",
                      idx === 0 ? "text-3xl md:text-4xl" : "text-xl",
                    ]}
                  >
                    {beer.data.title}
                  </h4>
                  <p class="text-sm text-muted my-1.5">
                    <FormattedDate date={beer.data.pubDate} />
                  </p>
                  <p class="text-muted-dark line-clamp-2 m-0">{beer.data.description}</p>
                  <p class="text-sm text-muted-dark/80 line-clamp-3 mt-2 mb-0">{beer.excerpt}</p>
                </a>
              </li>
            ))
          }
        </ul>
      </section>
    </main>
    <Footer />
  </body>
</html>
```

- [ ] **Step 2: Commit**

```bash
git add src/pages/our-beers/index.astro
git commit -m "feat: rewrite our-beers index to use beers collection"
```

---

### Task 6: Delete old static pages and verify

**Files:**
- Delete: `src/pages/our-beers/strisselspalt-pilsner.astro`
- Delete: `src/pages/our-beers/thistle-dew.astro`
- Delete: `src/pages/our-beers/Licht-Em-Up.md`

- [ ] **Step 1: Delete the replaced files**

```bash
rm src/pages/our-beers/strisselspalt-pilsner.astro
rm src/pages/our-beers/thistle-dew.astro
rm src/pages/our-beers/Licht-Em-Up.md
```

- [ ] **Step 2: Run a production build to verify no errors**

```bash
npm run build
```

Expected: build completes with no errors. You should see routes for `/our-beers/`, `/our-beers/strisselspalt-pilsner/`, `/our-beers/thistle-dew/`, and `/our-beers/licht-em-up/` in the output.

- [ ] **Step 3: Spot-check with the dev server**

```bash
npm run dev
```

Visit in browser:
- `http://localhost:4321/our-beers/` — should show three beer cards sorted by date (Licht 'Em Up first, then Strisselspalt Pilsner, then Thistle Dew)
- `http://localhost:4321/our-beers/thistle-dew/` — should show the Thistle Dew detail page with all three figures and a "← Back to our beers" link
- `http://localhost:4321/our-beers/strisselspalt-pilsner/` — should show the Strisselspalt Pilsner detail page with the recipe figure
- `http://localhost:4321/our-beers/licht-em-up/` — should show the Licht 'Em Up detail page

- [ ] **Step 4: Commit**

```bash
git add -A
git commit -m "feat: remove old static our-beers pages"
```
