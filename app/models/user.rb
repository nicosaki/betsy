class User < ActiveRecord::Base
  require "net/http"

  has_many :cart_items
  validates_confirmation_of :username, :password
  validates_confirmation_of :email,
                          message: 'should match confirmation'
  validates :username, presence: true
  validates :email, presence: true, uniqueness: true

  has_secure_password

  def self.log_in(email, password)
    somebody = User.find_by(email: email.downcase)
    somebody && somebody.authenticate(password)
  end

  def profile_pic
    url = self.photo_url
    if url != nil || url != ""
      "http://images.cdn4.stockunlimited.net/clipart/add-user-icon_1598354.jpg"
    else
      url
    end
  end

  def current_user?(current_user)
    return false if current_user == nil
    current_user.id == self.id ? true : false
  end

end
