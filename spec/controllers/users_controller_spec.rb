require 'rails_helper'

describe UsersController, type: :controller do
  let(:user) { create(:user) }
  describe 'GET #index' do
    context 'ログインしている場合' do
      before do
        login user
        get :index
      end
      it "正常にレルポンスを返すこと" do
        expect(response).to be_successful
      end
    end
    context 'ログインしていない場合' do
      it 'ログイン画面にリダイレクトすること' do
        get :index
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe 'GET #show' do
    context 'ログインしている場合' do
      before do
        login user
        get :show, params: {id: 1}
      end
      it '正常にレスポンスを返すこと' do
        expect(response).to be_successful
      end
    end
    context 'ログインしていない場合' do
      it 'ログイン画面にリダイレクトすること' do
        get :show, params: {id: 1}
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe 'GET #draft' do
    context 'ログインしている場合' do
      before do
        login user
        get :draft
      end
      it '正常にレスポンスを返すこと' do
        expect(response).to be_successful
      end
      context '@itemsに代入されるべき値' do
        it '下書き商品（saler_id: current, buyer_id: nil, trading_status_id: 4）' do
          items = create_list(:item, 5, saler_id: user.id, buyer_id: nil, trading_status_id: 4)
          expect(assigns(:items)).to match(items)
        end
      end
      context '@itemに代入されるべきでない値' do
        it "出品された商品（saler_id: current, buyer_id: nil, trading_status_id: 1）" do
          items = create_list(:item, 5, saler_id: user.id, buyer_id: nil)
          expect(assigns(:items)).to_not match(items)
        end
      end
    end
    context 'ログインしていない場合' do
      it 'ログイン画面にリダイレクトすること' do
        get :draft
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end
  describe 'GET #exhibition' do
    context 'ログインしている場合' do
      before do
        login user
        get :exhibition
      end
      it '正常にレスポンスを返すこと' do
        expect(response).to be_successful
      end
      context '@itemsに代入されるべき値' do
        it '出品商品（saler_id: current, buyer_id: nil, trading_status_id: 1）' do
          items = create_list(:item, 5, saler_id: user.id, buyer_id: nil)
          expect(assigns(:items)).to match(items)
        end
      end
      context '@itemに代入されるべきでない値' do
        it '購入された商品（saler_id: current, buyer_id: 1）' do
          items = create_list(:item, 5, saler_id: user.id, buyer_id: 1)
          expect(assigns(:items)).to_not match(items)
        end
        it '下書き商品（saler_id: current, buyer_id: nil, trading_status_id: 4）' do
          items = create_list(:item, 5, saler_id: user.id, buyer_id: nil, trading_status_id: 4)
          expect(assigns(:items)).to_not match(items)
        end
      end
    end
    context 'ログインしていない場合' do
      it 'ログイン画面にリダイレクトすること' do
        get :exhibition
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end
  describe 'GET #exhibition_trading' do
    context 'ログインしている場合' do
      before do
        login user
        get :exhibition_trading
      end
      it '正常にレスポンスを返すこと' do
        expect(response).to be_successful
      end
      context '@itemsに代入されるべき値' do
        it '取引商品（saler_id: current, buyer_id: 1, trading_status_id: 1..3）' do
          items = create_list(:trading_item, 5, saler_id: user.id, buyer_id: 1)
          expect(assigns(:items)).to match(items)
        end
        it '取引キャンセル中商品（saler_id: current, buyer_id: 1, trading_status_id: 6..8）' do
          items = create_list(:cancel_trading_item, 5, saler_id: user.id, buyer_id: 1)
          expect(assigns(:items)).to match(items)
        end
      end
      context '@itemに代入されるべきでない値' do
        it '下書き商品 or 取引終了商品（saler_id: current, buyer_id: 1）' do
          items = create_list(:can_not_trading_item, 5,saler_id: user.id, buyer_id: 1)
          expect(assigns(:items)).to_not match(items)
        end
      end
    end
    context 'ログインしていない場合' do
      it 'ログイン画面にリダイレクトすること' do
        get :exhibition_trading
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end
  describe 'GET #exhibition_completed' do
    context 'ログインしている場合' do
      before do
        login user
        get :exhibition_completed
      end
      it '正常にレスポンスを返すこと' do
        expect(response).to be_successful
      end
      context '@itemsに代入されるべき値' do
        it '取引終了商品（saler_id: current, buyer_id: 1, trading_status_id: 1..3）' do
          items = create_list(:item, 5, saler_id: user.id, buyer_id: 1, trading_status_id: 5)
        expect(assigns(:items)).to match(items)
        end
      end
      context '@itemに代入されるべきでない値' do
        it '取引中商品（saler_id: current, buyer_id: 1, trading_status_id: 1..3）' do
          items = create_list(:trading_item, 5,saler_id: user.id, buyer_id: 1)
          expect(assigns(:items)).to_not match(items)
        end
        it '取引キャンセル中商品（saler_id: current, buyer_id: 1, trading_status_id: 6..8）' do
          items = create_list(:cancel_trading_item, 5,saler_id: user.id, buyer_id: 1)
          expect(assigns(:items)).to_not match(items)
        end
      end
    end
    context 'ログインしていない場合' do
      it 'ログイン画面にリダイレクトすること' do
        get :exhibition_completed
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end
  describe 'GET #bought' do
    context 'ログインしている場合' do
      before do
        login user
        get :bought
      end
      it '正常にレスポンスを返すこと' do
        expect(response).to be_successful
      end
      context '@itemsに代入されるべき値' do
        it '購入商品（saler_id: 1, buyer_id: current, trading_status_id: 1..3）' do
          items = create_list(:trading_item, 5, saler_id: 1, buyer_id: user.id)
          expect(assigns(:items)).to match(items)
        end
        it '取引キャンセル中購入商品（saler_id: 1, buyer_id: current, tradin_status_id: 6..8）' do
          items = create_list(:cancel_trading_item, 5,saler_id: 1, buyer_id: user.id)
          expect(assigns(:items)).to match(items)
        end
      end
      context '@itemに代入されるべきでない値' do
        it '購入されていない商品（saler_id: 1, buyer_id: nil）' do
          items = create_list(:item, 5, saler_id: 1, buyer_id: nil)
          expect(assigns(:items)).to_not match(items)
        end
        it '取引完了済み購入商品' do
          items = create_list(:item, 5, saler_id: 1, buyer_id: user.id, trading_status_id: 5)
          expect(assigns(:items)).to_not match(items)
        end
      end
    end
    context 'ログインしていない場合' do
      it 'ログイン画面にリダイレクトすること' do
        get :bought
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end
  describe 'GET #bought_completed' do
    context 'ログインしている場合' do
      before do
        login user
        get :bought_completed
      end
      it '正常にレスポンスを返すこと' do
        expect(response).to be_successful
      end
      context '@itemsに代入されるべき値' do
        it '取引完了済み購入商品' do
          items = create_list(:item, 5, saler_id: 1, buyer_id: user.id, trading_status_id: 5)
          expect(assigns(:items)).to match(items)
        end
      end
      context '@itemに代入されるべきでない値' do
        it '取引中商品（saler_id: i, buyer_id: current, trading_status_id: 1..3）' do
          items = create_list(:trading_item, 5,saler_id: 1, buyer_id: user.id)
          expect(assigns(:items)).to_not match(items)
        end
        it '取引キャンセル中購入商品（saler_id: 1, buyer_id: current, tradin_status_id: 6..8）' do
          items = create_list(:cancel_trading_item, 5,saler_id: 1, buyer_id: user.id)
          expect(assigns(:items)).to_not match(items)
        end
      end
    end
    context 'ログインしていない場合' do
      it 'ログイン画面にリダイレクトすること' do
        get :bought_completed
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end
end