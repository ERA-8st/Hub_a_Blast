module ApplicationHelper

  def unchecked_notifications
    @unchecked_notifications = current_user.passive_notifications.where(checked: false)
  end

  def escaped_guest_login_link
    guest_login_link = 'click here' + "\n" + 'to login' + "\n" 'as a guest'
    escaped_guest_login_link = h(guest_login_link).gsub(/\R/, "<br>")
  end

  def set_image(target,size,with_link,adaptive_background)
    if target.images.any?
      adaptive_background ? image = image_tag(target.images[size]["url"], "data-adaptive-background" => '1') : image = image_tag(target.images[size]["url"])
    else
      image = image_tag("default.jpg")
    end
    with_link ? (link_to image, send("user_spotify_#{target.type}_show_path", id: target.id)) : image
  end

  def set_song_image(target,size,with_link,adaptive_background)
    if target.album.images.any?
      adaptive_background ? image = image_tag(target.album.images[size]["url"], "data-adaptive-background" => '1') : image = image_tag(target.album.images[size]["url"])
    else
      image = image_tag("default.jpg")
    end
    with_link ? (link_to image, send("user_spotify_song_show_path", id: target.id)) : image
  end

end
