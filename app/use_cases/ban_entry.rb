class BanEntry
  attr_reader :user, :entry_id

  def initialize(user, entry_id)
    @user = user
    @entry_id = entry_id
  end

  def call
    authorize!

    entry = Entry.find(entry_id)
    entry.banned_by = user
    entry.banned_at = Time.now
    entry.save
  end

  private

  def authorize!
    fail PermissionError, user unless user.moderator?
  end
end
