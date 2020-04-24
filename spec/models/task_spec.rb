require 'rails_helper'

RSpec.describe Task, type: :model do
  before do
    FactoryBot.create(:user)
  end
  it "【Validation】titleが空ならバリデーションが通らない" do
    task = FactoryBot.build(:task, title: "")
    expect(task).not_to be_valid
  end
  it "【Validation】contentが空ならバリデーションが通らない" do
    task = FactoryBot.build(:task, content: "")
    expect(task).not_to be_valid
  end
  it "【Scope】titleに部分一致の検索が行えているか" do
    FactoryBot.create(:task, id: 1, title: "hoge")
    FactoryBot.create(:task, id: 2, title: "test")
    FactoryBot.create(:task, id: 3, title: "huga")
    task1 = Task.all.title_include("ho")
    task2 = Task.all.title_include("es")
    task3 = Task.all.title_include("ga")
    expect(task1.first.id).to eq 1
    expect(task2.first.id).to eq 2
    expect(task3.first.id).to eq 3
  end
  it "【Scope】statusの完全一致の検索が行えているか" do
    FactoryBot.create(:task, id: 1, status: 0)
    FactoryBot.create(:task, id: 2, status: 1)
    FactoryBot.create(:task, id: 3, status: 2)
    FactoryBot.create(:task, id: 4, status: 3)
    task1 = Task.all.status_equal("2").first
    expect(task1.id).to eq 3
  end
  it "【Scope】priorityの完全一致の検索が行えているか" do
    FactoryBot.create(:task, id: 1, priority: 0)
    FactoryBot.create(:task, id: 2, priority: 1)
    FactoryBot.create(:task, id: 3, priority: 2)
    task1 = Task.all.priority_equal("2").first
    expect(task1.id).to eq 3
  end
  it "【Scope】created_atのOrderByが効いているか" do
    FactoryBot.create(:task, id: 1, created_at: Time.current + 1.days)
    FactoryBot.create(:task, id: 2, created_at: Time.current + 4.days)
    FactoryBot.create(:task, id: 3, created_at: Time.current + 2.days)
    FactoryBot.create(:task, id: 4, created_at: Time.current + 3.days)
    expect(Task.all.created_before.map(&:id)).to eq [2,4,3,1]
  end
  
  it "【Method】limitのOrderByが効いているか" do
    FactoryBot.create(:task, id: 1, limit: Time.current + 1.days)
    FactoryBot.create(:task, id: 2, limit: Time.current + 4.days)
    FactoryBot.create(:task, id: 3, limit: Time.current + 2.days)
    FactoryBot.create(:task, id: 4, limit: Time.current + 3.days)
    expect(Task.all.order_by("limit","DESC").map(&:id)).to eq [2,4,3,1]
  end
  it "【Method】order_byの引数がnilの時、created_atのOrderByが効いているか" do
    FactoryBot.create(:task, id: 1, created_at: Time.current + 1.days)
    FactoryBot.create(:task, id: 2, created_at: Time.current + 4.days)
    FactoryBot.create(:task, id: 3, created_at: Time.current + 2.days)
    FactoryBot.create(:task, id: 4, created_at: Time.current + 3.days)
    expect(Task.all.order_by(nil,nil).map(&:id)).to eq [2,4,3,1]
  end
end
