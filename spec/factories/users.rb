FactoryGirl.define do
  factory :user do
    email "test@user.com"
    name "example user"
    account_name "test"
    account_subdomain "test"
    password "testpassword"
    password_confirmation "testpassword"
  end

  factory :user2, class: User do
    email "test2@user.com"
    name "example user 2"
    password "testpassword"
    password_confirmation "testpassword"
  end

  factory :user_owning_account, class: User do
    email "test3@user.com"
    name "example user 3"
    account_subdomain "subdomain-owned"
    account_name "subdomain-owned name"
    password "testpassword"
    password_confirmation "testpassword"
  end


end

