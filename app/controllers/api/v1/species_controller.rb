class Api::V1::SpeciesController < ApplicationController
  def index
    render json: Species.all
  end

  def find
    species = Species.where(name: params[:name])
    render json: species
  end
end
