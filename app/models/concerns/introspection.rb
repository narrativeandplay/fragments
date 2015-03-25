module Introspection
  extend ActiveSupport::Concern

  class_methods do
    def get_maximum(attribute)
      validators_on(attribute).select{|v| v.class == ActiveModel::Validations::LengthValidator}.first.options[:maximum]
    end
  end
end
