require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        task = FactoryBot.create(:task, title: 'タイトル', detail: '詳細')
        visit tasks_path
        expect(page).to have_content 'タイトル'
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
        # click_on 'ソート'
        expect(task_list[0]).to have_content 'task1'
        expect(task_list[1]).to have_content 'task2'
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