FactoryBot.define do
  factory :user_first, class: User do
    name { "newuser11" }
    email { "newuser11@sample.com" }
    password { "newuser11" }
    password_confirmation{"newuser11"}
    admin {true}
  end

  factory :user do
    name { "newuser1" }
    email { "newuser1@sample.com" }
    password { "newuser1" }
    password_confirmation{"newuser1"}
    admin {false}
  end
end