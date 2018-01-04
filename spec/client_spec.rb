require 'spec_helper'

RSpec.describe NZWhois::Client do
  describe '.whois' do
    it 'calls to Client instance whois method' do
      expect_any_instance_of(NZWhois::Client).to(
        receive(:whois).with('mydomain.nz')
      )
      NZWhois::Client.whois 'mydomain.nz'
    end
  end

  describe '#whois' do
    it 'fetches whois content' do
      stub_http_request(
        :get,
        'https://dnc.org.nz/whois/search?domain_name=mydomain.nz'
      ).to_return(
        body: File.new('spec/test_responses/success.html'),
        status: 200
      )

      whois = NZWhois::Client.new.whois 'mydomain.nz'
      expect(whois.status).to eq 'Active'
    end

    context 'non-NZ domain name' do
      it 'raises an InvalidDomainError' do
        expect do
          NZWhois::Client.new.whois 'mydomain.com'
        end.to raise_exception NZWhois::InvalidDomainError
      end
    end
  end

  describe '#valid_whois?' do
    before do
      stub_http_request(
        :get,
        'https://dnc.org.nz/whois/search?domain_name=mydomain.nz'
      ).to_return(
        body: File.new("spec/test_responses/#{response_file}"),
        status: status
      )
    end

    let(:status) { 200 }
    let(:response_file) { 'success.html' }

    it 'returns true for a successful whois request' do
      whois = NZWhois.whois 'mydomain.nz'
      expect(whois.valid_whois?).to be_truthy
    end

    context 'rate limited response' do
      let(:response_file) { 'failure.html' }

      it 'returns false' do
        whois = NZWhois.whois 'mydomain.nz'
        expect(whois.valid_whois?).to be_falsey
      end
    end

    context 'bad request' do
      let(:status) { 400 }

      it 'returns false' do
        whois = NZWhois.whois 'mydomain.nz'
        expect(whois.valid_whois?).to be_falsey
      end
    end
  end

  describe '#status' do
    it { is_expected.to delegate_method(:status).to :parser }
  end

  describe '#registered_on' do
    it { is_expected.to delegate_method(:registered_on).to :parser }
  end

  describe '#expires_on' do
    it { is_expected.to delegate_method(:expires_on).to :parser }
  end

  describe '#last_modified_on' do
    it { is_expected.to delegate_method(:last_modified_on).to :parser }
  end

  describe '#delegation_requested?' do
    it { is_expected.to delegate_method(:delegation_requested?).to :parser }
  end

  describe '#domain_signed?' do
    it { is_expected.to delegate_method(:domain_signed?).to :parser }
  end

  describe '#registrar' do
    it { is_expected.to delegate_method(:registrar).to :parser }
  end

  describe '#registrant_contact' do
    it { is_expected.to delegate_method(:registrant_contact).to :parser }
  end

  describe '#admin_contact' do
    it { is_expected.to delegate_method(:admin_contact).to :parser }
  end

  describe '#technical_contact' do
    it { is_expected.to delegate_method(:technical_contact).to :parser }
  end

  describe '#name_servers' do
    it { is_expected.to delegate_method(:name_servers).to :parser }
  end
end
