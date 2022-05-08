defmodule DiscountsTest do
  use ExUnit.Case

  alias Discounts.Discount

  describe "apply_all_discounts/3" do
    test "Returns the right price of after applying the discounts" do
      total_gross = 15.00
      cart = %{"SR1" => %{count: 3, price: 5.00}}
      discounts = [%Discount{product_code: "SR1", min: 3, quantity: 0.5}]
      expected_price = 13.50

      assert Discounts.apply_all_discounts(total_gross, cart, discounts) == expected_price
    end

    test "Does not apply discounts for a product that does not have any discount listed" do
      total_gross = 9.33
      cart = %{"GR1" => %{count: 3, price: 3.11}}
      discounts = [%Discount{product_code: "SR1", min: 3, quantity: 0.5}]

      assert Discounts.apply_all_discounts(total_gross, cart, discounts) == total_gross
    end

    test "Only applies discounts for products that a discount listed" do
      total_gross = 24.33
      cart = %{"GR1" => %{count: 3, price: 3.11}, "SR1" => %{count: 3, price: 5.00}}
      discounts = [%Discount{product_code: "SR1", min: 3, quantity: 0.5}]
      expected_price = 22.83

      assert Discounts.apply_all_discounts(total_gross, cart, discounts) == expected_price
    end
  end
end
