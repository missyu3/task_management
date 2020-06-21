require 'rails_helper'
RSpec.describe 'ラベル機能に関して', type: :system do
  before "ログイン" do
    create(:user, admin: true)
    visit new_task_path
    fill_in "Eメール", with: "user@user.com"
    fill_in "パスワード", with: "password"
    click_button "ログイン"
    click_on "管理者画面"
  end
  describe '新規作成画面' do    
    context "ラベル機能に関して" do
      before "ラベル作成画面に遷移" do
        click_on "ラベル作成"
      end
      it "新規登録" do
        fill_in "名称", with: "Ruby"
        click_button "登録する"
        expect(page).to have_content "Ruby"
      end
      it "すでに登録されているラベルを入力した時のエラー" do
        create(:label, name: "Ruby")
        fill_in "名称", with: "Ruby"
        click_button "登録する"
        expect(page).to have_content "名称はすでに存在します"
      end
      it "ラベルが空の時のエラー" do
        create(:label, name: "Ruby")
        click_button "登録する"
        expect(page).to have_content "名称を入力してください"
      end
    end
  end
  describe '一覧画面' do    
    context "ラベル機能に関して" do
      before "ラベルデータ作成" do
        create(:label, name: "Ruby")
        create(:label, name: "Python")
        create(:label, name: "Go")
      end
      it "ラベルが空の時のエラー" do
        click_on "ラベル一覧"
        expect(page).to have_content "Ruby"
        expect(page).to have_content "Python"
        expect(page).to have_content "Go"
      end
    end
  end
end
