class SearchFacade
  attr_reader :user

  def initialize(user, search)
    @user = user
    @search = search
  end

  def movies
    @movies = search_movies_data[:results].map do |movie_data|
      Movie.new(movie_data)
    end
  end

  private

  def service
    @_service ||= MovieService.new
  end

  def search_movies_data
    @_search_movies_data ||= service.search_movies(@search)
  end
end