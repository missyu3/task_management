require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let(:task_1) {task_1 = FactoryBot.create(:task, title: "test1" , content: "content1" , status: 2 , limit: "2024-05-23")}

  describe 'タスク一覧画面' do

    context '一覧画面に登録したタスクがタスク一覧画面に遷移したら、作成済みのタスクが表示される表示する時' do
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

    context '複数のタスクを作成した場合' do
      before do
        FactoryBot.create(:task, id: 1, created_at: Time.current + 1.days)
        FactoryBot.create(:task, id: 2, created_at: Time.current + 4.days)
        FactoryBot.create(:task, id: 3, created_at: Time.current + 2.days)
        FactoryBot.create(:task, id: 4, created_at: Time.current + 3.days)
        visit tasks_path
      end
      it 'タスクが作成日時の降順に並んでいる' do
        expect(Task.all.order("created_at DESC").map(&:id)).to eq [2,4,3,1]
      end
    end

    context '一覧画面に表示されている状態が数値から状態名称に変換されているか' do
      before do
        FactoryBot.create(:task, status: 0)
        FactoryBot.create(:task, status: 1)
        FactoryBot.create(:task, status: 2)
        FactoryBot.create(:task, status: 3)
        visit tasks_path
      end
      # [["未着手",0],["着手中",1],["完了",2],["凍結",3]]
      it "状態が0の時未着手が表示されているか" do        
        expect(page).to have_content "未着手"
      end 
      it "状態が1の時着手中が表示されているか" do
        expect(page).to have_content "着手中"
      end 
      it "状態が2の時完了が表示されているか" do
        expect(page).to have_content "完了"
      end 
      it "状態が3の時凍結が表示されているか" do
        expect(page).to have_content "凍結"
      end 
    end
  end

  describe '新規タスク登録画面' do

    context 'タスク登録画面で、必要項目を入力してcreateボタンを押したらデータが保存される' do
      before do
        visit new_task_path
        fill_in "タイトル", with: "test1"
        fill_in "内容", with: "content1"
        select '着手中', from: '状態'
        select_date("2023/8/27","期日")
        click_on "登録する"
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

    context 'タスク登録画面で、バリデーション機能が正常に動くか' do
      it "titleが空ならバリデーションが通らない" do
        task = FactoryBot.build(:task, title: "")
        expect(task).not_to be_valid
      end
      it "contentが空ならバリデーションが通らない" do
        task = FactoryBot.build(:task, content: "")
        expect(task).not_to be_valid
      end
    end
  end

  describe 'タスク詳細画面' do

    context '任意のタスク詳細画面に遷移したら、該当タスクの内容が表示されたページに遷移する' do
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
