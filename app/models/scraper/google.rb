require 'open-uri'

module Scraper
  class Google
    BASE_HOST = "http://www.google.com/search"

    def search(query)
      url = build_url_for(query)
      page = URI.parse(url.to_s).open
      html = Nokogiri::HTML(page)

      html.css('a:has(h3)').map do |link|
        next if link['href'].include?('http://www.google.com/search')
        build_record(link)
      end.compact
    end

    private

    def build_record(link)
      parsed_link = sanitize_target_link(link)

      title = link.css('h3').text
      title = title.valid_encoding? ? title : title.unpack("C*").pack("U*")
      description = link.parent.parent.children[2].text
      # Fix latin characters
      description = description.valid_encoding? ? description : description.unpack("C*").pack("U*")

      Record.new(
        title: title,
        description: description,
        link: parsed_link.to_s,
      )
    end

    def sanitize_target_link(link)
      plain_link = link['href'].sub(/^\/url\?q\=/, '').sub('/&', '?')
      plain_link.sub!('&', '?') unless plain_link.include?('?')
      parsed_link = Addressable::URI.parse(plain_link)

      parsed_link.query_values = parsed_link.query_values&.except('sa', 'usg', 'ved').presence
      parsed_link
    end

    def build_url_for(query)
      url = Addressable::URI.parse(BASE_HOST)

      url.query_values = {
        q: query, num: 100
      }

      url
    end
  end
end
