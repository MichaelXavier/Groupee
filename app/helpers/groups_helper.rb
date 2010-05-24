module GroupsHelper
  def group_status_style(status)
    case status
    when "active"    then "active_group"
    when "suspended" then "suspended_group"
    when "closed"    then "closed_group"
    else ""
    end
  end
end
