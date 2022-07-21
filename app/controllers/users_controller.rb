# frozen_string_literal: true

class UsersController < ApplicationController
  def index; end

  def send_inviation
    new_friend = User.find(params[:format])
    current_user.send_inviation(new_friend)
    flash[:success] = 'Friend invite sent!'
    redirect_to user_invitations_path(current_user.id)
  end

  def accept_invitation
    @invitation = Invitation.find(params[:format])
    @invitation.confirmed = true
    @invitation.save
    flash[:success] = 'Friendship confirmed'
    redirect_to user_invitations_path(current_user.id)
  end

  def reject_invitation
    @invitation = Invitation.find(params[:format])
    @invitation.destroy
    flash[:success] = 'Friendship rejected'
    redirect_to user_invitations_path(current_user.id), status: :see_other
  end
end
