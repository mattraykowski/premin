class Course < ActiveRecord::Base
  attr_accessible :age_group, :class_time_description, :days_description, :long_description, :name, :tuition_description

  belongs_to :account

  validates :name, presence: true
  validates :account, presence: true
end
