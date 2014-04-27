class TimelinePage
  attr_reader :user, :entries, :new_entry, :decorated_entries

  def initialize(user, entries)
    @user, @entries = user, entries
    @new_entry = Entry.new

    decorate!
  end

  private

  def decorate!
    @decorated_entries = @entries.inject([]) do |entries, entry|
      entries << EntryPresenter.new(entry, entry.seen?(user))
      entries
    end
  end

  class EntryPresenter
    def initialize(entry, seen)
      @entry, @seen = entry, seen
    end

    def id
      entry.id
    end

    def content
      entry.content_html
    end

    def created_at
      entry.created_at
    end

    def seen?
      @seen
    end

    def banned?
      entry.banned?
    end

    def user
      entry.user
    end

    def ban_url
      "/entries/#{entry.id}/ban"
    end

    def ban_url_options
      if entry.banned?
        { method: :delete }
      else
        {}
      end
    end

    def ban_submit_label
      if entry.banned?
        I18n.t('entry.remove_ban')
      else
        I18n.t('entry.ban')
      end
    end

    private

    attr_reader :entry
  end
end
