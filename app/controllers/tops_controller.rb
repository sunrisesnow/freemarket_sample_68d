class TopsController < ApplicationController
  def index  
    @items = Item.includes(:images).limit(5).order('created_at DESC')
    @radies = Category.find(1)
    @mens = Category.find(196)
    @kids = Category.find(327)
    @interiors = Category.find(461)
    @entertainments = Category.find(601)
    @toys = Category.find(661)
    @cosmetics = Category.find(774)
    @electricals = Category.find(874)
    @sports = Category.find(960)
    @handmades = Category.find(1069)
    @tickets = Category.find(1123)
    @vehicles = Category.find(1183)
    @others = Category.find(1246)
    @brands = ["シャネル","ナイキ", "ルイヴィトン", "シュプリーム","アディダス"]
  end
  def new

  end
end
