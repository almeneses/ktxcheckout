defmodule Products do
  @moduledoc """
  The products context.
  """

  alias Products.Product

  ## Helper variable for default data
  @products [
    %Product{code: "GR1", name: "Green tea", price: 3.11},
    %Product{code: "CF1", name: "Coffee", price: 11.23},
    %Product{code: "SR1", name: "Strawberries", price: 5.00}
  ]

  @doc """
  Returns a `Product` which `code` match the given `code`

  ## Examples
      iex> Products.get_product_by_code("CF1")
      %Products.Product{code: "CF1", name: "Coffee", price: 11.23}

      iex> Products.get_product_by_code("XYZ")
      nil
  """
  def get_product_by_code(code) when is_binary(code),
    do: Enum.find(@products, nil, &(&1.code == code))

  @doc """
  Returns a list of `Product` which `code` match the given `product_codes`

  ## Examples
      iex> Products.get_multiple_products_by_code(["CF1", "GR1"])
      [%Products.Product{code: "CF1", name: "Coffee", price: 11.23},
      %Products.Product{code: "GR1", name: "Green tea", price: 3.11}]

      iex> Products.get_multiple_products_by_code(["XYZ", "-1-1-1"])
      []
  """
  def get_multiple_products_by_code(product_codes) when is_list(product_codes) do
    product_codes
    |> Enum.uniq()
    |> Enum.map(&get_product_by_code/1)
    |> Enum.filter(&(!is_nil(&1)))
  end
end
