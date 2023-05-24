class SearchFacade
  def initialize(current_user, params)
    @current_user = current_user
    @params = params
  end

  def movies
    @movies = search_movies_data[:results].map do |movie_data|
      Movie.new(movie_data)
    end
  end

  def user_id
    @current_user[:id]
  end

  private

  def service
    @_service ||= MovieService.new
  end

  def search_movies_data
    @_search_movies_data ||= service.search_movies(@params[:search])
  end
end