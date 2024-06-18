module ApplicationHelper
    def alert_class(key)
      case key
      when 'notice' then 'alert alert-success'
      when 'alert' then 'alert alert-warning'
      when 'error' then 'alert alert-danger'
      else "alert alert-#{key}"
      end
    end
end
