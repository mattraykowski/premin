# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course_session do
    name "Summer"
    status 1
    total_capacity 10
    waitlist_capacity 5
  end
end
