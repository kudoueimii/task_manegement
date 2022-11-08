require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:task) { FactoryBot.create(:task, user: user) }
  describe do
    before do
      visit new_session_path
      fill_in 'session[email]',	with: "newuser1@sample.com"
      fill_in 'session[password]',	with: 'newuser1'
      click_on 'Log in'
    end

    describe '新規作成機能' do
      context 'タスクとステータスを新規作成した場合' do
        it '作成したタスクとステータスが表示される' do
          visit new_task_path
          
          fill_in 'task[title]',	with: 'test_title1'
          fill_in 'task[detail]',	with: 'test_detail'
          select 'waiting', from: 'task[status]'
          select '高', from: 'task[priority]'
          click_on '登録する'
  
          expect(page).to have_content 'test_title1'
          expect(page).to have_content 'waiting'
        end
      end
    end
  
    describe '一覧表示機能' do
      context '一覧画面に遷移した場合' do
        it '作成済みのタスク一覧が表示される' do
          visit tasks_path
          sleep(1)

          expect(page).to have_content 'test_title1'
        end
      end 
    end

    describe '一覧表示機能' do
      context 'タスクが作成日時の降順に並んでいる場合'do
        it '新しいタスクが一番上に表示される'do
          visit tasks_path
          sleep(1)

          task_list = all('.task_all')
  
          expect(task_list[0]).to have_content 'test_title1'
        end
      end
    end

    describe '一覧表示機能' do
      context' 終了期限でソートする場合'do
        it '終了期限を降順で表示される'do
          FactoryBot.create(:task, user: user)
          visit tasks_path
          
          click_on "終了期限でソートする"
          sleep(1)
          task_list = all('.task_all')
  
          expect(task_list[0]).to have_content 'test_title1'
        end
      end
    end
  
    describe '詳細表示機能' do
      context '任意のタスク詳細画面に遷移した場合' do
        it '該当タスクの内容が表示される' do
          @task = FactoryBot.create(:task, title: 'タイトル', detail: '詳細', user: user)
          visit task_path(@task.id)
          expect(page).to have_content '詳細'
        end
      end
    end

    describe '検索機能' do
      # FactoryBot.create(:task, title: 'test_title', status:'waiting', user: user)
      before do
        visit new_session_path
        fill_in 'Email',	with: "newuser1@sample.com"
        fill_in 'Password',	with: 'newuser1'
        click_on 'Log in'
      end
      context 'タイトルであいまい検索をした場合' do
        it "検索キーワードを含むタスクで絞り込まれる" do
          FactoryBot.create(:task, title: 'test_title', status:'waiting', user: user)
          visit tasks_path
          fill_in 'task[title]', with: 'test_title'
          click_on "Search"
          expect(page).to have_content 'test'
        end
      end
      context 'ステータス検索をした場合' do
        it "ステータスに完全一致するタスクが絞り込まれる" do
          FactoryBot.create(:task, title: 'test_title', status:'waiting', user: user)
          visit tasks_path

          select 'waiting', from: 'task[status]'
          click_on "Search"

          expect(page).to have_content 'waiting'
        end
      end
      context 'タイトルのあいまい検索とステータス検索をした場合' do
        it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
          visit tasks_path

          fill_in "task[title]", with: 'test'
          select 'waiting', from: 'task[status]'
          click_on 'Search'

          expect(page).to have_content 'test'
          expect(page).to have_selector 'td', text: 'waiting'
        end
      end
    end
  end
end