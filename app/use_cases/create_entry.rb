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

    notify!(entry) if Rails.application.secrets.hipchat_notifications

    entry
  end

  private

  def notify!(entry)
    hipchat = HipchatNotification.new
    options = { notify: true, color: 'green', message_format: 'html' }
    hipchat.send("New entry #{entry.id} by #{user.username}<br>#{entry.content_html}", options)
  end

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
