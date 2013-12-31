FactoryGirl.define do
  factory :user, aliases: [:author, :creator] do
    sequence(:username) { |n| "User#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password "foobar123"
    password_confirmation "foobar123"
  end
  
  factory :story do
    sequence(:title) { |n| "Story #{n}" }
    creator
  end
  
  factory :fragment, aliases: [:parent] do
    content "Lorem Ipsum"
    author
    story
    parent nil
  end
end