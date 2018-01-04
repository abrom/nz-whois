require 'spec_helper'

RSpec.describe NZWhois::InvalidDomainError do
  it { is_expected.to be_a StandardError }
  it { expect(subject.message).to eq 'Only `.nz` domain names supported' }
end
