module UsersHelper
  # Check out omniauth for carrying over profile data from Facebook/Twitter/etc.
  def avatar_url(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      default_url = 'identicon'   # E.g. "#{root_url}images/guest.png", retro
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "//gravatar.com/avatar/#{gravatar_id}.png?s=48&d=#{default_url}"
    end
  end
end
