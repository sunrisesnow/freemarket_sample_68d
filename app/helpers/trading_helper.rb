module TradingHelper
  def trading_item_users(item)
    @saler_user = User.find(item.saler_id)
    @buyer_user = User.find(item.buyer_id)
  end

  def trading_item_fee(item)
    price = item.price * 0.1 
    @sales_commission = price.floor
    @sales_profit = item.price - @sales_commission
  end

  def trading_status_check(item ,saler_user,  buyer_user)
    if item.trading_status_id == 1 && saler_user == current_user
      "商品が購入されました！
      商品を発送してください！"
    elsif item.trading_status_id == 2 && saler_user == current_user
      "受け取り評価をお待ちください"
    elsif item.trading_status_id == 3 && saler_user == current_user
      "受け取り評価がありました！取引評価をしてください"
    elsif item.trading_status_id == 1 && buyer_user == current_user
      "商品の発送をお待ちください"
    elsif item.trading_status_id == 2 && buyer_user == current_user
      "商品が発送されました！
      受け取り評価をしてください！"
    elsif item.trading_status_id == 3 && buyer_user == current_user
      "取引相手からの評価をお待ちください"
    elsif item.trading_status_id == 5 && buyer_user == current_user || saler_user == current_user
      "この取引はすでに完了しています"
    else
      "あなたはこの取引に参加していません"
    end
  end

  def transaction_button(item ,saler_user,  buyer_user)
    if item.trading_status_id == 1 && saler_user == current_user
      link_to "商品を発送する", item_trading_path(item, current_user), method: :patch, class: "content__trading__box__btn"
    elsif item.trading_status_id == 3 && saler_user == current_user
      link_to "取引を完了する", item_trading_path(item, current_user), method: :patch, class: "content__trading__box__btn"
    elsif item.trading_status_id == 2 && buyer_user == current_user
      link_to "受け取り評価完了", item_trading_path(item, current_user), method: :patch, class: "content__trading__box__btn"
    elsif item.trading_status_id != 5
      "取引の進展をお待ちください"
    else
      "取引は完了しました"
    end
  end
end
