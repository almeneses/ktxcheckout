defmodule KtxCheckout.Checkout do
  @moduledoc """
  Documentation for `Checkout`.
  """

  alias KtxCheckout.{Products, Discounts}

  @doc """
  Returns the total price from a list of `product_codes` with `discounts` applied.

  ## Examples
    iex> checkout(["GR1", "GR1"],
    ...>[%KtxCheckout.Products.Product{code: "GR1", name: "Green tea", price: 3.11}],
    ...>[%KtxCheckout.Discounts.Discount{product_code: "GR1", every: 2, rate: 0.5, type: "free"}])
    3.11
  """
  def checkout(codes, products, discounts \\ []) do
    cart =
      codes
      |> Products.get_multiple_products_by_code(products)
      |> to_cart_format(codes)

    cart
    |> total_gross()
    |> Discounts.apply_all_discounts(cart, discounts)
    |> Float.round(2)
  end

  defp total_gross(cart),
    do:
      Enum.reduce(cart, 0, fn {_key, value}, acc ->
        acc + value.count * value.price
      end)

  defp to_cart_format(products, product_codes) do
    codes = Enum.frequencies(product_codes)

    Enum.reduce(products, codes, fn product, acc ->
      Map.update(
        acc,
        product.code,
        nil,
        fn val ->
          %{count: val, price: product.price}
        end
      )
    end)
  end
end
