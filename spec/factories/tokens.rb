FactoryGirl.define do
  factory :token do
    expires_at "2016-04-16 09:08:28"
    association :user, factory: :user
  end
end
