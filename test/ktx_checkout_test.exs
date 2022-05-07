defmodule KtxCheckoutTest do
  use ExUnit.Case
  doctest KtxCheckout

  describe "checkout/1" do
    test "calculates the right price for 3 Green Teas, 1 Coffee and 1 Strawberries" do
      expected_price = 22.45
      products = ["GR1", "SR1", "GR1", "GR1", "CF1"]

      assert KtxCheckout.checkout(products) == expected_price
    end

    test "calculates the right price for 2 Green Teas" do
      expected_price = 3.11
      products = ["GR1", "GR1"]

      assert KtxCheckout.checkout(products) == expected_price
    end

    test "calculates the right price for 1 Green Tea and 3 Strawberries" do
      expected_price = 16.61
      products = ["SR1", "SR1", "GR1", "SR1"]

      assert KtxCheckout.checkout(products) == expected_price
    end

    test "calculates the right price for 1 Green Tea, 3 Coffees and 1 Strawberries" do
      expected_price = 30.57
      products = ["GR1", "CF1", "SR1", "CF1", "CF1"]

      assert KtxCheckout.checkout(products) == expected_price
    end
  end
end
