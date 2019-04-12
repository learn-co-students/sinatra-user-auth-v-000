class User < ActiveRecord::Base
  validates_presence_of :name, :email, :password  #validate erros or empty inputs. ActiveRecord thing.
end
