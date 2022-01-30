# frozen_string_literal: true

class LsoaChecksController < ApplicationController
  def index; end

  def create
    redirect_to lsoa_check_path(postcode: params[:postcode])
  end

  def show
    @serviced_check = ServicedCheck.call(params[:postcode])
  rescue InvalidPostcodeError
    @serviced_check = :invalid
  end
end
