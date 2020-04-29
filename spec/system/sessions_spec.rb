require 'rails_helper'
RSpec.describe 'ログイン機能に関して', type: :system do
  describe 'ログイン画面' do    
    context "ログイン機能に関して" do
      before "登録項目の入力" do
        create(:user)
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
