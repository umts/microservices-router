FactoryGirl.define do
  factory :model do
    sequence(:name) { |n| "Model #{n}" }
    service
  end
end
