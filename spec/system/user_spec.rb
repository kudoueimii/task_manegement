require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  describe '新規登録機能' do
    context 'ユーザーを新規作成した場合' do
      it 'タスク一覧画面が表示される' do
        visit new_user_path

        fill_in 'name', with: 'newuser'
        fill_in 'email', with: 'newuser@sample.com'
        fill_in 'password', with: 'newuser'
        fill_in 'password_confirmation' 'newuser'
        click_on 'Create my account'

        expect(page).to have_content 'newuser'
      end
    end
    context 'ログインせずタスク一覧画面に飛ぼうとした場合' do
      it 'ログイン画面が表示される' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe '新規登録機能' do
    before do
      @user = FactoryBot.create(:user name: 'newuser',
                                      email: 'newuser@sample.com',
                                      password: 'newuser',
                                      password_confirmation: 'newuser')
    end
    context 'ログインをした場合' do
      it '詳細画面が表示される' do
        visit new_session_path
        fill_in 'email', with: 'newuser@sample.com'
        fill_in 'password', with: 'newuser'
        click_on 'Log in'
        expect(page).to have_content 'newuser'
      end
    end
    context 'ログアウトをした場合' do
      it 'ログアウト可能である' do
      visit user_path(id: @user.id)
      click_on 'Logout'
      expect(page).to have_content 'ログアウトしました'
    end
  end


  describe '管理画面のテスト' do
    before do
      @admin = FactoryBot.create(:admin_user,  name: 'baramy1',
                                              email: 'baramy1@sample.com',
                                              password: 'baramy1',
                                              password_confirmation: 'baramy1',
                                              admin: true)
    end
    it '管理画面にアクセスできる' do
        
      visit new_session_path
      fill_in 'session[email]', with: 'baramy1@sample.com'
      fill_in 'session[password]', with: 'baramy1'
      click_on 'ログイン'
      visit admin_users_path
      expect(page).to have_content '管理：Taskユーザー一覧'
    end
    it 'ユーザの新規登録ができる' do
      visit admin_users_path
      click_on "新規ユーザー登録"
      fill_in 'user[name]', with: 'newuser2'
      fill_in 'user[email]', with: 'newuser2@sample.com'
      fill_in 'user[password]', with: 'newuser2'
      fill_in 'user[password_confirmation]', with: 'newuser2'
      click_on '登録'        
      expect(page).to have_content 'newuser2'
    end
    it '管理者はユーザーの詳細画面にアクセスできる' do
      visit admin_users_path
      click_on "Show"        expect(page).to have_content 'プロフィール情報'
    end
    it '管理者はユーザーの編集画面からユーザを編集できる' do
      visit admin_users_path
      click_on 'Edit', match: :first
      fill_in 'user[name]', with: 'newuser2'
      fill_in 'user[email]', with: 'editdone@sample.com'
      fill_in 'user[password]', with: 'newuser2'
      fill_in 'user[password_confirmation]', with: 'newuser2'
      click_on '登録'
      expect(page).to have_content 'editdone@sample.com'
    end
    it'管理者はユーザーの削除ができる' do
      visit admin_users_path
      click_on 'Destroy', match: :first
      expect(page).to have_content '削除しました'
    end
  end
end

