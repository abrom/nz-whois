require 'nokogiri'
require 'date'

module NZWhois
  #
  # WHOIS content parser
  #
  class Parser
    def initialize(content)
      @content = content
    end

    def valid_whois?
      return @valid_whois if defined? @valid_whois
      @valid_whois = !whois_content.nil?
    end

    def status
      content_for 'Query Status'
    end

    def registered_on
      nz_date_for 'Domain Date Registered'
    end

    def expires_on
      nz_date_for 'Domain Date Billed Until'
    end

    def last_modified_on
      nz_date_for 'Domain Date Last Modified'
    end

    def delegation_requested?
      boolean_for? 'Domain Delegate Requested'
    end

    def domain_signed?
      boolean_for? 'Domain Signed'
    end

    def registrar
      Contact.new self, 'Registrar'
    end

    def registrant_contact
      Contact.new self, 'Registrant Contact'
    end

    def admin_contact
      Contact.new self, 'Admin Contact'
    end

    def technical_contact
      Contact.new self, 'Technical Contact'
    end

    def name_servers
      contents_for 'NS Name '
    end

    def content_for(description)
      contents_for(description).first
    end

    private

    def page
      @page ||= Nokogiri::HTML @content
    end

    def whois_content
      @whois_content ||= page.xpath("//*[@id='block-dnc-content']")
    end

    def contents_for(description)
      return unless valid_whois?

      whois_content.xpath("//td/*[text() = '#{description}']").map do |element|
        element.ancestors('td').first.next_element.text
      end
    end

    def nz_date_for(description)
      date_string = content_for description
      return unless date_string

      # Add 12 hours (ie NZ) -- ignoring DST
      Time.parse(date_string + ' GMT') + 12 * 3600
    end

    def boolean_for?(description)
      boolean_string = content_for description
      boolean_string == 'yes' if boolean_string
    end
  end
end
