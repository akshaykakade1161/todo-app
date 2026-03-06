# Information Architecture

## 1. Top‑Level Navigation
- **Header**: Logo, search bar, user menu.
- **Sidebar** (mobile): Articles, Irrigation Planner, Machinery, Schemes, Forum, Dashboard.

## 2. Content Hierarchy
```
Home
├─ Knowledge Hub (Articles, Videos, Quizzes)
├─ Irrigation Planner (Input → Plan Output)
├─ Machinery Guide (Categories → Equipment Details)
├─ Schemes & Subsidies (By State → Details)
├─ Community (Forum, Posts, Comments)
└─ Dashboard (Personal stats, Alerts, Settings)
```

## 3. Search Index
- `@fulltext` index on article titles and bodies.
- Faceted search by tags, crop type, and sector.

## 4. URL Structure
```
/knowledge/article/:id
/irrigation/plans
/machinery/:category/:id
/schemes/:state
/forum/topic/:id
/dashboard
```

## 5. Accessibility Mapping
- All interactive elements keyboard reachable.
- WCAG 2.1 AA color contrast.

---
