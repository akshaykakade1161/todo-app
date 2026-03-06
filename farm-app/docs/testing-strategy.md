# Testing Strategy

## 1. Unit Tests
- Jest + ts-jest for backend services.
- Use `mockingoose` for Prisma models.
- Target 80% coverage.

## 2. Integration Tests
- Supertest for API endpoints.
- Mock external APIs (weather, schemes) using `nock`.

## 3. End‑to‑End Tests
- Playwright that simulates user buying a plan.
- Tests run on GitHub Actions (headless Chromium).

## 4. Performance Tests
- k6 script to simulate 2000 concurrent login requests.
- Target latency <200ms for 95th percentile.

## 5. Security Tests
- Snyk and safety checks in CI.
- Manual OWASP Top‑10 reviews.

---
