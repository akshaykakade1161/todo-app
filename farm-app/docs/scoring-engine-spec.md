# Scoring Engine Spec

## 1. Purpose
- Compute a **Water Savings Score** based on irrigation plan vs. baseline usage.
- Compute **Eligibility Score** for each scheme based on user profile.

## 2. Data Inputs
| Input | Description |
|-------|-------------|
| Plan | Water required (L) |
| Baseline | Historical water usage per acre |
| Scheme | Eligibility rules JSON |
| User | State, area, crop |

## 3. Calculations
```
WaterSavingsScore = max(0, (Baseline - Plan) / Baseline * 100)
EligibilityScore = parseEligibilityRules(Scheme.eligibility, User)
```

## 4. Storage
- Scores cached in Redis with 5 min TTL.
- Persisted in `scores` table with `userId`, `planId`, `schemeId`.

---
