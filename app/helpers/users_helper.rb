module UsersHelper
  
  def avatar_tag(user, size)
    size_map = { "small" => 30, "medium" => 40, "large" => 50, "x-large" => 120 }
    
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_size = size_map[size]
    default_style = 'identicon'
    
    image_url = user.avatar_url ||
        "//gravatar.com/avatar/#{gravatar_id}?" +
        "s=#{gravatar_size}&d=#{default_style}"
    
    image_tag(image_url, class: "avatar-#{size}", title: user.name)
  end
  
  def avatar_and_name_tag(user, size)    
    content_tag :div, class: "user-avatar-#{size}" do
      avatar_tag(user, size) + content_tag("span", user.name)
    end
  end
  
end
