module ApplicationHelper
  def active_class(path)
    :active if current_page? path
  end

  def fa_icon(icon, opts = {})
    content_tag(
      :i,
      nil,
      class: ([:far, "fa-#{icon}"] << opts[:class]),
      data: opts[:data]
    )
  end

  def blog(text)
    text = '' if text.nil?
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: true)
    raw markdown.render(text)
  end

  def formatted_amount(amount)
    number_to_currency amount.to_i / 100.0
  end
end
