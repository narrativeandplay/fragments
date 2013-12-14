module ApplicationHelper
  def title(title)
    application_name = Rails.application.class.parent_name.underscore.titleize

    if title.empty?
      application_name
    else
      "#{application_name} | #{title}"
    end
  end
end
