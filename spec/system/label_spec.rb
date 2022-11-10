require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:task) { FactoryBot.create(:label) }
  describe do
    before do
      visit new_session_path
      fill_in 'session[email]',	with: "newuser1@sample.com"
      fill_in 'session[password]',	with: 'newuser1'
      click_on 'Log in'
    end

    describe '新規作成機能' do
      context 'ラベルを新規作成した場合' do
        it '作成したラベルが表示される' do
          visit new_task_path
          
          fill_in 'task[title]',	with: 'test_title1'
          fill_in 'task[detail]',	with: 'test_detail'
          select 'waiting', from: 'task[status]'
          select '高', from: 'task[priority]'
          check 'sample1'
          click_on '登録する'
  
          expect(page).to have_content 'test_title1'
          expect(page).to have_content 'waiting'
          expect(page).to have_content 'sample1'
        end
        it "ラベルに完全一致するタスクが絞り込まれる" do
          visit tasks_path

          select 'sample1', from: 'task[label_id]'
          click_on "Search"

          expect(page).to have_content 'sample1'
        end
      end
    end
  end
end
