require 'spec_helper'

RSpec.describe NZWhois::Contact do
  let(:contact) { NZWhois::Contact.new(parser, contact_type) }

  let(:parser) { NZWhois::Parser.new html_content }
  let(:html_content) { File.read('spec/test_responses/success.html') }

  context 'Registrar contact type' do
    let(:contact_type) { 'Registrar' }

    it { expect(contact.name).to eq 'Domain Name Commissioner' }
    it { expect(contact.address).to eq 'PO Box 11881' }
    it { expect(contact.city).to eq 'Wellington' }
    it { expect(contact.province).to eq 'North-ish' }
    it { expect(contact.postal_code).to eq '1234' }
    it { expect(contact.country).to eq 'NZ (NEW ZEALAND)' }
    it { expect(contact.phone).to eq '+64 4 472 1600' }
    it { expect(contact.fax).to eq '+64 4 495 2115' }
    it { expect(contact.email).to eq 'info@dnc.org.nz' }
  end

  context 'Registrant contact type' do
    let(:contact_type) { 'Registrant Contact' }

    it { expect(contact.name).to eq 'Domain Name Commission Ltd' }
    it { expect(contact.address).to eq 'PO Box 11882' }
    it { expect(contact.city).to eq 'Auckland' }
    it { expect(contact.province).to be_nil }
    it { expect(contact.postal_code).to eq '6142' }
    it { expect(contact.country).to eq 'NZ (NEW ZEALAND)' }
    it { expect(contact.phone).to eq '+64 4 472 1700' }
    it { expect(contact.fax).to be_nil }
    it { expect(contact.email).to eq 'info1@dnc.org.nz' }
  end

  context 'Admin contact type' do
    let(:contact_type) { 'Admin Contact' }

    it { expect(contact.name).to eq 'Domain Name Commission Admin' }
    it { expect(contact.address).to eq 'PO Box 11883' }
    it { expect(contact.city).to eq 'Christchurch' }
    it { expect(contact.province).to be_nil }
    it { expect(contact.postal_code).to eq '6143' }
    it { expect(contact.country).to eq 'NZ (NEW ZEEELAND)' }
    it { expect(contact.phone).to eq '+64 4 472 1800' }
    it { expect(contact.fax).to be_nil }
    it { expect(contact.email).to eq 'info2@dnc.org.nz' }
  end

  context 'Technical contact type' do
    let(:contact_type) { 'Technical Contact' }

    it { expect(contact.name).to eq 'Domain Name Commission Tech' }
    it { expect(contact.address).to eq 'PO Box 11884' }
    it { expect(contact.city).to eq 'Hutt' }
    it { expect(contact.postal_code).to eq '6144' }
    it { expect(contact.country).to eq 'NZ (NEW ZULAND)' }
    it { expect(contact.phone).to eq '+64 4 472 1900' }
    it { expect(contact.fax).to be_nil }
    it { expect(contact.email).to eq 'info3@dnc.org.nz' }
  end
end
