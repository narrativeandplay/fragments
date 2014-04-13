def login(user, use_login_form = true)
  if use_login_form
    within('nav.top-bar') { click_link 'Login' }
    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_button "Login"
  else
    sign_in user
  end
end

def fill_in_ckeditor(locator, opts)
  content = opts.fetch(:with).to_json
  page.execute_script <<-SCRIPT
    CKEDITOR.instances['#{locator}'].setData(#{content});
    $('textarea##{locator}').text(#{content});
  SCRIPT
end