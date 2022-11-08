require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  describe '新規登録機能' do
    before do
      FactoryBot.create(:user)
    end
    
    context 'ユーザーを新規作成した場合' do
      it 'タスク一覧画面が表示される' do
        visit new_user_path
        fill_in '名前', with: 'newuser1'
        fill_in 'メールアドレス', with: 'newuser1@sample.com'
        fill_in 'パスワード', with: 'newuser1'
        fill_in '確認用パスワード', with: 'newuser1'
        click_on 'Create my account'
        
        expect(page).to have_content '登録しました'
      end
    end

    context 'ログインせずタスク一覧画面に飛ぼうとした場合' do
      it 'ログイン画面が表示される' do
        visit new_user_path     
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe 'セッション機能' do
    context 'ログインをした場合' do
      before do
        FactoryBot.create(:user)
        visit new_session_path
        fill_in 'Email', with: 'newuser1@sample.com'
        fill_in 'Password', with: 'newuser1'   
        click_on 'Log in'
      end
      context 'ログインした場合' do
        it '自分の詳細画面に飛べる' do
          click_on 'Profile'
          expect(page).to have_content 'のページ'
        end
      end
      
      it 'ログイン可能' do
        expect(page).to have_content 'タスク一覧'
      end
    end

    context 'ログインした場合' do
      it '一般ユーザが他人の詳細画面に飛ぶとタスク一覧画面に遷移する' do
        visit user_path(5)
        expect(page).to have_content 'Log in'
      end
    end

    context 'ログアウトをした場合' do
      it 'ログアウト可能である' do
        visit new_session_path
        fill_in 'Email', with: 'newuser1@sample.com'
        fill_in 'Password', with: 'newuser1'   
        click_on 'Log in'
        click_on 'Logout'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end


  describe '管理画面のテスト' do
    before do
      FactoryBot.create(:user_first)
      visit new_session_path
    end  
    context '管理ユーザーの場合' do
      it '管理画面にアクセスできる' do
        fill_in 'Email', with: 'newuser11@sample.com'
        fill_in 'Password', with: 'newuser11'

        click_on 'Log in'

        expect(page).to have_content '管理:Taskユーザー一覧'
      end
    end

    context '管理ユーザーの場合' do
      it 'ユーザの新規登録ができる' do
        fill_in 'Email', with: 'newuser11@sample.com'
        fill_in 'Password', with: 'newuser11'
        click_on 'Log in'
        click_on '管理:Taskユーザー一覧'
        click_on '新規ユーザー登録'          
        fill_in 'user[name]', with: 'newuser2'
        fill_in 'user[email]', with: 'newuser2@sample.com'
        fill_in 'user[password]', with: 'newuser2'
        fill_in 'user[password_confirmation]', with: 'newuser2'
        
        click_on '登録'                  
        expect(page).to have_content 'ユーザーを登録しました'
      end
    end

    context '管理ユーザーの場合' do
      it '管理者はユーザーの詳細画面にアクセスできる' do
        fill_in 'Email', with: 'newuser11@sample.com'
        fill_in 'Password', with: 'newuser11'
        click_on 'Log in'
        click_on '管理:Taskユーザー一覧'
        click_on "Show", match: :first
        expect(page).to have_content 'タスク一覧'
      end
    end

    context '管理ユーザーの場合' do
      it '管理者はユーザーの編集画面からユーザを編集できる' do
        fill_in 'Email', with: 'newuser11@sample.com'
        fill_in 'Password', with: 'newuser11'
        click_on 'Log in'
        click_on '管理:Taskユーザー一覧'
        click_on 'Edit', match: :first
        fill_in 'user[name]', with: 'newuser2'
        fill_in 'user[email]', with: 'editdone@sample.com'
        fill_in 'user[password]', with: 'newuser2'
        fill_in 'user[password_confirmation]', with: 'newuser2'
        click_on '更新'
        expect(page).to have_content 'editdone@sample.com'
      end
    end

    context '管理ユーザーの場合' do
      it'管理者はユーザーの削除ができる' do
        fill_in 'Email', with: 'newuser11@sample.com'
        fill_in 'Password', with: 'newuser11'
        click_on 'Log in'
        click_on '管理:Taskユーザー一覧'
        click_on 'Destroy', match: :first
        expect(page).to have_content '削除しました'
      end
    end

    context '一般ユーザーの場合' do
      it '管理画面にアクセスできないこと' do
        FactoryBot.create(:user)
        fill_in 'Email',	with: "newuser1@sample.com"
        fill_in 'Password',	with: 'newuser1'
        click_on 'Log in'
        expect(page).to have_content 'false'
      end
    end
  end
end

