class EntriesController < ApplicationController
  before_action :authenticate_user!

  respond_to :html

  def create
    @entry = current_user.entries.new(entry_params)
    @entry.content_html = markdown.render(@entry.content)
    @entry.save

    respond_with(@entry) do |format|
      format.html { redirect_to root_path }
    end
  end

  private

  def entry_params
    params.require(:entry).permit(:content)
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
