class MyFormBuilder < ActionView::Helpers::FormBuilder
  def label(method, text = nil, options = {}, &block)
    errors = object.errors[method.to_sym]
    if errors
      text += " <span class=\"error\">#{errors.first}</span>"
    end
    @template.label(@object_name, method, text.html_safe, objectify_options(options), &block)
  end
end

