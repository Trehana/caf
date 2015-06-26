# ApplicationHelper
module ApplicationHelper
  def content(c)
    Shortcode.process(c)
  end

  def content_html(c)
    raw content(c)
  end

  def preview_text(content, limit)
    content = content.split(' ')
    content.count > limit ? "#{content[0..(limit - 1)].join(' ')}..." : content.join(' ')
  end
end
