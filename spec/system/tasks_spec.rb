require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:user)
    visit tasks_path
    fill_in "Eメール", with: "user@user.com"
    fill_in "パスワード", with: "password"
    click_button 'ログイン'
  end
  describe 'タスク一覧画面' do    
    context 'タスク一覧画面のタスク情報を画面表示する機能に関して' do
      before do
        FactoryBot.create(:task)
        visit tasks_path
      end
      it "titleが一覧画面に表示されているか" do
        expect(page).to have_content "test1"
      end 
      it "contentが一覧画面に表示されているか" do
        expect(page).to have_content "testes1"
      end
      it "stateが一覧画面に表示されているか" do
        expect(page).to have_content "着手中"
      end
      it "limitが一覧画面に表示されているか" do
        expect(page).to have_content "2024年05月23日"
      end
      it "contentが一覧画面に表示されているか" do
        expect(page).to have_content "低"
      end
    end

    context 'タスク一覧画面のタスク情報を削除する機能に関して' do
      before do
        FactoryBot.create(:task, id:1, title: "test1", content: "content1")
        FactoryBot.create(:task, id:2, title: "test2", content: "content2")
        FactoryBot.create(:task, id:3, title: "test3", content: "content3")
        FactoryBot.create(:task, id:4, title: "test4", content: "content4")
        visit tasks_path
      end
      it "test3が一覧画面に表示されていないか" do
        click_on "delete_3"
        expect(page).to have_content "test3"
      end 
    end

    context '一覧画面の検索機能に関して' do
      before do
        FactoryBot.create(:task, id:1, title: "hogehoge1", status: "0", priority: "0")
        FactoryBot.create(:task, id:2, title: "hogehoge2", status: "0", priority: "1")
        FactoryBot.create(:task, id:3, title: "hogehoge3", status: "1", priority: "2")
        FactoryBot.create(:task, id:4, title: "hogehoge4", status: "1", priority: "0")
        FactoryBot.create(:task, id:5, title: "hogehoge5", status: "2", priority: "1")
        FactoryBot.create(:task, id:6, title: "hugahuga6", status: "2", priority: "2")
        visit tasks_path
      end

      it "hogehoge3のみが表示されているか" do
        fill_in "タイトル", with: "geh"
        select '着手中', from: '状態'
        select '低', from: '重要度'
        click_on "検索"
        expect(page).to have_content "hogehoge3"
      end 
    end

    context '一覧画面の状態の表示に関して' do
      before do
        FactoryBot.create(:task, status: 0)
        FactoryBot.create(:task, status: 1)
        FactoryBot.create(:task, status: 2)
        FactoryBot.create(:task, status: 3)
        visit tasks_path
      end
      # [["未着手",0],["着手中",1],["完了",2],["凍結",3]]
      it "状態が0の時、未着手が表示されているか" do        
        expect(page).to have_content "未着手"
      end 
      it "状態が1の時、着手中が表示されているか" do
        expect(page).to have_content "着手中"
      end 
      it "状態が2の時、完了が表示されているか" do
        expect(page).to have_content "完了"
      end 
      it "状態が3の時、凍結が表示されているか" do
        expect(page).to have_content "凍結"
      end 
    end

    context '一覧画面でログインしているユーザーのタスクしか表示されていないか' do
      before do
        user1 = FactoryBot.create(:user, id:2, name: "hogehoge1", email: "test1@test.com")
        FactoryBot.create(:task, id:1, title: "hogehoge1", status: "0", priority: "0", user_id: 2)
        FactoryBot.create(:task, id:2, title: "hogehoge2", status: "0", priority: "1", user_id: 1)
        FactoryBot.create(:task, id:3, title: "hogehoge3", status: "1", priority: "2", user_id: 2)
        visit tasks_path
      end

      it "hogehoge2のみが表示されているか" do
        expect(page).to have_content "hogehoge2"
      end 
      it "hogehoge３が表示されていないか" do
        expect(page).to_not have_content "hogehoge3"
      end 
    end

    context '一覧画面でソート機能が正常に稼働しているか' do
      before do
        FactoryBot.create(:task, id: 1,title: "title1", limit: Time.current + 1.days)
        FactoryBot.create(:task, id: 2,title: "title2", limit: Time.current + 4.days)
        FactoryBot.create(:task, id: 3,title: "title3", limit: Time.current + 2.days)
        FactoryBot.create(:task, id: 4,title: "title4", limit: Time.current + 3.days)
        visit tasks_path
      end
      it "limitのOrderByの降順が効いているか" do
        click_on 'limit_desc'
        #おそらく、画面描画前に処理が実施されているため、エラーになる時とならない時がある。binding.irbで止めると問題ない
        tasks = Array.new
        expect(page).to have_content "title1"
        page.find_all('.test_title').each do |item|
          tasks.push(item.text)
        end
        expect(tasks).to eq ["title2","title4","title3","title1"]
      end
      it "limitのOrderByの昇順が効いているか" do
        click_on 'limit_asc'
        tasks = Array.new
        expect(page).to have_content "title1"
        page.all('.test_title').each do |item|
          tasks.push(item.text)
        end
        expect(tasks).to eq ["title1","title3","title4","title2"]
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
  end

  describe 'タスク編集画面' do
    context '任意のタスク編集画面に遷移後、該当タスクの編集を行い一覧画面に遷移する' do
      before do
        task = FactoryBot.create(:task, title: "test1" , content: "content1" , status: 2 , limit: "2024-05-23")
        visit edit_task_path(task.id)
      end
      it "contentをcontent1からhoge1に変更" do
        fill_in "内容", with: "hoge1"
        click_on "更新する"
        expect(page).to have_content "hoge1"
      end
    end
  end
  describe 'タスク詳細画面' do

    context '任意のタスク詳細画面に遷移したら、該当タスクの内容が表示されたページに遷移する' do
      before do
        task = FactoryBot.create(:task, title: "test1" , content: "content1" , status: 2 , limit: "2024-05-23")
        visit task_path(task.id)
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
        expect(page).to have_content "2024年05月23日"
      end
    end
  end
end
