require 'ununiga/josa_picker'

module Ununiga::I18n
  module JosaTransformer
    def translate(locale, key, options = {})
      # 사실 html 파악은 rails 쪽의 기능이다.
      # https://github.com/rails/rails/blob/6f0d1ad14b92b9f5906e44740fce8b4f1c7075dc/actionview/lib/action_view/helpers/translation_helper.rb#L73
      # 문제는, html 키인지 판단하는 메서드는 private으로 되어 있다.
      # https://github.com/rails/rails/blob/6f0d1ad14b92b9f5906e44740fce8b4f1c7075dc/activesupport/lib/active_support/html_safe_translation.rb
      transform(super, key.end_with?("_html", ".html"), locale)
    end

    def transform(entry, is_html, locale=I18n.locale)
      if entry.is_a?(String) && locale.to_s =~ /ko|ko_KR/i
        return Ununiga::JosaPicker.new(entry, is_html).takewell
      end
      entry
    end
  end
end
