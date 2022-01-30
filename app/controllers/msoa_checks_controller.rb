# frozen_string_literal: true

class MsoaChecksController < ApplicationController
  def index; end

  def create
    redirect_to msoa_check_path(params[:postcode])
  end

  def show
    @msoa_check = msoa_check
  rescue InvalidPostcodeError
    @msoa_check = :invalid
  end

  private

  def msoa_check = MsoaCheck.call(params[:postcode])
end
