# System Architecture

## 1. Overview
KrushiAbhiyanta is a full‑stack SaaS application with a modern web stack:
- **Front‑end**: Next.js (React) with Tailwind CSS.
- **API layer**: Node.js with Express / TypeScript.
- **Database**: PostgreSQL (primary) + Redis for cache.
- **Auth**: next-auth with JWT & OAuth support.
- **Deployment**: Front‑end on Vercel, Back‑end & databases on Render.

## 2. Layered Architecture
```
+-------------------+            +----------------------+          +-------------------+
|  Client Browsers  | <-------> |  Front‑End / APIs   | <-----> |  Database Layer   |
+-------------------+            +----------------------+          +-------------------+
                        |                                     |
                        v                                     v
                 +----------------------+          +---------------------+
                 |  Image / Asset Store |          | External Services  |
                 +----------------------+          +---------------------+
```
### 2.1 Presentation Layer
- Uses Next.js’ hybrid rendering: SSR for SEO, CSR for dynamic pages.
- Tailwind CSS with Headless UI for consistent UI components.
- Simple API calls via Axios/React‑Query.

### 2.2 Application Layer
- Express routes with TypeScript, organized by resource.
- Middle‑ware: authentication, rate‑limiting, error handling.
- Service‑layer separation: Controllers → Services → Repositories.
- Feature‑flag toggles via LaunchDarkly / feature flag JSON.

### 2.3 Persistence Layer
- PostgreSQL with Prisma ORM for type safety.
- Structured tables: users, irrigation_plans, machinery, schemes, posts, comments, etc.
- Stored procedures for complex analytics.
- Redis for session store, read‑through cache, rate limits.

### 2.4 Integration Layer
- External APIs for:
  - Weather forecast (OpenWeatherMap).
  - Government subsidy API.
  - SMS/email notifications (Twilio/SendGrid).
- Background jobs via BullMQ on Redis.
- Sentry for error monitoring.
- Prometheus + Grafana for metrics.

## 3. Deployment & CI/CD
- GitHub Actions: lint, unit tests, Docker image build.
- Vercel for Next.js – auto‑preview deployments.
- Render for Node.js & PostgreSQL – zero‑downtime deploys.
- Cloudflare Workers for CDN and API gateway security.
- Artifact signing and secret management via GitHub Secrets.

## 4. Security Considerations
- OWASP Top‑10 mitigations: CSRF tokens, XSS sanitization, CSP headers.
- Data encryption at rest (PGpass) and in transit (TLS 1.3).
- RBAC: `admin`, `agronomist`, `farmer` roles.
- Audit logs for critical actions.

---

> **Next Steps**: Build out conditional diagrams for data flow and user journeys in the next iteration.
