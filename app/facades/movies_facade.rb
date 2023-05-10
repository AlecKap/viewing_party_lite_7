class MoviesFacade
  def top_rated
    service = MovieService.new
    json = service.top_rated_movies
    @movies = json[:results].map do |movie_data|
      Movie.new(movie_data)
    end
  end
end