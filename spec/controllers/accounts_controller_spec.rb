require 'rails_helper'

describe AccountsController, type: :controller do
  let(:user) {create(:user)}
  describe 'GET #new' do
    context 'ログインしている場合' do
      before do
        login user
      end
      context 'accountを作成済みの場合' do
        it 'アカウント編集画面にリダイレクトされること' do
          account = create(:account, user_id: user.id)
          get :new
          expect(response).to redirect_to "/accounts/#{user.id}/edit"
        end
      end
      context 'accountを作成していない場合' do
        it '正常にレスポンスを返すこと' do
          get :new
          expect(response).to be_successful
        end
        it '@accountには意図した値が代入されていること' do
          get :new
          expect(assigns(:account)).to be_a_new(Account)
        end
      end
    end
    context 'ログインしていない場合' do
      it 'ログイン画面にリダイレクトすること' do
        get :new
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end
  describe 'POST #create' do
    let(:params) do
      {
        user_id: user.id,
        account: {
          icon_image: nil,
          background_image: nil,
          introduction: nil
        }
      }
    end
    context 'ログインしている場合' do
      before do
        login user
      end
      context '保存に成功した場合' do
        subject {
          post :create,
          params: params
        }
        it 'accountを保存すること' do
          expect{ subject }.to change(Account, :count).by(1)
        end
        it 'アカウント編集画面にリダイレクトすること' do
          subject
          expect(response).to redirect_to "/accounts/#{user.id}/edit"
        end
      end
      context '保存に失敗した場合' do
        let(:invalid_params) do {
          user_id: user.id,
          account: {
            icon_image: nil,
            background_image: nil,
            introduction: "よろしくね" * 201
          }
        }
          
        end
        subject {
          post :create,
          params: invalid_params
        }
        it 'accountを保存しないこと' do
          expect{ subject }.not_to change(Account, :count)
        end
      end
    end
    context 'ログインしていない場合' do
      it 'ログイン画面にリダイレクトされること' do
        post :create, params: params
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end 
  describe 'GET #edit' do
    context 'ログインしている場合' do
      before do
        login user
      end
      context 'accountが存在する場合' do
        it '正常にレスポンスを返すこと' do
          account = create(:account, user_id: user.id)
          get :edit, params: {id: 1}
          expect(response).to be_successful
        end
        it '@accountには意図した値が代入されている事' do
          account = create(:account, user_id: user.id)
          get :edit, params: {id: 1}
          expect(assigns(:account)).to match(account)
        end
      end
      context 'accountが存在しない場合' do
        it 'アカウント登録画面にリダイレクトすること' do
          get :edit, params: {id: 1}
          expect(response).to redirect_to '/accounts/new'
        end
      end
    end
    context 'ログインしていない場合' do
      it 'ログイン画面にリダイレクトすること' do
        get :edit, params: {id: 1}
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end
  describe 'patch #update' do
    context 'ログインしている場合' do
      before do
        login user
      end
      it 'アカウントを更新できること' do
        account = create(:account, user_id: user.id)
        account_params = {introduction: "変更"}
        patch :update, params: {id: user.id, account: account_params}
        expect(account.reload.introduction).to eq("変更")
      end
      it 'アカウント更新後、アカウント編集ページにリダイレクトすること' do
        account = create(:account, user_id: user.id)
        account_params = {introduction: "変更"}
        patch :update, params: {id: user.id, account: account_params}
        expect(response).to redirect_to "/accounts/#{user.id}/edit"
      end
      it '不正な値の場合アカウントは更新されないこと' do
        account = create(:account, user_id: user.id)
        account_params = {introduction: "おはようご" * 201}
        patch :update, params: {id: user.id, account: account_params}
        expect(account.reload.introduction).to eq("よろしく")
      end
      it '不正な値を更新しようとした場合、トップページにリダイレクトすること' do
        account = create(:account, user_id: user.id)
        account_params = {introduction: "おはようご" * 201}
        patch :update, params: {id: user.id, account: account_params}
        expect(response).to redirect_to "/"
      end
    end
    context 'ログインしていない場合' do
      it 'ログイン画面にリダイレクトすること' do
        patch :update, params: {id: 1}
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end
  describe 'DELETE #destroy' do
    context 'ログインしている場合' do
      before do
        login user
      end
      it 'アカウントの削除ができること' do
        account = create(:account, user_id: user.id)
        expect {
          delete :destroy, params: {id: account.id}
        }.to change(Account, :count).by(-1)
      end
    end
    context 'ログインしていない場合' do
      it 'ログイン画面にリダイレクトすること' do
        delete :destroy, params: {id: 1}
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end
end