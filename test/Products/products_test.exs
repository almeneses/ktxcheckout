defmodule ProductsTest do
  use ExUnit.Case

  describe "get_product_by_code/1" do
    test "Returns a `Product` if the given `code` matches a product" do
      search_code = "GR1"

      assert Products.get_product_by_code(search_code).code == search_code
    end

    test "Returns `nil` if the given `code` does not match any product" do
      search_code = "WWW"

      assert is_nil(Products.get_product_by_code(search_code))
    end
  end

  describe "get_multiple_products_by_code/1" do
    test "Returns a list of `Product` if the given `product_codes` matches multiple products" do
      search_codes = ["GR1", "CF1"]
      result = Products.get_multiple_products_by_code(search_codes)

      assert length(result) == length(search_codes)
      assert Enum.all?(result, &(&1.code in search_codes))
    end

    test "Returns an empty list if the given `product_codes` does not match any product" do
      search_codes = ["WWW", "ZZZ"]

      assert Products.get_multiple_products_by_code(search_codes) == []
    end
  end
end
