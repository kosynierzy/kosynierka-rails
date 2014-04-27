class EntryDecorator < SimpleDelegator
  def not_seen!
    @seen = false
  end

  def seen!
    @seen = true
  end

  def seen?
    @seen
  end
end
