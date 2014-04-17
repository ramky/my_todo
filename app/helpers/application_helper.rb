module ApplicationHelper
  def twitterized_type(type)
    case type
    when :alert
      "alert-block"
    when :error
      "alert-danger"
    when :notice
      "alert-info"
    when :success
      "alert-success"
    else
      type.to_s
    end
  end

  def my_form_for(record, options = {}, &proc)
    form_for(record, options.merge!({builder: MyFormBuilder}), &proc)
  end
end
