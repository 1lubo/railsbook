# frozen_string_literal: true

class InvitationsController < ApplicationController
  def index
    # @invitations = current_user.invitations.all
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

  # def send_inviation
  #  current_user.send_inviation(params[:user_id])
  #  flash[:success] = 'Friend invite sent!'
  #  redirect_to user_invitations_path(current_user.id)
  # end
end
