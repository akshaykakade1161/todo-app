# Monorepo Structure

```
├─ frontend/      # Next.js app (app router)
│  ├─ app/        # Pages & layouts
│  ├─ components/ # UI primitives
│  ├─ lib/        # API clients & auth helpers
│  └─ styles/     # Tailwind config
├─ backend/        # Express API
│  ├─ src/
│  │  ├─ routes/
│  │  ├─ services/
│  │  └─ prisma/
│  └─ Dockerfile
├─ packages/      # Shared utilities & types
│  └─ shared/     # TypeScript shared library
├─ docs/          # Documentation
└─ scripts/       # CI scripts and utilities
```

- Uses Yarn Workspaces.
- Pull‑request conventions: one feature per branch; monorepo CI runs linting for all packages.
- See `package.json` at repo root for workspace config.
---
