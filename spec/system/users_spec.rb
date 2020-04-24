require 'rails_helper'
RSpec.describe 'ユーザー機能に関して', type: :system do
  describe 'ユーザー登録画面' do    
    context "ユーザー登録が行えるか" do
      before "登録項目の入力" do
        visit new_user_path
        fill_in "名前", with: "user_name"
        fill_in "Eメール", with: "test@test.com"
        fill_in "パスワード", with: "xxxxxx"
        fill_in "パスワード(再入力)", with: "xxxxxx"
        click_on "登録する"
      end
      it "ユーザー登録" do
        expect(page).to have_content "user_nameの部屋"
      end
    end
    context "ログイン機能に関して" do
      before "登録項目の入力" do
        FactoryBot.create(:user)
        visit new_task_path
        fill_in "Eメール", with: "user@user.com"
        fill_in "パスワード", with: "password"
        click_button "ログイン"
      end
      it "ログイン" do
        expect(page).to have_content "user1の部屋"
      end
    end
  end
end
