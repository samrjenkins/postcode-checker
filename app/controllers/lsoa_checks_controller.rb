# frozen_string_literal: true

class LsoaChecksController < ApplicationController
  def index; end

  def create
    redirect_to lsoa_check_path(postcode: params[:postcode])
  end

  def show
    @lsoa_check = lsoa_check
  rescue InvalidPostcodeError
    @lsoa_check = :invalid
  end

  private

  def lsoa_check = LsoaCheck.call(params[:postcode])
end
