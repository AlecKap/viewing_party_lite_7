class SearchFacade
  def initialize(query)
    @query = query
  end

  def movies
    service = MovieService.new
    json = service.search_movies(@query)
    @movies = json[:results].map do |movie_data|
      Movie.new(movie_data)
    end
  end
end