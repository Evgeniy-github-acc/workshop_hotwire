class TracksController < ApplicationController
  include Pagy::Backend
  def index
    @artist = Artist.find(params[:artist_id])
    @pagy, @tracks = pagy(@artist.tracks, items: 20)

    render 'list' if params[:page]
  end
end
