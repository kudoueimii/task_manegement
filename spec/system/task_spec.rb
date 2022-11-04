require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクとステータスを新規作成した場合' do
      it '作成したタスクとステータスが表示される' do
        visit new_task_path

        task = FactoryBot.create(:task, title: 'タイトル', status: 'waiting')
        visit tasks_path

        expect(page).to have_content 'タイトル'
        expect(page).to have_content 'waiting'
      end
    end
  end

  describe '検索機能' do
    before do
      FactoryBot.create(:task, title: "task")
      FactoryBot.create(:task, title: "task2")
    end

    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        fill_in 'task_title', with: 'task'
        click_on 'Search'
        expect(page).to have_content 'task'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path

        select 'waiting', from: 'task_status'
        click_on 'Search'

        expect(page).to have_selector 'td', text: 'waiting'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit tasks_path

        fill_in "task_title", with: 'task'
        select 'waiting', from: 'task_status'
        click_on 'Search'

        expect(page).to have_content 'task'
        expect(page).to have_selector 'td', text: 'waiting'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, title: 'task', detail: 'test')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合'do
      it '新しいタスクが一番上に表示される'do
        task = FactoryBot.create(:task, title: 'task2')
        task = FactoryBot.create(:task, title: 'task1')
        visit tasks_path

        task_list = all('.task_all')

        expect(task_list[0]).to have_content 'task2'
        expect(task_list[1]).to have_content 'task1'
      end
    end
    context' 終了期限でソートする場合'do
      it '終了期限を降順で表示される'do
        task = FactoryBot.create(:task, title: 'sort2', deadline_at: '2022-10-2T19:27:00.000Z')
        task = FactoryBot.create(:task, title: 'sort1', deadline_at: '2022-11-2T19:27:00.000Z')
        visit tasks_path
        # sleep(5)
        
        click_on '終了期限でソートする'
        task_list = all('.task_all')

        expect(task_list[0]).to have_content 'sort1'
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        @task = FactoryBot.create(:task, title: 'タイトル', detail: '詳細')
        visit task_path(@task.id)
        expect(page).to have_content '詳細'
      end
    end
  end

end