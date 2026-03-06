# API Contracts

## 1. Auth
```
POST /api/auth/login
{ email, password }

{ token, user: { id, email, role } }
```

## 2. Articles
```
GET /api/articles
{ page, perPage }
```
```
GET /api/articles/:id
{ article }
```
```
POST /api/articles
{ title, body, tags }

{ article }
```

## 3. Irrigation Plans
```
POST /api/irrigation/plans
{ crop, area }

{ plan }
```
```
GET /api/irrigation/plans
{ userId }
```

## 4. Schemes
```
GET /api/schemes?state=Punjab

{ schemes: [] }
```

All endpoints require `Authorization: Bearer <JWT>`.
---
