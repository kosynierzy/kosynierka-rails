class PermissionError < RuntimeError
  attr_reader :user

  def initialize(user)
    @user = user
    super
  end
end
