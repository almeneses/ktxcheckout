defmodule Discounts do
  @moduledoc """
  Discounts context.
  """

  alias Discount

  @doc """
  Returns the price value for the given `cart` after applying the give `discounts`
  to the `total_gross`

  ## Parameters

  - `total_gross`: The total price of the products.
  - `cart`: A string `Map` with the form: `%{"product_code" => %{count: occurrencies, price: product_price}, ...}`
  which contains information about the amount of each product and its current price.
  - `discounts`: A `List` of `%Discount{}` with the discounts that will be applied.


  ## Examples
      iex> Discounts.apply_all_discounts(
      ...> 15.00,
      ...> %{"SR1" => %{count: 3, price: 5.00}},
      ...> [%Discounts.Discount{product_code: "SR1", min: 3, quantity: 0.5, type: "quantity"}]
      ...> )
      13.50
  """
  def apply_all_discounts(total_gross, cart, discounts) do
    Enum.reduce(discounts, total_gross, fn discount, acc ->
      case applies_discount?(cart, discount) do
        true ->
          acc - discount(cart, discount)

        false ->
          acc
      end
    end)
  end

  defp applies_discount?(cart, %{product_code: code, min: min}),
    do: !is_nil(cart[code]) && cart[code].count >= min

  defp applies_discount?(cart, %{product_code: code, every: every}),
    do: !is_nil(cart[code]) && cart[code].count >= every

  defp applies_discount?(_cart, _discount), do: false

  defp discount(cart, %{product_code: code, rate: rate, type: "rate"}),
    do:
      cart[code].count *
        (Products.get_product_by_code(code).price * rate)

  defp discount(cart, %{product_code: code, every: every, type: "free"}) do
    times = Float.floor(cart[code].count / every)
    product = Products.get_product_by_code(code)

    (!is_nil(product) && times * product.price) || 0
  end

  defp discount(
         cart,
         %{product_code: code, quantity: quantity, type: "quantity"}
       ),
       do: cart[code].count * quantity
end
