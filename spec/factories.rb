FactoryGirl.define do
  factory :user, aliases: [:author, :creator] do
    sequence(:username) { |n| "User#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password "foobar123"
    password_confirmation "foobar123"
  end
end