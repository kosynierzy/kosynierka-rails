class ValidationError < RuntimeError
  attr_reader :errors

  def initialize(errors)
    @errors = errors
    super
  end
end
