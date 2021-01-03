class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless url_valid?(value)
      record.errors[attribute] << (options[:message] || "must be a valid URL")
    end
  end

  def url_valid?(url)
    return true if url.blank?
    url = URI.parse(url) rescue false
    url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)
  end
end
