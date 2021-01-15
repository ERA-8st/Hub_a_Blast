module ApplicationHelper

  def unchecked_notifications
    @unchecked_notifications = current_user.passive_notifications.where(checked: false)
  end

  def escaped_guest_login_link
    guest_login_link = 'click here' + "\n" + 'to login' + "\n" 'as a guest'
    escaped_guest_login_link = h(guest_login_link).gsub(/\R/, "<br>")
  end

end
