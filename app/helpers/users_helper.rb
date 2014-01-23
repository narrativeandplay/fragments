module UsersHelper
  def gravatar_for(user, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]

    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&d=identicon"
    
    image_tag gravatar_url, alt: user.username, class: 'gravatar', size: "#{size}x#{size}"
  end
  
  def default_description(user)
    "#{user == current_user ? "You have" : "This user has" } created #{user.stories.count} stories, authored #{user.fragments.count} fragments, and contributed to #{user.fragments.pluck(:story_id).uniq.count} stories."
  end
  
  def is_current_user?
    current_user == @user
  end
end
