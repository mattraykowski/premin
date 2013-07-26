# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    name "MyString"
    days_description "MyText"
    class_time_description "MyString"
    age_group "MyString"
    tuition_description "MyString"
    long_description "MyText"
  end
end
