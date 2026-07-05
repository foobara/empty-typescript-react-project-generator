import { writeFileSync } from 'fs'
import { resolve, dirname } from 'path'
import { fileURLToPath } from 'url'
import { SITE_URL, getSitemapPages } from './routes.ts'

const __filename = fileURLToPath(import.meta.url)
const __dirname = dirname(__filename)

const allPages = getSitemapPages()

const sitemap = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${allPages
  .map(
    (page) => `  <url>
    <loc>${SITE_URL}${page.loc}</loc>
    <changefreq>${page.changefreq}</changefreq>
    <priority>${page.priority}</priority>${page.lastmod ? `\n    <lastmod>${page.lastmod}</lastmod>` : ''}
  </url>`,
  )
  .join('\n')}
</urlset>
`

const sitemapPath = resolve(__dirname, '../public/sitemap.xml')
writeFileSync(sitemapPath, sitemap)

console.log(`Generated sitemap with ${allPages.length} URLs`)
