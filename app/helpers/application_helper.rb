# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def error_on(model, field)
    if error?(model, field)
      "<div class='formError'>" +
      "#{field.to_s.titleize} #{model.errors[field]}"+
      "</div>"
    end
  end
  
  def error?(model, field)
    !model.errors[field].blank?
  end
  
end
