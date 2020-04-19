require 'rails_helper'

RSpec.describe Task, type: :model do
  it "titleが空ならバリデーションが通らない" do
    task = FactoryBot.build(:task, title: "")
    expect(task).not_to be_valid
  end
  it "contentが空ならバリデーションが通らない" do
    task = FactoryBot.build(:task, content: "")
    expect(task).not_to be_valid
  end
  it "created_atのOrderByが効いているか" do
    FactoryBot.create(:task, id: 1, created_at: Time.current + 1.days)
    FactoryBot.create(:task, id: 2, created_at: Time.current + 4.days)
    FactoryBot.create(:task, id: 3, created_at: Time.current + 2.days)
    FactoryBot.create(:task, id: 4, created_at: Time.current + 3.days)
    expect(Task.all.order_by("created_at","DESC").map(&:id)).to eq [2,4,3,1]
  end
  it "limitのOrderByが効いているか" do
    FactoryBot.create(:task, id: 1, limit: Time.current + 1.days)
    FactoryBot.create(:task, id: 2, limit: Time.current + 4.days)
    FactoryBot.create(:task, id: 3, limit: Time.current + 2.days)
    FactoryBot.create(:task, id: 4, limit: Time.current + 3.days)
    expect(Task.all.order_by("limit","DESC").map(&:id)).to eq [2,4,3,1]
  end
  it "引数がnilの時、created_atのOrderByが効いているか" do
    FactoryBot.create(:task, id: 1, created_at: Time.current + 1.days)
    FactoryBot.create(:task, id: 2, created_at: Time.current + 4.days)
    FactoryBot.create(:task, id: 3, created_at: Time.current + 2.days)
    FactoryBot.create(:task, id: 4, created_at: Time.current + 3.days)
    expect(Task.all.order_by(nil,nil).map(&:id)).to eq [2,4,3,1]
  end
end
