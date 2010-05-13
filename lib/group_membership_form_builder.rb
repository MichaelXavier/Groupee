class GroupMembershipFormBuilder < ActionView::Helpers::FormBuilder
  def status_select(name, select_args={})
    puts GroupMembership::VALID_STATUSES.collect {|s| [s.titleize, s]}.inspect
    self.select(name, GroupMembership::VALID_STATUSES.collect {|s| [s.titleize, s]}, select_args)
  end
end
