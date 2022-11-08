FactoryBot.define do
  factory :task do
    title { 'test_title1' }
    detail { 'test_detail' }
    deadline_at { '2022/11/11' }
    status { 'waiting' }
    priority { '高' }
    association :user
  end
end