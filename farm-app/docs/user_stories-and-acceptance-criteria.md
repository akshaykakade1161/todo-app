# User Stories & Acceptance Criteria

| # | Role | Goal | Acceptance Criteria |
|---|------|------|---------------------|
| 1 | Farmer | Log in with email | *Login page validates email, password, and shows error on failure.* |
| 2 | Farmer | Create irrigation plan | *System returns a plan based on crop & area; plan can be saved.* |
| 3 | User | Read articles | *Article page shows title, content, tags, and related suggestions.* |
| 4 | Administrator | Create scheme | *Admin can add a scheme with eligibility rules and schema validation.* |
| 5 | Farmer | View subsidy eligibility | *User sees a list of schemes where `eligible` is true for their state.* |
| 6 | System | Session persistence | *JWT token refresh works; session times out after 30 mins with inactivity.* |
| 7 | Presenter | Responsive layout | *All pages render correctly on mobile (375px width) and desktop.* |
| 8 | Admin | Manage users | *Admin can suspend/activate users, view audit logs.* |
| 9 | User | Receive notification | *Water usage or new scheme triggers an email/SMS notification.* |
|10 | System | Scalability | *Application should handle 1000 concurrent login requests with response <200ms.* |

---
