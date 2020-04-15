require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let(:task_1) {task_1 = FactoryBot.create(:task, title: "test1" , content: "content1" , status: 2 , limit: "2024-05-23")}
  describe 'タスク一覧画面' do
    context '一覧画面に登録したタスクが表示する時' do
      before do
        task_1
        FactoryBot.create(:task, title: "test2" , content: "content2" , status: 3 , limit: "2025-08-12")
        visit tasks_path
      end
      it "task1が一覧画面に表示されているか" do
        expect(page).to have_content "test1"
      end 
      it "task2が一覧画面に表示されているか" do
        expect(page).to have_content "test2"
      end
    end
  end

  describe '新規タスク登録画面' do
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
  describe 'タスク詳細画面' do

    context '登録されているタスクの詳細画面に遷移後' do
      before do
        visit task_path(task_1.id)
      end
      it "詳細画面に選択されたタスクが表示されているか" do
          expect(page).to have_content "test1"
      end
      it "詳細画面に選択されたコンテンツが表示されているか" do
        expect(page).to have_content "content1"
      end
      it "詳細画面に選択された状態が表示されているか" do
        expect(page).to have_content "完了"
      end
      it "詳細画面に終了期日が表示されているか" do
        expect(page).to have_content "2024-05-23"
      end
    end
  end
end
