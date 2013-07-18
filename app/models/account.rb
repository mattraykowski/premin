class Account < ActiveRecord::Base
  has_many :users

  belongs_to :owner, class_name: "User", foreign_key: "user_id"

  attr_accessible :subdomain
  attr_accessor :owner

  VALID_SUBDOMAIN_FORMAT = /^(?![0-9]+$)(?!-)[a-zA-Z0-9-]{,63}(?<!-)$/i
  validates :subdomain, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_SUBDOMAIN_FORMAT }

  CAN_SIGN_UP = Rails.application.config.allow_account_sign_up
end
