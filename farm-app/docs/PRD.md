# Product Requirements Document (PRD)

## 1. Executive Summary

**KrushiAbhiyanta** is a web‑based platform designed to empower farmers with actionable agricultural engineering knowledge, modern irrigation practices, farm machinery guidance, and up‑to‑date government subsidy information. The platform will deliver curated content, interactive tools, and community support while being accessible from any device.

## 2. Target Users
| Segment | Profile | Pain Points |
|---------|---------|-------------|
| Small‑to‑medium scale farmers | 15‑70 years, often ill‑iterate | Lack real‑time guidance on crop & soil health, limited access to govt schemes, high water usage |
| Agricultural extension officers | 27‑55 years, tech‑savvy | Need efficient way to reach a large population with calibrated knowledge |
| New farmers | 20‑35 years | Need fundamentals, inability to process complex science into actionable steps |

## 3. Key Features
1. **Knowledge Library** – Structured articles with images, videos, and quizzes.
2. **Irrigation Planner** – Drag‑&‑drop system for selecting irrigation methods, AI‑driven water‑saving recommendations.
3. **Machinery Guidance** – Equipment tutorials, maintenance trackers, and collision alerts.
4. **Scheme Finder** – Searchable database of state & central subsidies, eligibility checkers.
5. **Community Forum** – Discussion boards with moderation, localized language support.
6. **Personal Dashboard** – Activity history, custom alerts, analytics on water use & yields.

## 4. Success Metrics
- **User Acquisition**: 10k registered users in 12 months.
- **Engagement**: Avg. session > 5 min, > 3 visits per week.
- **Impact**: 20% drop in water usage among active users; 15% increase in subsidy claim rates.

## 5. Competitive Landscape
- **Agfunder, AgroStar**: Supply chain focus.
- **Government portals**: Sparse, language density issue.
- **KrushiAbhiyanta** fills the knowledge gap with a user‑friendly interface and localized content.

## 6. Constraints & Assumptions
- React/Next.js front‑end with SSR for SEO.
- PostgreSQL for relational data; Redis cache for session and real‑time notifications.
- Deployment via Vercel for front‑end, Render for back‑end.
- Content authored by agronomists; modular content management.

## 7. Risks & Mitigations
- **Low literacy**: Provide voice‑over and picture‑rich content.
- **Connectivity**: offline mode via service workers and local SQLite sync.
- **Data privacy**: GDPR compliant, minimum‑viable user data.

---

> *This PRD is a living document. All stakeholders should keep it updated.*