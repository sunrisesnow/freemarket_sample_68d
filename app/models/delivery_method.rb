class DeliveryMethod < ActiveHash::Base
  self.data = [
      {id: 1, flag: '1', name: '未定'},
      {id: 2, flag: '1', name: 'らくらくメルカリ便'},
      {id: 3, flag: '1', name: 'ゆうゆうメルカリ便'},
      {id: 4, flag: '1', name: 'ゆうメール'},
      {id: 5, flag: '1', name: 'レターパック'},
      {id: 6, flag: '1', name: '普通郵便(定形、定形外)'},
      {id: 7, flag: '1', name: 'クロネコヤマト'},
      {id: 8, flag: '1', name: 'ゆうパック'},
      {id: 9, flag: '1', name: 'クリックポスト'},
      {id: 10, flag: '1', name: 'ゆうパケット'},
      {id: 11, flag: '2', name: '未定'},
      {id: 12, flag: '2', name: 'クロネコヤマト'},
      {id: 13, flag: '2', name: 'ゆうパック'},
      {id: 14, flag: '2', name: 'ゆうメール'},
  ]
end