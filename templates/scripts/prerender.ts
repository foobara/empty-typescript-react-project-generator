import { writeFileSync, mkdirSync } from 'fs'
import { resolve, dirname } from 'path'
import { fileURLToPath } from 'url'
import { preview } from 'vite'
import puppeteer from 'puppeteer'
import { getRoutePaths } from './routes.ts'

const __filename = fileURLToPath(import.meta.url)
const __dirname = dirname(__filename)
const projectRoot = resolve(__dirname, '..')
const distDir = resolve(projectRoot, 'dist')

const routes = getRoutePaths()

const server = await preview({ root: projectRoot })
const serverUrl = server.resolvedUrls!.local[0]

const browser = await puppeteer.launch({
  args: ['--no-sandbox', '--disable-setuid-sandbox'],
})

for (const route of routes) {
  const page = await browser.newPage()

  await page.evaluateOnNewDocument(() => {
    document.addEventListener('prerender-ready', () => {
      ;(window as Window & { __prerenderReady?: boolean }).__prerenderReady = true
    })
  })

  await page.goto(new URL(route, serverUrl).href, { waitUntil: 'networkidle0' })
  await page.waitForFunction('window.__prerenderReady === true')

  const html = await page.content()
  const outputPath = route === '/' ? 'index.html' : `${route.replace(/^\//, '')}.html`
  const outputFile = resolve(distDir, outputPath)

  mkdirSync(dirname(outputFile), { recursive: true })
  writeFileSync(outputFile, html)
  console.log(`Pre-rendered ${route} -> dist/${outputPath}`)

  await page.close()
}

await browser.close()
server.httpServer.close()
process.exit(0)
