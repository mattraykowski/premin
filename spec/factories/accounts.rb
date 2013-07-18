# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :account do
    subdomain "subdomain"
  end
  factory :account_owned, class: Account do
    subdomain "subdomain-owned"
  end
end
