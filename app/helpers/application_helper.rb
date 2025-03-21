module ApplicationHelper
  def delete_button_to(text, path, options = {})
    button_to text, path, 
      method: :delete,
      class: "text-red-600 hover:text-red-900 #{options[:class]}",
      data: { 
        turbo_confirm: "Are you sure you want to delete this record? This action cannot be undone.",
        turbo: true
      }.merge(options[:data] || {})
  end
end
