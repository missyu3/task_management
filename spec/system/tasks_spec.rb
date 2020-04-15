require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe 'タスク一覧画面' do
    context '新規タスク登録後、一覧画面に遷移される時' do
      before do
        visit new_task_path
        fill_in "Title", with: "test1"
        fill_in "Content", with: "content1"
        select '着手中', from: 'Status'
        select_date("2023/8/27","Limit")
        click_on "Create Task"
      end
      it '作成済みのタスクのタイトルが表示される' do
        expect(page).to have_content "test1"
      end
      it '作成済みのタスクのコンテンツが表示される' do
        expect(page).to have_content "content1"
      end
      it '作成済みのタスクの状態が表示される' do
        expect(page).to have_content "着手中"
      end
      it '作成済みのタスクの終了年が表示される' do
        expect(page).to have_content "2023"
      end
      it '作成済みのタスクの終了月が表示される' do
        expect(page).to have_content "8"
      end
      it '作成済みのタスクの終了月が表示される' do
        expect(page).to have_content "27"
      end
    end
  end
  describe 'タスク一覧画面' do

  end
end
