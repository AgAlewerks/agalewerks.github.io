# Ag Alewerks (Astro)

A static rebuild of [agalewerksblog.wordpress.com](https://agalewerksblog.wordpress.com/) on the [official Astro Blog template](https://github.com/withastro/astro/tree/main/examples/blog). All 19 posts from 2016–2020 plus the About, Our Beers, Thistle Dew, Strisselspalt Pilsner, and Reading List pages have been migrated to Markdown / Astro pages.

## Local development

You'll need [Node.js](https://nodejs.org/) 20+ and a package manager (npm, pnpm, or yarn). I'll use `npm` in the examples.

```bash
# 1. Install dependencies (only needs to be done once)
npm install

# 2. Start the dev server at http://localhost:4321/agalewerks/
npm run dev

# 3. Build the static site to ./dist
npm run build

# 4. Preview the production build locally
npm run preview
```

## Project layout

```text
.
├── astro.config.mjs        # site + base URL for Netlify/custom domain
├── package.json
├── public/
│   └── favicon.svg
├── src/
│   ├── components/         # BaseHead, Header, Footer, HeaderLink, FormattedDate
│   ├── consts.ts           # SITE_TITLE, SITE_DESCRIPTION
│   ├── content.config.ts   # blog collection schema (Zod)
│   ├── content/blog/       # 19 migrated posts (.md)
│   ├── layouts/            # BlogPost.astro, Page.astro
│   ├── pages/
│   │   ├── index.astro             # home (intro + recent posts)
│   │   ├── about.astro
│   │   ├── reading-list.astro
│   │   ├── blog/
│   │   │   ├── index.astro         # all posts list
│   │   │   └── [...slug].astro     # individual post pages
│   │   ├── our-beers/
│   │   │   ├── index.astro
│   │   │   ├── thistle-dew.astro
│   │   │   └── strisselspalt-pilsner.astro
│   │   └── rss.xml.js              # RSS feed
│   └── styles/global.css
└── dist/                  # production build output
```

## Deploying

This project is set up for Netlify. Connect the repo, then use these settings:

1. **Build command:** `npm run build`
2. **Publish directory:** `dist`
3. **Environment:** leave the default Node version unless Netlify asks for one explicitly

`astro.config.mjs` already points at the production site and root base path:
   ```js
   site: 'https://agalewerks.com',
   base: '/',
   ```

If you are still seeing a GitHub Pages action named "pages build and deployment" in the GitHub UI, that is a stale workflow/history item from the old setup. It is no longer present in this repository.

## Notes on the migration

- **Content source:** scraped from the public WordPress site (post HTML rendered to Markdown). All 19 posts, dates, categories, and tags preserved.
- **Images:** every `<img>` still points at `agalewerksblog.wordpress.com/wp-content/uploads/...` so they continue to load from WordPress. If/when you take the WordPress site down, run any image-downloader (`wget --mirror` against the uploads folder, or `pnpm dlx download-image`) and update the paths in `src/content/blog/*.md` to point at `public/images/...`.
- **Hero images:** I picked one representative image per post where applicable; you can override by editing the `heroImage` frontmatter.
- **Comments:** WordPress comments are not migrated (the new site is static). If you want comments, you can drop in [Giscus](https://giscus.app/) or [utterances](https://utteranc.es/) — both work great with static Astro sites.
- **Permalinks:** old WordPress URLs were `/YYYY/MM/DD/slug/`. New URLs are `/blog/slug/`. If you want to preserve the old paths, I can add redirect entries (let me know your host's redirect format).

## Customising

- **Site title / description:** `src/consts.ts`
- **Header links and tagline:** `src/components/Header.astro`
- **Colours and fonts:** `src/styles/global.css` (CSS variables at the top)
- **Favicon:** `public/favicon.svg`

## Tech

- [Astro 5](https://astro.build/)
- [@astrojs/mdx](https://docs.astro.build/en/guides/integrations-guide/mdx/) for MDX support if you want it in posts
- [@astrojs/rss](https://docs.astro.build/en/guides/rss/) for the RSS feed
- [@astrojs/sitemap](https://docs.astro.build/en/guides/integrations-guide/sitemap/) for sitemap-index.xml


[![Netlify Status](https://api.netlify.com/api/v1/badges/3430f5c6-459d-49e8-9334-485e0c03bcaa/deploy-status)](https://app.netlify.com/projects/agalewerks/deploys)
