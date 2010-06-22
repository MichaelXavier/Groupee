class GroupMembershipFormBuilder < ActionView::Helpers::FormBuilder
  #TODO: figure out how to have it turn on the current value for edit form
  def status_select(name, select_args={})
    self.select(name, GroupMembership::VALID_STATUSES.collect {|s| [s.titleize, s]}, select_args)
  end

  def course_select(name, groups, select_args={})
    raise NotImplementedError
  end
end
