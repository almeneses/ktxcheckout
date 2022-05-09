defmodule ProductsTest do
  use ExUnit.Case

  alias Products.Product

  doctest Products, import: true

  setup do
    products = [
      %Product{code: "GR1", name: "Green tea", price: 3.11},
      %Product{code: "CF1", name: "Coffee", price: 11.23},
      %Product{code: "SR1", name: "Strawberries", price: 5.00}
    ]

    {:ok, products: products}
  end

  describe "get_product_by_code/1" do
    test "Returns a `Product` if the given `code` matches a product", %{products: products} do
      search_code = "GR1"

      assert Products.get_product_by_code(products, search_code).code == search_code
    end

    test "Returns `nil` if the given `code` does not match any product", %{products: products} do
      search_code = "WWW"

      assert is_nil(Products.get_product_by_code(products, search_code))
    end
  end

  describe "get_multiple_products_by_code/1" do
    test "Returns a list of `Product` if the given `product_codes` matches multiple products", %{
      products: products
    } do
      search_codes = ["GR1", "CF1"]
      result = Products.get_multiple_products_by_code(search_codes, products)

      assert length(result) == length(search_codes)
      assert Enum.all?(result, &(&1.code in search_codes))
    end

    test "Returns an empty list if the given `product_codes` does not match any product", %{
      products: products
    } do
      search_codes = ["WWW", "ZZZ"]

      assert Products.get_multiple_products_by_code(search_codes, products) == []
    end
  end
end
