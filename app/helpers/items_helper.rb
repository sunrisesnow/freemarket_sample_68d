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

end
