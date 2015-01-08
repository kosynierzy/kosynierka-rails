class Authorize
  def initialize(id, info, options = {})
    @id, @info = id, info
    @user_repo = options.fetch(:user_repo) { default_user_repo }
  end

  def call
    if user = user_repo.find_by(id: id)
      update(user)
    else
      create
    end
  end

  private

  attr_reader :id, :info, :user_repo

  def default_user_repo
    User
  end

  def update(user)
    user.update_attributes!(user_attrs)
    user
  end

  def create
    user_repo.new(user_attrs) do |user|
      user.id = id
      user.save!
    end
  end

  def user_attrs
    {
      email: info[:email],
      username: info[:username],
      roles: info[:roles]
    }
  end
end
