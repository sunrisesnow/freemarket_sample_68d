module ItemsHelper
  def tax_include_price(price)
    tax_price = price * 1.1
    "#{tax_price.floor}" + "円"
  end
end
