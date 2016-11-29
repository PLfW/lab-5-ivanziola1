class Api::V1::GenresController < Api::V1::BaseController
  def index
    genres = Genre.all
    render json:  genres,  each_serializer: Api::V1::GenreSerializer
  end
end
