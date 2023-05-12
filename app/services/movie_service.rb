class MovieService
  def top_rated_movies
    get_url('/3/movie/top_rated')
  end

  def search_movies(query)
    get_url("/3/search/movie?query=#{query}")
  end

  def movie_details(movie_id)
    get_url("/3/movie/#{movie_id}")
  end

  def movie_cast(movie_id)
    get_url("/3/movie/#{movie_id}/credits")
  end

  def movie_reviews_details(movie_id)
    get_url("/3/movie/#{movie_id}/reviews")
  end

  def movie_images(movie_id)
    get_url("/3/movie/#{movie_id}/images")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
      faraday.headers['Authorization'] = "Bearer #{ENV['tmdb_key']}"
    end
  end
end