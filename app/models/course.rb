class Course < ActiveRecord::Base
  attr_accessible :age_group, :class_time_description, :days_description, :long_description, :name, :tuition_description

  belongs_to :account
  has_many :course_sessions

  validates :name, presence: true
  validates :account, presence: true

  scope :by_account, lambda { |acct| where("courses.account_id = ?", acct.id) }
end
