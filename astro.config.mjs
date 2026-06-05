// @ts-check
import { defineConfig } from 'astro/config';
import mdx from '@astrojs/mdx';
import sitemap from '@astrojs/sitemap';
import tailwindcss from '@tailwindcss/vite';
import rehypeExternalLinks from "rehype-external-links";

// Custom domain (agalewerks.com via CNAME) — served from the root, no subpath.
// If you ever switch back to a plain github.io project page, set:
//   site: 'https://<user>.github.io', base: '/<repo>/'
export default defineConfig({
  site: 'https://agalewerks.com',
  base: '/',
  integrations: [mdx(), sitemap()],
  vite: {
    plugins: [tailwindcss()],
  },
  markdown: {
    rehypePlugins: [
      [
        rehypeExternalLinks,
        {
          target: "\_blank",
          rel: ["noopener", "noreferrer", "external"],
        },
      ],
    ],
  },
});
