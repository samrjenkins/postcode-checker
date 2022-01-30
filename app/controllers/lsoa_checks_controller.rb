# frozen_string_literal: true

class LsoaChecksController < ApplicationController
  def index; end

  def create
    redirect_to lsoa_check_path(postcode: params[:postcode])
  end

  def show
    @serviced_check = serviced_check
  rescue InvalidPostcodeError
    @serviced_check = :invalid
  end

  private

  def serviced_check = ServicedCheck.call(params[:postcode])
end
