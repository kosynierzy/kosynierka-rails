class UnknownFieldError < RuntimeError
  def initialize(name)
    @name = name
  end

  def to_s
    "#{@name} given, but not declared in the form."
  end
end
