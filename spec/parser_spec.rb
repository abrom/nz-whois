# frozen_string_literal: true

require 'spec_helper'

RSpec.describe NZWhois::Parser do
  let(:parser) { NZWhois::Parser.new html_content }
  let(:html_content) { successful_content }
  let(:successful_content) { File.read('spec/test_responses/success.html') }
  let(:failure_content) { File.read('spec/test_responses/failure.html') }

  describe '#valid_whois?' do
    subject { parser.valid_whois? }

    context 'a successful response' do
      it { is_expected.to be_truthy }
    end

    context 'a failed response' do
      let(:html_content) { failure_content }
      it { is_expected.to be_falsey }
    end

    context 'an invalid response' do
      let(:html_content) { '' }
      it { is_expected.to be_falsey }
    end
  end

  shared_context 'nil returned for failed response' do
    let(:html_content) { failure_content }
    it { is_expected.to be_nil }
  end

  describe '#status' do
    subject { parser.status }
    it { is_expected.to eq 'Active' }
    it_behaves_like 'nil returned for failed response'
  end

  describe '#registered_on' do
    subject { parser.registered_on }
    it { is_expected.to eq Time.new(2002, 4, 23, 12, 0, 0, '+00:00') }
    it_behaves_like 'nil returned for failed response'
  end

  describe '#expires_on' do
    subject { parser.expires_on }
    it { is_expected.to eq Time.new(2018, 1, 23, 12, 0, 0, '+00:00') }
    it_behaves_like 'nil returned for failed response'
  end

  describe '#last_modified_on' do
    subject { parser.last_modified_on }
    it { is_expected.to eq Time.new(2017, 12, 24, 11, 32, 0, '+00:00') }
    it_behaves_like 'nil returned for failed response'
  end

  describe '#delegation_requested?' do
    subject { parser.delegation_requested? }
    it { is_expected.to eq true }
    it_behaves_like 'nil returned for failed response'
  end

  describe '#domain_signed?' do
    subject { parser.domain_signed? }
    it { is_expected.to eq false }
    it_behaves_like 'nil returned for failed response'
  end

  describe '#registrar' do
    subject { parser.registrar }

    it { is_expected.to be_a NZWhois::Contact }

    it 'passes through `Registrar` as contact type' do
      expect(NZWhois::Contact).to(
        receive(:new).with(parser, 'Registrar').and_call_original
      )
      subject
    end

    it_behaves_like 'nil returned for failed response'
  end

  describe '#registrant_contact' do
    subject { parser.registrant_contact }

    it { is_expected.to be_a NZWhois::Contact }

    it 'passes through `Registrant Contact` as contact type' do
      expect(NZWhois::Contact).to(
        receive(:new).with(parser, 'Registrant Contact').and_call_original
      )
      subject
    end

    it_behaves_like 'nil returned for failed response'
  end

  describe '#admin_contact' do
    subject { parser.admin_contact }

    it { is_expected.to be_a NZWhois::Contact }

    it 'passes through `Admin Contact` as contact type' do
      expect(NZWhois::Contact).to(
        receive(:new).with(parser, 'Admin Contact').and_call_original
      )
      subject
    end

    it_behaves_like 'nil returned for failed response'
  end

  describe '#technical_contact' do
    subject { parser.technical_contact }

    it { is_expected.to be_a NZWhois::Contact }

    it 'passes through `Technical Contact` as contact type' do
      expect(NZWhois::Contact).to(
        receive(:new).with(parser, 'Technical Contact').and_call_original
      )
      subject
    end

    it_behaves_like 'nil returned for failed response'
  end

  describe '#name_servers' do
    subject { parser.name_servers }
    it do
      is_expected.to(
        eq %w[ns1.dns.net.nz ns2.dns.net.nz ns3.dns.net.nz ns4.dns.net.nz]
      )
    end

    context 'a failed response' do
      let(:html_content) { failure_content }
      it { is_expected.to eq [] }
    end
  end
end
