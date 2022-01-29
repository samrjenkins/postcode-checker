# frozen_string_literal: true

class MsoaCheck
  def self.call(postcode)
    postcode.downcase == 'se17qd'
  end
end
