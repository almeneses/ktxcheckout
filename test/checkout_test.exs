defmodule CheckoutTest do
  use ExUnit.Case

  alias KtxCheckout.{Checkout, Products.Product, Discounts.Discount}

  doctest Checkout, import: true

  describe "checkout/1" do
    setup do
      products = [
        %Product{code: "GR1", name: "Green tea", price: 3.11},
        %Product{code: "CF1", name: "Coffee", price: 11.23},
        %Product{code: "SR1", name: "Strawberries", price: 5.00}
      ]

      discounts = [
        %Discount{product_code: "GR1", every: 2, rate: 0.5, type: "free"},
        %Discount{product_code: "SR1", min: 3, quantity: 0.5, type: "quantity"},
        %Discount{product_code: "CF1", min: 3, rate: 0.3333, type: "rate"}
      ]

      {:ok, discounts: discounts, products: products}
    end

    test "calculates the right price for 3 Green Teas, 1 Coffee and 1 Strawberries", %{
      discounts: discounts,
      products: products
    } do
      expected_price = 22.45
      product_codes = ["GR1", "SR1", "GR1", "GR1", "CF1"]

      assert Checkout.checkout(product_codes, products, discounts) == expected_price
    end

    test "calculates the right price for 1 Green Tea", %{
      discounts: discounts,
      products: products
    } do
      expected_price = 3.11
      product_codes = ["GR1"]

      assert Checkout.checkout(product_codes, products, discounts) == expected_price
    end

    test "calculates the right price for 2 Green Teas", %{
      discounts: discounts,
      products: products
    } do
      expected_price = 3.11
      product_codes = ["GR1", "GR1"]

      assert Checkout.checkout(product_codes, products, discounts) == expected_price
    end

    test "calculates the right price for 1 Green Tea and 3 Strawberries", %{
      discounts: discounts,
      products: products
    } do
      expected_price = 16.61
      product_codes = ["SR1", "SR1", "GR1", "SR1"]

      assert Checkout.checkout(product_codes, products, discounts) == expected_price
    end

    test "calculates the right price for 1 Green Tea, 3 Coffees and 1 Strawberries", %{
      discounts: discounts,
      products: products
    } do
      expected_price = 30.57
      product_codes = ["GR1", "CF1", "SR1", "CF1", "CF1"]

      assert Checkout.checkout(product_codes, products, discounts) == expected_price
    end
  end
end
