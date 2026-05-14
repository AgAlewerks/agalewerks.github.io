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
├── astro.config.mjs        # site + base URL for GitHub Pages
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
└── .github/workflows/deploy.yml    # GitHub Pages auto-deploy
```

## Deploying to GitHub Pages

The `.github/workflows/deploy.yml` workflow auto-builds and publishes on every push to `main`. Three things to do once:

1. **Create the repo on GitHub** (let's say `https://github.com/<you>/agalewerks`).
2. **Edit `astro.config.mjs`** so `site` and `base` match your repo:
   ```js
   site: 'https://<you>.github.io',
   base: '/agalewerks/',   // or '/' if this is your user.github.io repo
   ```
3. **In the repo on GitHub:** Settings → Pages → "Build and deployment" → **Source: GitHub Actions**.

Push to `main` and the workflow will publish to `https://<you>.github.io/agalewerks/`.

### Initial git setup

```bash
cd agalewerks-astro
git init
git add .
git commit -m "Initial commit — ported from WordPress"
git branch -M main
git remote add origin https://github.com/<you>/agalewerks.git
git push -u origin main
```

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
