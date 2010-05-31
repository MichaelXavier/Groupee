module ApplicationHelper
  def bool_text(val)
    val ? "Yes" : "No"
  end

  def error_div(record, model_name=nil)
    model_name ||= record.class.name.downcase

    if record.errors.any?
      content_tag(:div, :id => 'errorExplanation') do
        content_tag(:h2, "#{pluralize(record.errors.count, "error")} prohibited this #{model_name} from being saved:")
        content_tag(:ul) do
          record.errors.full_messages.inject("") do |str, msg|
            str + content_tag(:li, msg)
          end
        end
      end
    end
  end

  def link_unless_currently_on(name, path, link_args={})
    link_to_unless((request.env['PATH_INFO'] == path), name, path, link_args)
  end
end
