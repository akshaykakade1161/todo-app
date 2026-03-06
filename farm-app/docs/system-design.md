# System Design & Scalability

## 1. Data Model Snapshot
```
users          (id PK, email, role, profile)

equipment      (id PK, name, type, maintenance_interval, owner_id FK)

irrigation_plan (id PK, name, crop, water_requirement, user_id FK)

schemes         (id PK, name, eligibility, eligibility_check, link)

posts           (id PK, author_id FK, title, body, tags, timestamp)
comments        (id PK, post_id FK, author_id FK, body, timestamp)
```
> Prisma schema can be found in `backend/prisma/schema.prisma`.

## 2. API Endpoints (Contract Overview)
| Route | Method | Purpose |
|-------|--------|---------|
| `/api/auth/*` | `POST/GET` | Login, logout, token refresh |
| `/api/irrigation/plans` | `GET/POST/PUT/DELETE` | CRUD for irrigation plan |
| `/api/equipment` | `GET/POST` | Equipment list & recommendations |
| `/api/schemes` | `GET` | Public list; filtered by state |
| `/api/posts` | `GET/POST` | Blog and Q&amp;A content |
| `/api/comments` | `POST` | Comment on posts |

### 2.1 Use‑Case Flow (Irrigation Planner)
1. **Farmer** logs in → receives JWT.
2. **Farmer** selects crop & area → API calculates water requirement using `irrigation_plan` model.
3. System recommends irrigation method (drip/pivot) and generates `irrigation_plan` record.
4. **Farmer** saves plan → push notification when timer > 8h.

## 3. Reliability & Fault Tolerance
- **Health Checks**: `/healthz` returns PG/Redis status.
- **Circuit Breaker**: BullMQ job workers with back‑off.
- **Redundancy**: PostgreSQL read replicas, Redis failover.
- **Backups**: Daily logical backups to S3 via pg_dump.

## 4. Scaling Strategy
- **Horizontal scaling**: Stateless API nodes behind Render load balancer.
- **Caching**: Redis with LRU, PKI for user sessions.
- **Database sharding** (future): Partition by user id for very large farms.

## 5. Observability
- **Logs**: Winston + Loki.
- **Metrics**: Prometheus scraping Node stats, Express latency.
- **Tracing**: OpenTelemetry collectors.

---

**Design Review**: All edge cases (missing weather data, subscription expiry) are handled in Service layer.
