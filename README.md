# ACME Sales Co – Basket System

This project implements a **shopping basket system** in Ruby that supports products, offers, and tiered delivery rules.

---

## Components

### 1. Product
Represents an individual product.

**Validations:**
- `code` and `name` must be present.
- `price` must be numeric and greater than 0.

---

### 2. Catalogue
Stores all available products.

**Methods:**
- `find_by_code(code)` – fetch a product by its code.

---

### 3. BasketItem
Represents a single product added to the basket.

- Created only through the `Basket`.

---

### 4. Basket
Represents a shopping basket/cart.

- Handles adding items, calculating subtotal, applying offers, and calculating delivery charges.

---

### 5. Offers
**Base class:** `Offer` – abstract class with `apply(basket)` method.

**Example:** `BuyOneGetHalfOffer`
- Applies a “buy one get half price” discount for a specific product code.
- Discounts are applied to half the quantity of matching products (floor division).

---

### 6. Delivery Rules
**Example:** `TieredDeliveryRule`

- Calculates delivery fees based on subtotal:
  - `0…50` → `$4.95`
  - `50…90` → `$2.95`
  - `90+` → `$0.00` (free delivery)
- Optional – basket can be pickup-only (no delivery fee).

---

## Assumptions

- **Catalogue Required:** Basket cannot exist without a product catalogue.
- **Optional Offers:** Offers may be present or absent; basket works either way.
- **Optional Delivery Rules:** Basket may have delivery rules, or it may be pickup-only.
- **Item Quantity Defaults:** If quantity is not provided, defaults to 1.
- **BasketItem Creation:** Basket ensures the product exists before creating a BasketItem.
- **Delivery Calculation:** Applied after discount is deducted.

---

## To Start

```bash
ruby main.rb
```
## To Run Tests
```bash
rspec
```