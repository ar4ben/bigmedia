class AdminUser < ActiveRecord::Base
  rolify :before_add => :before_add_method
  after_create :assign_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable, :lockable
         
  def assign_default_role
    self.add_role(:moderator) if self.roles.blank?
  end  

  def before_add_method(role)
    self.roles = []
  end       
end
