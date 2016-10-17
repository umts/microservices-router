FactoryGirl.define do
  factory :service do
    sequence(:url) { |n| "https://www.example.com/#{n}" }
  end
end
