# frozen_string_literal: true

class InvitationsController < ApplicationController
  def index
    open_requests = current_user.invitations.map(&:friend_id)
    @not_friends = []
    User.all.each do |user|
      unless current_user.friend_with?(user) || user.id == current_user.id ||
             open_requests.include?(user.id)
        @not_friends << user
      end
    end
    @not_friends
  end
end
