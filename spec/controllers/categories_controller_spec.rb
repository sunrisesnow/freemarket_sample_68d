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

  describe 'GET #parent' do
    it "@categoryに正しい値が入っていること" do
      category = create(:category)
      get :parent, params: { id: category }
      expect(assigns(:category)).to eq category
    end

    it 'parent.html.hamlに遷移すること' do
      category = create(:category)
      get :parent, params: { id: category }
      expect(response).to render_template :parent
    end
  end

  describe 'GET #child' do
    it "@categoryに正しい値が入っていること" do
      category = create(:category)
      get :child, params: { id: category }
      expect(assigns(:category)).to eq category
    end

    it 'parent.html.hamlに遷移すること' do
      category = create(:category)
      get :child, params: { id: category }
      expect(response).to render_template :child
    end
  end

  describe 'GET #grandchild' do
    it "@categoryに正しい値が入っていること" do
      category = create(:category)
      get :grandchild, params: { id: category }
      expect(assigns(:category)).to eq category
    end

    it 'parent.html.hamlに遷移すること' do
      category = create(:category)
      get :grandchild, params: { id: category }
      expect(response).to render_template :grandchild
    end
  end
end