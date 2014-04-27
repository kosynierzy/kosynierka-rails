class User < ActiveRecord::Base
  include Gravtastic

  has_gravatar

  has_many :entries
  belongs_to :last_seen_entry, class_name: 'Entry'

  def last_seen_entry_at
    if last_seen_entry
      last_seen_entry.created_at
    else
      Date.new(2012, 5, 13)
    end
  end
end
