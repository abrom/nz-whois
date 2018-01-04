require 'open-uri'

module NZWhois
  #
  # Client used to fetch NZ WHOIS data and delegate parser results
  #
  class Client
    extend Forwardable

    #
    # Class helper for whois instance method
    # @param [String] domain Domain name to fetch WHOIS data for
    # @return Client instance
    #
    def self.whois(domain)
      new.whois domain
    end

    #
    # Fetch WHOIS data for a domain name
    # @param [String] domain Domain name to fetch WHOIS data for
    # @return Client instance (`self`)
    #
    def whois(domain)
      raise InvalidDomainError unless domain.to_s =~ /\.nz\z/i
      fetch_content domain
      self
    end

    def inspect
      format(
        '#<%<class_name>s:0x%<object_id>p @valid_whois=%<valid_whois>s">',
        class_name: self.class.name,
        object_id: object_id,
        valid_whois: valid_whois?
      )
    end

    #
    # Returns whether the whois response is valid
    # @return Boolean
    #
    def valid_whois?
      @status == '200' && parser.valid_whois?
    end

    def_delegators :parser, :status, :registered_on, :expires_on,
                   :last_modified_on, :delegation_requested?, :domain_signed?,
                   :registrar, :registrant_contact, :admin_contact,
                   :technical_contact, :name_servers

    private

    def fetch_content(domain)
      open("https://dnc.org.nz/whois/search?domain_name=#{domain}") do |f|
        @status = f.status.first
        @content = f.read
      end
    rescue OpenURI::HTTPError => e
      @status = e.message.strip
    end

    def parser
      @parser ||= Parser.new @content
    end
  end
end
