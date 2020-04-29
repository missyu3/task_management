require 'rails_helper'
RSpec.describe '管理者機能に関して', type: :system do
  describe '管理者画面' do    

    context "管理者画面に関して" do
      before "登録項目の入力" do
        user = FactoryBot.create(:user, admin:true)
        FactoryBot.create(:user, id:2, name:"user2",email:"test2@test.com",admin:false)
        FactoryBot.create(:user, id:3, name:"user3",email:"test3@test.com",admin:true)
        visit new_task_path
        fill_in "Eメール", with: "user@user.com"
        fill_in "パスワード", with: "password"
        click_button "ログイン"
        click_on "管理者画面"
      end
      it "管理者ページに遷移ができるか" do
        expect(page).to have_content "管理者：user1の部屋"
      end
      it "管理者権限を付与できているか" do
        find(".admin_update_2").click
        expect(User.find_by(id: 2).admin).to eq true
      end
      it "管理者権限を削除できているか" do
        find(".admin_delete_3").click
        expect(User.find_by(id: 3).admin).to eq false
      end
      it "管理者権限が一つだけの時、削除できないか" do
        find(".admin_delete_3").click
        find(".admin_delete_1").click
        expect(User.find_by(id: 1).admin).to eq true
      end
    end

    context "管理者によるユーザーの登録機能に関して" do
      before "登録項目の入力" do
        FactoryBot.create(:user, admin:true)
        FactoryBot.create(:user, id:2, name:"user2",email:"test2@test.com",admin:true)
        visit new_task_path
        fill_in "Eメール", with: "user@user.com"
        fill_in "パスワード", with: "password"
        click_button "ログイン"
        click_on "管理者画面"
      end
      it "ユーザーの新規作成が行えているか" do
        click_on "ユーザー作成"
        fill_in "名前", with: "user3"
        fill_in "Eメール", with: "user3@user.com"
        check "管理者"
        fill_in "パスワード", with: "aaaaaa"
        fill_in "パスワード(再入力)", with: "aaaaaa"
        click_button "登録する"
        expect(page).to have_content "管理者：user1の部屋"
        expect(page).to have_content "user3"
      end
      it "ユーザー情報の編集が行えているか" do
        find(".edit_2").click
        fill_in "名前", with: "user2-1"
        fill_in "Eメール", with: "user2-1@user.com"
        fill_in "パスワード", with: "bbbbbb"
        fill_in "パスワード(再入力)", with: "bbbbbb"
        click_button "更新する"
        expect(page).to have_content "管理者：user1の部屋"
        expect(page).to have_content "user2-1"
        expect(User.find_by(id: 2).admin).to eq true
      end
    end
  
    context "管理者権限がないものは管理者画面に入れないか" do
      before "登録項目の入力" do
        FactoryBot.create(:user, admin:false)
        visit new_task_path
        fill_in "Eメール", with: "user@user.com"
        fill_in "パスワード", with: "password"
        click_button "ログイン"
      end
      it "管理者画面に遷移するボタンが表示されていないか" do
        expect(page).to_not have_content "管理者画面"
      end
      it "管理者画面に遷移するボタンが表示されていないか" do
        visit admin_user_path(1)
        expect(page).to have_content "ユーザー：user1の部屋"
      end
    end
  end
end
