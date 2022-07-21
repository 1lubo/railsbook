# frozen_string_literal: true

class User < ApplicationRecord
  has_many :invitations
  has_many :pending_invitations, -> { where confirmed: false },
           class_name: 'Invitation', foreign_key: 'friend_id'
  has_many :posts
  has_many :comments
  has_many :likes, dependent: :destroy

  validates :username, presence: true, on: :create

  attr_writer :login

  def login
    @login || username || email
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions).where(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end

  def friends
    friends_i_sent_invitation = Invitation.where(user_id: id, confirmed: true).pluck(:friend_id)
    friends_i_got_invitation = Invitation.where(friend_id: id, confirmed: true).pluck(:user_id)
    ids = friends_i_sent_invitation + friends_i_got_invitation
    User.where(id: ids)
  end

  def friend_with?(user)
    Invitation.confirmed_record?(id, user.id)
  end

  def send_inviation(user)
    invitations.create(friend_id: user.id)
  end
end
