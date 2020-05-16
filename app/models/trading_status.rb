class TradingStatus < ActiveHash::Base
  self.data = [
      {id: 1, name: '販売中'},
      {id: 2, name: '取引中'},
      {id: 3, name: '売却済み'},
      {id: 4, name: '下書き'}
  ]
end