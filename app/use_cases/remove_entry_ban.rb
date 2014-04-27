class RemoveEntryBan
  attr_reader :user, :entry_id

  def initialize(user, entry_id)
    @user = user
    @entry_id = entry_id
  end

  def call
    authorize!

    entry = Entry.find(entry_id)
    entry.banned_by = nil
    entry.banned_at = nil
    entry.save

    notify!(entry) if Rails.application.secrets.hipchat_notifications
  end

  private

  def authorize!
    fail PermissionError, user unless user.moderator?
  end

  def notify!(entry)
    hipchat = HipchatNotification.new
    options = { notify: true, color: 'yellow' }
    hipchat.send("Ban removed from entry #{entry.id} banned by #{user.username}", options)
  end
end
