require 'spec_helper'

RSpec.describe NZWhois do
  describe '.whois' do
    it 'calls to Client.whois' do
      expect(NZWhois::Client).to receive(:whois).with 'somedomain.nz'
      NZWhois.whois 'somedomain.nz'
    end
  end
end
