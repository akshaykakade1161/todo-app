# Database Schema

## 1. Prisma Model
```prisma
model User {
  id          String   @id @default(uuid())
  email       String   @unique
  password    String
  role        Role
  profile     Profile?
  createdAt   DateTime @default(now())
}

model Profile {
  id        String   @id @default(uuid())
  userId    String   @unique
  name      String?
  phone     String?
  state     String?
  farmer    User @relation(fields: [userId], references: [id])
}

enum Role {
  ADMIN
  AGRONOMIST
  FARMER
}

model Article {
  id        String   @id @default(uuid())
  title     String
  body      String
  tags      String[] @default([])
  authorId  String
  author    User @relation(fields: [authorId], references: [id])
  createdAt DateTime @default(now())
}

model IrrigationPlan {
  id            String   @id @default(uuid())
  name          String
  crop          String
  area          Float
  waterReq      Float
  userId        String
  user          User @relation(fields: [userId], references: [id])
  createdAt     DateTime @default(now())
}

model Scheme {
  id          String   @id @default(uuid())
  name        String
  description String
  eligibility String
  state       String
  link        String
}
```