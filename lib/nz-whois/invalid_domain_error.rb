# frozen_string_literal: true

module NZWhois
  #
  # Invalid domain error used when a non `.nz` domain requested
  #
  class InvalidDomainError < StandardError
    def message
      'Only `.nz` domain names supported'
    end
  end
end
