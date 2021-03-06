class User < ApplicationRecord
  include Storext.model

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :zxcvbnable

  has_many :articles
  has_many :assignments
  has_many :roles, through: :assignments
  has_many :relationships
  has_many :scouts, through: :relationships

  before_save {self.email = email.downcase}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :username, presence: true,
            uniqueness: {case_sensitive: false},
            length: {minimum: 3, maximum: 25}
  validates :email, presence: true,
            length: {maximum: 128},
            uniqueness: {case_sensitive: false},
            format: {with: VALID_EMAIL_REGEX }

  store_attributes :settings do
    show_inactive_scouts Boolean, default: false
  end

  def role?(role)
    roles.any? { |r| r.name.underscore.to_sym == role }
  end

end
