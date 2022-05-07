defmodule Checkout do
  @moduledoc """
  Documentation for `Checkout`.
  """

  alias Products.Product
  alias Discounts.Discount

  @doc """
  Returns the total price from a list of `product_codes` with `Discount` applied.

  ## Examples

    iex> Checkout.hello(["GR1", "GR1"])
    3.11

    iex> Checkout.hello(["SR1", "SR1", "GR1", "SR1"])
    16.61

  """
  def checkout(product_codes) do
    products = [
      %Product{code: "GR1", name: "Green tea", price: 3.11},
      %Product{code: "CF1", name: "Coffee", price: 11.23},
      %Product{code: "SR1", name: "Strawberries", price: 5.00}
    ]

    discounts = [
      %Discount{product_code: "SR1", min: 3, quantity: 0.5}
    ]

    do_checkout(product_codes, products, discounts)
  end

  def do_checkout(product_codes, products, discounts) do
    nil
  end
end
