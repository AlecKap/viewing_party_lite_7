class TopRatedFacade
  def initialize(params)
    @params = params
  end

  def movies
    @movies = top_rated_movies_data[:results].map do |movie_data|
      Movie.new(movie_data)
    end
  end

  def user_id
    @params[:user_id]
  end

  private

  def service
    @_service ||= MovieService.new
  end

  def top_rated_movies_data
    @_top_rated_movies_data ||= service.top_rated_movies
  end
end