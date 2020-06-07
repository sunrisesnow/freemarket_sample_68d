class DeliveryCharge < ActiveHash::Base
  self.data = [
      {flag: 1, name: '送料込み(出品者負担)'},
      {flag: 2, name: '着払い(購入者負担)'}
  ]
end