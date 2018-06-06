class User < ActiveRecord::Base
  validates_presence_of :name, :email, :password

  def initialize(params)
    @name = params[:name]
    @email = params[:email]
    @password = params[:password]
  end
end