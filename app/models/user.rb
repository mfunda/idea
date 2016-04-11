class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ROLES = { 'User' => nil, 'Admin' => 'Admin'}

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :categories
  has_many :pages

  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :login, presence: true, length: { maximum: 255 }, uniqueness: true
  validates :email, presence: true, length: { maximum: 255 }, format: { with: Devise::email_regexp }, uniqueness: true  
  validates :role, inclusion: { in: ROLES.values }

  has_attached_file :avatar, styles: { large: "550x450>", medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/


  before_validation :downcase_email
  self.inheritance_column = :role

  private

	  def downcase_email
	  	self.email = self.email.try(:downcase)
	  end

end
