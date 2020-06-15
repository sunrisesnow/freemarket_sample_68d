module ItemsHelper
  def delivery_charge(item)
    case item.delivery_charge_flag 
      when 1
        "送料込み"
      when 2
        "着払い"
      else
        "配送料の負担が選択されていません"
    end
  end

  def delivery_charge_full(item)
    case item.delivery_charge_flag 
      when 1
        "送料込み(出品者負担)"
      when 2
        "着払い(購入者負担)"
      else
        "配送料の負担が選択されていません"
    end
  end

  def item_sell_fee(item)
    if item.persisted?
      fee = (item.price * 0.1).floor
      "¥#{number_to_currency(fee, unit: "", strip_insignificant_zeros: true)}"
    else
      "-"
    end
  end

  def item_sell_profit(item)
    if item.persisted?
      fee = (item.price * 0.1).floor
      profit = item.price - fee
      "¥#{number_to_currency(profit, unit: "", strip_insignificant_zeros: true)}"
    else
      "-"
    end
  end

end
