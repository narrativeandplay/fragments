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