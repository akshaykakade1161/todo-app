# System Architecture

## 1. High‑Level Overview
```
   ┌─────────────┐   ┌───────────────┐   ┌───────────────┐
   │ Next.js App │<==│  Express API  │<==│     Redis     │
   └───────▲─────┘   └───────┬───────┘   └───────┬───────┘
           │                  │                      │
        SSR/CSS (Tailwind)     │                      │
           │                  │                      │
   ┌───────▼─────┐   ┌──────┴───────┐   ┌───────▼───────┐
   │ PostgreSQL  │   │  Sentry / Logs │   │  SendGrid SMS │
   └──────────────┘   └────────────────┘   └────────────────┘
```

## 2. Service Boundaries
- **Auth Service** – Handles login, JWT, password hashing.
- **Content Service** – CRUD for Articles, Videos.
- **Planning Service** – Algorithm for irrigation recommendation.
- **Scheme Service** – Query government API, cache eligibility.
- **Messaging Service** – Email/SMS queue via BullMQ.

## 3. Data Flow Summary
1. User logs in → Auth Service validates credentials.
2. Auth Service issues JWT signed with HS256.
3. Client calls `/api/irrigation/plans` with JWT.
4. Planning Service queries `irrigation_plans` table, uses Redis cache for weather data.
5. Response returned, UI presents form.

---
