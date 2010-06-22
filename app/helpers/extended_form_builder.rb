class ExtendedFormBuilder < ActionView::Helpers::FormBuilder
  include ActionView::Helpers::TagHelper

  # FIXME: the block does not go to the content of the label for some reason
  def required_label(method, text=nil)
    text ||= method.to_s.titleize
    #label(method) do 
    #  "#{text}#{content_tag(:abbr, '*', :title => 'Required Field')}"
    #end
    label(method,text)
  end
end
