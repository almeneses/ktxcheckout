defmodule KtxCheckout.Products do
  @moduledoc """
  The products context.
  """

  @doc """
  Returns a `Product` which `code` match the given `code`

  ## Examples
      iex> get_product_by_code([%Products.Product{code: "CF1"}], "CF1")
      %Products.Product{code: "CF1"}

      iex> get_product_by_code([%Products.Product{code: "CF1"}], "XYZ")
      nil
  """
  def get_product_by_code(products, code) when is_binary(code),
    do: Enum.find(products, nil, &(&1.code == code))

  @doc """
  Returns a list of `Product` which `code` match the given `product_codes`

  ## Examples
      iex> get_multiple_products_by_code(["CF1", "GR1"],
      ...> [%Products.Product{code: "CF1", name: "Coffee", price: 11.23},
      ...> %Products.Product{code: "GR1", name: "Green tea", price: 3.11},
      ...> %Products.Product{code: "SR1", name: "Strawberries", price: 5.00}])
      [%Products.Product{code: "CF1", name: "Coffee", price: 11.23},
      %Products.Product{code: "GR1", name: "Green tea", price: 3.11}]

      iex> get_multiple_products_by_code(["XYZ", "-1-1-1"],
      ...> [%Products.Product{code: "CF1", name: "Coffee", price: 11.23}])
      []
  """
  def get_multiple_products_by_code(product_codes, products)
      when is_list(product_codes) and is_list(products) do
    product_codes
    |> Enum.uniq()
    |> Enum.map(&get_product_by_code(products, &1))
    |> Enum.filter(&(!is_nil(&1)))
  end
end
