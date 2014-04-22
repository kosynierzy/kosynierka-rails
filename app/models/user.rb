class User < ActiveRecord::Base
  include Gravtastic

  has_gravatar

  has_many :entries
end
