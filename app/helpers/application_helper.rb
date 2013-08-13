module ApplicationHelper
  def flash_class(level)
    case level
    when :notice then "info"
    when :error then "error"
    when :alert then "warning"
    end
  end

  def session_status_class(status)
    case status
    when CourseSession::PENDING then "warning"
    when CourseSession::OPEN then "success"
    when CourseSession::WAITLIST then "warning"
    when CourseSession::FULL then "danger"
    when CourseSession::CLOSED then "danger"
    end
  end
end
