class TopRatedFacade
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def movies
    top_rated_movies_data[:results].map do |movie_data|
      Movie.new(movie_data)
    end
  end

  private

  def service
    @_service ||= MovieService.new
  end

  def top_rated_movies_data
    @_top_rated_movies_data ||= service.top_rated_movies
  end
end
