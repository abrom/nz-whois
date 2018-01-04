# New Zealand whois scraper

Since the NZ DNC block port 43 whois, instead we need to scrape their website :/

_N.B. The NZ DNC rate limit requests so you'll need to be careful how much you use it. See Terms of Use below_ 


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nz-whois'
```

And then execute:

    $ bundle


## Usage

```ruby
require 'nz-whois'

whois = NZWhois.whois 'mydomain.nz'
puts "Valid whois?: #{whois.valid_whois?}"
 => true
puts "Expiry: #{whois.expires_on}"
 => "Expiry: 2018-03-13 12:02:00 +0000"
```

## NZ DNC Terms of Use
_Sourced from https://dnc.org.nz_

Terms of Use: By submitting a WHOIS query you are entering into an agreement with Domain Name Commission Ltd on the following terms and conditions, and subject to all relevant .nz Policies and procedures as found at https://dnc.org.nz/. It is prohibited to: 
- Send high volume WHOIS queries with the effect of downloading part of or all of the .nz Register or collecting register data or records; 
- Access the .nz Register in bulk through the WHOIS service (ie. where a user is able to access WHOIS data other than by sending individual queries to the database); 
- Use WHOIS data to allow, enable, or otherwise support mass unsolicited commercial advertising, or mass solicitations to registrants or to undertake market research via direct mail, electronic mail, SMS, telephone or any other medium; 
- Use WHOIS data in contravention of any applicable data and privacy laws, including the Unsolicited Electronic Messages Act 2007; 
- Store or compile WHOIS data to build up a secondary register of information; 
- Publish historical or non-current versions of WHOIS data; and 
- Publish any WHOIS data in bulk. Copyright Domain Name Commission Limited (a company wholly-owned by Internet New Zealand Incorporated) which may enforce its rights against any person or entity that undertakes any prohibited activity without its written permission. The WHOIS service is provided by NZRS Limited.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/abrom/nz-whois.

Note that spec tests are appreciated to minimise regressions. Before submitting a PR, please ensure that:
 
```bash
$ rspec
```

and

```bash
$ rubocop
```

both succeed 

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
