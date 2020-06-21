require 'rails_helper'

RSpec.describe User, type: :model do
  it "ユーザーが削除された時、紐づくTaskも消えるか確認" do
    user = create(:user, admin:true)
    create(:user, id:2, name:"user2",email:"test2@test.com",admin:true)
    create(:task, user_id:user.id)
    create(:task, user_id:user.id)
    user.destroy
    expect(Task.all.count).to eq 0
  end
end
