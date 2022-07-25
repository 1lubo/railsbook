# frozen_string_literal: true

module ApplicationHelper
  def user_avatar(user, size = 40)
    if user.avatar.attached?
      user.avatar.variant(resize_to_limit: [size, size])
    else
      current_user.gravatar_url(size: size)
    end
  end
end
