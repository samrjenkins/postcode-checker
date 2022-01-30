# frozen_string_literal: true

class MsoaChecksController < ApplicationController
  def show
    @msoa_check = msoa_check
    render msoa_check.to_s
  end

  private

  def msoa_check
    return @msoa_check unless @msoa_check.nil?

    @msoa_check = MsoaCheck.call(params[:postcode])
  end
end
