class ListEntries
  attr_reader :user, :page

  def initialize(user, page)
    @user = user
    @page = page
  end

  def call
    list = get_list
    yield list if block_given?
    update_last_seen!(list.first)
    list
  end

  private

  def get_list
    if user && user.moderator?
      all_list
    else
      legal_list
    end
  end

  def legal_list
    Entry.joins(:user).legal.order('created_at DESC').page(page)
  end

  def all_list
    Entry.joins(:user).order('created_at DESC').page(page)
  end

  # TODO: move to service
  def update_last_seen!(entry)
    return unless user
    user.update(last_seen_entry_id: entry.id) unless entry.seen?(user)
  end
end
