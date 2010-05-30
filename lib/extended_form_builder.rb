class ExtendedFormBuilder < ActionView::Helpers::FormBuilder
  def required_label(method, text=nil)
    text ||= method.to_s.titleize
    self.label(method) do
      text + tag(:abbr, :title => 'Required Field') {'*'}
    end
  end
end
