class CreateEntry
  attr_reader :user, :form

  def initialize(user, form)
    @user, @form = user, form
  end

  def call
    form.validate!

    entry = user.entries.new
    entry.content = form.content
    entry.content_html = markdown.render(entry.content)

    yield entry if block_given?

    entry.save
    entry
  end

  private

  def markdown
    @markdown ||= Redcarpet::Markdown.new(markdown_renderer, markdown_extensions)
  end

  def markdown_renderer
    Redcarpet::Render::HTML.new({
      filter_html: true,
      link_attributes: { target: '_blank' }
    })
  end

  def markdown_extensions
    {
      autolink: true,
      strikethrough: true,
      space_after_headers: true,
      highlight: true,
      quote: true
    }
  end
end
