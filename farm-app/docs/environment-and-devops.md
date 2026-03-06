# Environment & DevOps

## 1. Local Development
- **Prereqs**: Node 18+, Yarn 1.x, PostgreSQL locally.
- **Commands**:
  - `yarn install` (root)
  - `yarn dev:frontend` , `yarn dev:backend`
  - `yarn prisma:migrate`

## 2. CI/CD
- **GitHub Actions** runs on every push to `main`.
- Lint, test, build, and deploy to Render (backend) and Vercel (frontend).
- Secrets stored in GitHub.

## 3. Cloud Infrastructure
- Render: PostgreSQL, Node server, cron jobs.
- Vercel: Next.js static build.
- Cloudflare Workers as API gateway (basic rate limiting).

## 4. Monitoring
- Sentry for error tracking.
- Grafana dashboards from Prometheus exporters.

---
