// @ts-check
import { defineConfig } from 'astro/config';
import mdx from '@astrojs/mdx';
import sitemap from '@astrojs/sitemap';

// IMPORTANT: When you deploy to GitHub Pages, update `site` and `base` to match your repo.
// For a project page at https://<user>.github.io/<repo>/  use:
//   site: 'https://<user>.github.io',
//   base: '/<repo>/',
// For a user/organization page (https://<user>.github.io/) just set:
//   site: 'https://<user>.github.io',
//   base: '/',
export default defineConfig({
  site: 'https://example.github.io',
  base: '/agalewerks/',
  integrations: [mdx(), sitemap()],
});
