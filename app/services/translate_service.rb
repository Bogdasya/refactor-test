class TranslateService
  def self.translate_text(content, translate_to)
    translation_title = parse_response_with_translate(response_with_translate(content.title, translate_to))
    translation_content = parse_response_with_translate(response_with_translate(content.content, translate_to))
    [translation_title, translation_content]
  end

  private
  def self.url_for_translate(content, translate_to)
    URI.escape("#{Rails.application.secrets.site_url}key=#{Rails.application.secrets.yandex_key}&text=#{content}&lang=#{translate_to}")
  end

  def self.response_with_translate(content, translate_to)
    HTTParty.get(url_for_translate(content, translate_to))
  end

  def self.parse_response_with_translate(response)
    JSON.parse(response.body)['text'].join
  end

end
