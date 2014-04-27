class Entry < ActiveRecord::Base
  belongs_to :user
  belongs_to :banned_by, class_name: User, foreign_key: 'banned_by'

  scope :legal, -> { where(banned_by: nil) }

  def banned?
    banned_by.present?
  end

  def seen?(user)
    return true unless user
    user.last_seen_entry_at >= created_at
  end
end
