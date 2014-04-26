class CreateEntryForm
  include Virtus.model
  include ActiveModel::Validations

  attribute :content, String

  validates :content, presence: true

  def initialize(args, &block)
    args.each_key do |key|
      raise UnknownFieldError, key unless respond_to?("#{key}=")
    end

    super
  end

  def validate!
    raise ValidationError, errors unless valid?
  end
end
