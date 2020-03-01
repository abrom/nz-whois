# frozen_string_literal: true

module NZWhois
  #
  # User contact for WHOIS response
  #
  class Contact
    def initialize(parser, contact_type)
      @parser = parser
      @contact_type = contact_type
    end

    def name
      content_for 'Name'
    end

    def address
      content_for 'Address'
    end

    def city
      content_for 'City'
    end

    def province
      content_for 'Province'
    end

    def postal_code
      content_for 'Postal Code'
    end

    def country
      content_for 'Country'
    end

    def phone
      content_for 'Phone'
    end

    def fax
      content_for 'Fax'
    end

    def email
      content_for 'Email'
    end

    def inspect
      format(
        '#<%<class_name>s:0x%<object_id>p @name=%<name>s @email=%<email>s">',
        class_name: self.class.name,
        object_id: object_id,
        name: name,
        email: email
      )
    end

    private

    def content_for(field)
      @parser.content_for "#{@contact_type} #{field}"
    end
  end
end
