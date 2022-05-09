# KtxCheckout

Simple checkout system implemented in Elixir.

## About

> Free & open source checkout system with support for multiple types of discounts.

## Features

- Support for 3 types of discounts: percentage rate, money discount and "get x free".
- Multiple discounts can be applied to the same product.

## Usage

- Clone the repo and go to the project:

```bash
  git clone https://github.com/almeneses/ktxcheckout.git && cd ktxcheckout
```

- Install dependencies:

```bash
  mix deps.get
```

- Go into the Interactive Shell:

```bash
  iex -S mix
```

- Create a list of products and some discounts for them:

```bash
  iex> alias KtxCheckout.Products.Product
  iex> alias KtxCheckout.Discounts.Discount
  iex> alias KtxCheckout.Checkout
  iex> products = [%Product{name: "Test", code: "TS1", price: 2.95}, %Product{name: "Test2", code: "TS2", price: 4.80}]
  iex> discounts = [%Discount{product_code: "TS1", min: 1, rate: 0.2, type: "rate"}]
  iex> cart = ["TS1", "TS1", "TS2"]
```

- Finally, get your checkout price with discounts (if apply):

```bash
  iex> Checkout.checkout(cart, products, discounts)
```

### Discounts

The discounts have different options based on the type of discount:

| Option         | Description                                                                                                        |
| -------------- | ------------------------------------------------------------------------------------------------------------------ |
| `product_code` | The code of the product that will have the discount applied, **default:** `nil`.                                   |
| `type`         | The type of discount to be applied, as of now, it can be one of `rate`, `quantity` and `free`. **default:** `nil`. |

### Discount types

Each type of discount work with some predefined fields.

#### Rate

Works with the `rate` field, which holds **the percentage** of discount expressed in a number between 0 (0%) and 1 (100%).

An example:

```bash
  %Discount{product_code: "TS1", min: 1, rate: 0.2, type: "rate"} # 20% discount
```

#### Quantity

Works with the `quantity` field, which holds **the amount in money** for the discount.
An example:

```bash
  %Discount{product_code: "TS1", min: 1, quantity: 1, type: "quantity"} # 1(USD| EUR |..) of discount
```

#### Free

Discounts the entire value of 1 product, think of it like `buy-one-get-one-free`, although this can
be parameterized with the `every` field.

An example:

```bash
  %Discount{product_code: "TS1", every: 2, type: "free"} # get one free every 2 products bought
```

### Notes

- Discounts have flexibility in three ways mostly:

  1. You can apply them once when a certain minimum of the same product previously bought (with the `min` property).
  2. You can apply them every x amount of the same product bought (with the `every` property).
  3. These discounts can be applied by discounting money (`quantity` property) or by percentage (`rate` property).

  more types/cases for discount can be further added by using the `type` property and extending the `Discount`
  struct if needed.

- Discounts are applied in the order they are present in the list of Discounts.

- This is still a work in progress.

## Tests

To run tests:

```bash
mix test
```

# Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

# License

[Beerware](https://spdx.org/licenses/Beerware.html)
