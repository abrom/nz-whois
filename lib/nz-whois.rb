require 'nz-whois/gem_version'

require 'nz-whois/client'
require 'nz-whois/contact'
require 'nz-whois/invalid_domain_error'
require 'nz-whois/parser'

#
# Module helper shortcut for Client whois
#
module NZWhois
  def self.whois(domain)
    Client.whois domain
  end
end
