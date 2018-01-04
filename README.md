# New Zealand whois scraper

Since the NZ DNC block port 43 whois, instead we need to scrape their website :/


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

whois = NZWhois.whois 'mydomain.com'
puts "Expiry: #{whois.expiry}"
```


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
