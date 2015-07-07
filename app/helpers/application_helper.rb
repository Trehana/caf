# ApplicationHelper
module ApplicationHelper
  def content(c)
    Shortcode.process(c)
  end

  def content_html(c)
    raw content(c)
  end

  def preview_text(content, limit)
    return if content.nil? || content.empty?
    content = content.split(' ')
    content.count > limit ? "#{content[0..(limit - 1)].join(' ')}..." : content.join(' ')
  end

  def list_tags(resoruce)
    return unless resoruce.tags
    tag_names = []
    resoruce.tags.each do |tag|
      tag_names << tag.to_s.upcase
    end
    tag_names.join(', ')
  end

  def default_resource_image(resource)
    default_resource_image = resource.default_image ? resource.default_image : asset_path('placeholder.png')
    tag(:img, src: default_resource_image, alt: resource.title)
  end
end
