FactoryGirl.define do
  factory :user do
    name     "A. Guy"
    email    "some0@guy.com"
    password "foobar"
    password_confirmation "foobar"
  end
end
