# A sample Guardfile
# More info at https://github.com/guard/guard#readme
require 'active_support/inflector'

guard :rspec, cmd: 'spring rspec', all_on_start: true, after_all_pass: false do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }

  # Rails example
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/(.*)(\.erb|\.haml|\.slim)$})          { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
  watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
  watch('config/routes.rb')                           { "spec/routing" }
  watch('app/controllers/application_controller.rb')  { "spec/controllers" }

  # Capybara features specs
  watch(%r{^app/views/(.+)/.*\.(erb|haml|slim)$})     { |m| "spec/features/#{m[1]}_spec.rb" }
  watch(%r{^app/views/(.+)/.*\.(erb|haml|slim)$})     { |m| "spec/requests/#{m[1]}_spec.rb" }
  watch(%r{^app/views/(.+)/.*\.(erb|haml|slim)$})     { |m| "spec/requests/#{m[1].singularize}_pages_spec.rb" }
  watch(%r{^app/views/fragments/.*\.(erb|haml|slim)$})     { "spec/requests/story_pages_spec.rb" }

  # Turnip features and steps
  watch(%r{^spec/acceptance/(.+)\.feature$})
  watch(%r{^spec/acceptance/steps/(.+)_steps\.rb$})   { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'spec/acceptance' }
end

guard 'rails', CLI: 'rails server --binding 127.0.0.1' do
  watch('Gemfile.lock')
  watch(%r{^(config|lib)/.*})
end

