class CourseSession < ActiveRecord::Base
  PENDING  = 0
  OPEN     = 1
  WAITLIST = 2
  FULL     = 3
  CLOSED   = 4

  STATUSES = {
    PENDING  => "Pending",
    OPEN     => "Enrollment Open",
    WAITLIST => "Waitlist",
    FULL     => "Course Full",
    CLOSED   => "Enrollment Closed"
  }
  def self.valid_statuses
    STATUSES.keys
  end

  def status_description
    STATUSES[status]
  end

  belongs_to :course
  attr_accessible :name, :status, :total_capacity, :waitlist_capacity

  # Validations
  validates :name, presence: true
  validates :course, presence: true
  validates :status, inclusion: { in: STATUSES.keys }, presence: true

  scope :by_course, lambda { |course| where("course_sessions.course_id = ?", course.id) }
end
