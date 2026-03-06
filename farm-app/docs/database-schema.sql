-- PostgreSQL schema for KrushiAbhiyanta
-- Generated on 2026-03-06

/* ENUM & TYPE DEFINITIONS */
CREATE TYPE user_role AS ENUM ('ADMIN', 'FARMER', 'CUSTOMER', 'ENGINEER');
CREATE TYPE order_status AS ENUM ('PENDING', 'PAID', 'SHIPPED', 'DELIVERED', 'CANCELLED');
CREATE TYPE payment_status AS ENUM ('INITIATED', 'SUCCESS', 'FAILED', 'REFUNDED');
CREATE TYPE scheme_status AS ENUM ('ACTIVE', 'INACTIVE', 'COMPLETED');

/* ================= USERS =================== */
CREATE TABLE users (
    id                BIGSERIAL PRIMARY KEY,
    email             TEXT NOT NULL UNIQUE,
    password_hash     TEXT NOT NULL,
    name              TEXT NOT NULL,
    phone             TEXT,
    address_street    TEXT,
    address_city      TEXT,
    address_state     TEXT,
    address_zip       TEXT,
    role              user_role NOT NULL DEFAULT 'CUSTOMER',
    created_at       TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at       TIMESTAMP WITH TIME ZONE DEFAULT now()
);

/* ----------- CATEGORIES & PRODUCTS ------------- */
CREATE TABLE categories (
    id          BIGSERIAL PRIMARY KEY,
    name        TEXT NOT NULL UNIQUE,
    parent_id   BIGINT REFERENCES categories(id) ON DELETE SET NULL,
    slug        TEXT NOT NULL UNIQUE,
    description TEXT,
    created_at  TIMESTAMP WITH TIME ZONE DEFAULT now()
);

CREATE TABLE products (
    id                BIGSERIAL PRIMARY KEY,
    name              TEXT NOT NULL,
    sku               TEXT NOT NULL UNIQUE,
    description      TEXT,
    short_desc       TEXT,
    price_cents       BIGINT NOT NULL,
    currency_code    CHAR(3) NOT NULL DEFAULT 'USD',
    stock_qty        INT NOT NULL DEFAULT 0,
    on_sale          BOOLEAN DEFAULT false,
    sale_price_cents BIGINT,
    image_url        TEXT,
    category_id      BIGINT REFERENCES categories(id) ON DELETE SET NULL,
    created_at       TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at       TIMESTAMP WITH TIME ZONE DEFAULT now()
);

/* ---------- ORDERS & ITEMS --------------- */
CREATE TABLE orders (
    id              BIGSERIAL PRIMARY KEY,
    user_id         BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    status          order_status NOT NULL DEFAULT 'PENDING',
    shipping_address TEXT NOT NULL,
    total_cents     BIGINT NOT NULL,
    currency_code   CHAR(3) NOT NULL DEFAULT 'USD',
    placed_at        TIMESTAMP WITH TIME ZONE,
    fulfilled_at     TIMESTAMP WITH TIME ZONE,
    cancelled_at    TIMESTAMP WITH TIME ZONE
);

CREATE TABLE order_items (
    id                BIGSERIAL PRIMARY KEY,
    order_id          BIGINT NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id        BIGINT NOT NULL REFERENCES products(id),
    quantity          INT NOT NULL,
    unit_price_cents   BIGINT NOT NULL,
    total_cents        BIGINT NOT NULL
);

/* =========== CART & CART_ITEMS =========== */
CREATE TABLE carts (
    id          BIGSERIAL PRIMARY KEY,
    user_id     BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    created_at  TIMESTAMP WITH TIME ZONE DEFAULT now(),
    UNIQUE(user_id)
);

CREATE TABLE cart_items (
    id          BIGSERIAL PRIMARY KEY,
    cart_id     BIGINT NOT NULL REFERENCES carts(id) ON DELETE CASCADE,
    product_id  BIGINT NOT NULL REFERENCES products(id),
    quantity    INT NOT NULL DEFAULT 1,
    added_at    TIMESTAMP WITH TIME ZONE DEFAULT now()
);

/* --------- PAYMENTS ---------------- */
CREATE TABLE payments (
    id                BIGSERIAL PRIMARY KEY,
    order_id          BIGINT NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    payment_method   TEXT NOT NULL,
    amount_cents      BIGINT NOT NULL,
    currency_code     CHAR(3) NOT NULL DEFAULT 'USD',
    status           payment_status NOT NULL DEFAULT 'INITIATED',
    transaction_id    TEXT,
    processed_at      TIMESTAMP WITH TIME ZONE,
    created_at        TIMESTAMP WITH TIME ZONE DEFAULT now()
);

/* --------- REVIEWS ------------------- */
CREATE TYPE review_rating AS ENUM ('1', '2', '3', '4', '5');

CREATE TABLE reviews (
    id            BIGSERIAL PRIMARY KEY,
    user_id       BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    product_id    BIGINT REFERENCES products(id) ON DELETE SET NULL,
    rating        review_rating NOT NULL,
    title         TEXT,
    body          TEXT,
    created_at    TIMESTAMP WITH TIME ZONE DEFAULT now()
);

/* -------- CONTENT (BLOGS & GUIDES) ------- */
CREATE TYPE content_type AS ENUM ('BLOG', 'GUIDE');

CREATE TABLE content (
    id                BIGSERIAL PRIMARY KEY,
    author_user_id    BIGINT NOT NULL REFERENCES users(id) ON DELETE SET NULL,
    type              content_type NOT NULL,
    title             TEXT NOT NULL,
    slug              TEXT NOT NULL UNIQUE,
    summary          TEXT,
    body_markdown    TEXT NOT NULL,
    cover_image      TEXT,
    published_at     TIMESTAMP WITH TIME ZONE,
    created_at       TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at       TIMESTAMP WITH TIME ZONE DEFAULT now(),
    status           TEXT DEFAULT 'draft'
);

/* -------- GOVERNMENT SCHEMES --------------- */
CREATE TABLE schemes (
    id                     BIGSERIAL PRIMARY KEY,
    title                  TEXT NOT NULL,
    description            TEXT,
    eligibility           TEXT,
    application_instructions TEXT,
    start_date             DATE,
    end_date               DATE,
    status                 scheme_status NOT NULL DEFAULT 'ACTIVE',
    created_at             TIMESTAMP WITH TIME ZONE DEFAULT now()
);

/* --------- NOTIFICATIONS ---------------- */
CREATE TYPE notification_type AS ENUM ('ORDER_STATUS', 'PROMO', 'SYSTEM', 'MESSAGE');

CREATE TABLE notifications (
    id                BIGSERIAL PRIMARY KEY,
    recipient_user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    type              notification_type NOT NULL,
    title             TEXT NOT NULL,
    body              TEXT NOT NULL,
    is_read           BOOLEAN DEFAULT false,
    created_at         TIMESTAMP WITH TIME ZONE DEFAULT now()
);

/* ========== INDEXES ============================ */
CREATE INDEX idx_products_slug ON products(slug);
CREATE INDEX idx_products_category ON products(category_id);
CREATE INDEX idx_order_items_order ON order_items(order_id);
CREATE INDEX idx_orders_user ON orders(user_id);
CREATE INDEX idx_cart_items_cart ON cart_items(cart_id);
CREATE INDEX idx_cart_items_product ON cart_items(product_id);
CREATE INDEX idx_payments_status ON payments(status);
CREATE INDEX idx_notifications_recipient_read ON notifications(recipient_user_id, is_read);
CREATE INDEX idx_content_slug ON content(slug);
CREATE INDEX idx_content_type ON content(type);

/* ================= TRIGGERS ====================== */
CREATE OR REPLACE FUNCTION set_updated_timestamp()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$;

-- Example trigger for products
DROP TRIGGER IF EXISTS trg_products_updated ON products;
CREATE TRIGGER trg_products_updated
    BEFORE UPDATE ON products
    FOR EACH ROW
    EXECUTE FUNCTION set_updated_timestamp();

/* End of schema */
