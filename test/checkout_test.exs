defmodule CheckoutTest do
  use ExUnit.Case
  doctest Checkout

  describe "checkout/1" do
    setup do
      discounts = [
        %{product_code: "GR1", every: 2, rate: 0.5, type: "free"},
        %{product_code: "SR1", min: 3, quantity: 0.5, type: "quantity"},
        %{product_code: "CF1", min: 3, rate: 0.3333, type: "rate"}
      ]

      {:ok, discounts: discounts}
    end

    test "calculates the right price for 3 Green Teas, 1 Coffee and 1 Strawberries", %{
      discounts: discounts
    } do
      expected_price = 22.45
      products = ["GR1", "SR1", "GR1", "GR1", "CF1"]

      assert Checkout.checkout(products, discounts) == expected_price
    end

    test "calculates the right price for 2 Green Teas", %{discounts: discounts} do
      expected_price = 3.11
      products = ["GR1", "GR1"]

      assert Checkout.checkout(products, discounts) == expected_price
    end

    test "calculates the right price for 1 Green Tea and 3 Strawberries", %{discounts: discounts} do
      expected_price = 16.61
      products = ["SR1", "SR1", "GR1", "SR1"]

      assert Checkout.checkout(products, discounts) == expected_price
    end

    test "calculates the right price for 1 Green Tea, 3 Coffees and 1 Strawberries", %{
      discounts: discounts
    } do
      expected_price = 30.57
      products = ["GR1", "CF1", "SR1", "CF1", "CF1"]

      assert Checkout.checkout(products, discounts) == expected_price
    end
  end
end
