class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ROLES = { 'User' => nil, 'Admin' => 'Admin'}

  has_many :posts, dependent: :destroy

  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :login, presence: true, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: Devise::email_regexp }, uniqueness: true  
  validates :role, inclusion: { in: ROLES.values }


  before_validation :downcase_email
  self.inheritance_column = :role

  private

	  def downcase_email
	  	self.email = self.email.try(:downcase)
	  end

end
