class User < ActiveRecord::Base
  # Associations
  belongs_to :account

  # Devise Configuration
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name, :account_id, :is_site_admin, :account_name, :account_subdomain
  attr_accessor :account_name, :account_subdomain

  # Setup validations
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :account_subdomain, 
              presence: { message: "Subdomain name must not be blank" }, 
              on:  :create
  validates :account_name, 
              presence: { message: "Account name must not be blank" }, 
              on:  :create

  # Callbacks
  before_save { email.downcase! }
  before_validation :create_account, on: :create
  after_create :update_account_owner


  # Create an account on creating a new user.
  # If the 'account_name' does not exist process it as a sign up.
  def create_account
    if self.account_subdomain.blank?
      return
    end

    account = Account.find_by_subdomain(self.account_subdomain)
    if account.nil?
      self.account = Account.create!(subdomain: self.account_subdomain, name: self.account_name)
    else
      self.account_subdomain = "" if !Account::CAN_SIGN_UP
    end
  end

  def update_account_owner
    account = self.account
    if account && account.owner.nil?
      account.owner = self
      self.is_site_admin = true
      self.save
      account.save
    end
  end
end
