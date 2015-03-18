module ActiveRecord::CustomMethods
  extend ActiveSupport::Concern

  module ClassMethods
    def get_maximum(attribute)
      validators_on(attribute).select{|v| v.class == ActiveModel::Validations::LengthValidator}.first.options[:maximum]
    end
  end
end

# include the extension
ActiveRecord::Base.send(:include, ActiveRecord::CustomMethods)
