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
    tag(:img, src: resource.default_index_thumb, alt: resource.title)
  end

  def array_to_params(array)
    array.map(&:item.parameterize)
  end

  def array_to_param_hash(array, invert = false, keys_only = false)
    hash = {}
    array.map { |tag| hash[tag.parameterize] = tag }
    hash = invert ? hash.invert : hash
    keys_only ? hash.keys : hash
  end
end
