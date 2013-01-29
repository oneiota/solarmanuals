class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :company, :accreditation
  
  validates_presence_of :first_name, :last_name, :company, :accreditation
  
  has_many :manuals
  has_one :payment, :as => :payable
  
  
  def full_name
    "#{first_name} #{last_name}"
  end
end
