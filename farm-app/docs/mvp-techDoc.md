# MVP Technical Documentation

## 1. MVP Scope
| Feature | Description | Priority |
|---------|-------------|----------|
| **User Accounts** | Sign up / login with email + 2FA | ★★★ |
| **Knowledge Articles** | CRUD for agronomists | ★★ |
| **Irrigation Planner** | Predict water requirement & recommend system | ★★★ |
| **Scheme Finder** | View eligible govt subsidies | ★ |
| **Dashboard** | Basic usage stats & notifications | ★ |
| **SEO & Accessibility** | SSR pages, WCAG 2.1 AA compliance | ★ |

## 2. Tech Stack
- **Front‑end**: Next.js 13 (app router), TypeScript, TailwindCSS, shadcn/ui.
- **Back‑end**: Node.js 18, Express, Prisma ORM for PostgreSQL, Redis for cache.
- **Auth**: next-auth with JWT + email oAuth.
- **Database**: PostgreSQL 15, hosted on Render.
- **Cache**: Redis 7.
- **Deployment**: Vercel (frontend), Render (backend), Cloudflare CDN.
- **CI/CD**: GitHub Actions – lint, test, docker build, deploy.
- **Notifications**: SendGrid for email, Twilio for SMS.

## 3. Directory Structure
```
├─ frontend/ (Next.js)
│   ├─ app/          # App router pages
│   ├─ components/    # Reusable UI
│   ├─ lib/          # API clients
│   └─ styles/      # Tailwind config
├─ backend/ (Node.js)
│   ├─ src/
│   │   ├─ routes/     # Express routers
│   │   ├─ services/   # Business logic
│   │   ├─ models/     # Prisma schema
│   │   └─ utils/     # Helpers
│   ├─ prisma/        # Prisma schema and migrations
│   └─ Dockerfile
├─ docs/            # This directory
├─ .github/         # GitHub Actions workflows
└─ README.md
```

## 4. API Design (RESTful)
- **Base URL**: `https://api.krushiabhiyanta.com` (Render domain)
- **Auth Header**: `Authorization: Bearer <jwt>`

### 4.1 Example Endpoints
- `POST /api/auth/login` → `{ email, password }` → Returns JWT.
- `GET /api/irrigation/plans` → Query: `?crop=wheat&area=10` → Returns recommended plan.
- `GET /api/schemes?state=Karnataka` → .

## 5. Database Design Highlights
- `users` table: id, email, role, hashed_password.
- `irrigation_plans`: id, user_id, crop, area, water_req, plan_type, created_at.
- `schemes`: id, name, description, eligibility_rules, link.
- Use foreign keys for integrity.

## 6. Deployment Pipeline
1. **Code merge** → GitHub Actions lint / test.
2. Build Docker image for backend.
3. Deploy to Render (auto‑deploy on merge to main).
4. Frontend gets preview URLs via Vercel.
5. After merge to main, Vercel auto‑deploys production.

## 7. Testing Strategy
- **Unit tests**: Jest + ts-jest for services.
- **Integration tests**: Supertest for API routes.
- **E2E**: Playwright for critical user flows.
- **Performance**: k6 load tests.

## 8. Roadmap
- Q2 2026: MVP Release.
- Q3 2026: Add offline mode & local sync.
- Q4 2026: Mobile app (React Native) & analytics dashboard.

---

*This document is intended for developers and product owners building the first public version of KrushiAbhiyanta.*
