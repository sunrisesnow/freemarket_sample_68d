require 'rails_helper'

describe CategoriesController, type: :controller do
  describe 'GET #index' do
    it '@parentsに正しい値が入っていること' do
      parents = create_list(:category, 13)
      get :index
      expect(assigns(:parents)).to match(parents)
    end
    it 'index.html.hamlに遷移すること' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it "@categoryに正しい値が入っていること" do
      category = create(:category)
      get :show, params: { id: category }
      expect(assigns(:category)).to eq category
    end

    it 'show.html.hamlに遷移すること' do
      category = create(:category)
      get :show, params: { id: category }
      expect(response).to render_template :show
    end
  end
end