module ApplicationHelper
  def flash_class(level)
    case level
    when :notice then "alert-info"
    when :error then "alert-error"
    when :alert then "alert-warning"
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

  def field_status(resource, field)
    'has-error' if resource.errors.has_key? field
  end

  def field_status_message(resource, field)
    if resource.errors.has_key? field
      status_message = resource.errors.full_message(field, resource.errors.get(field)[0])
      raw('<span class="help-block">'+status_message+'</span>')
    else
      ''
    end
  end
end
