class MovieImagesFacade
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def movie_img(movie_id)
    image = movie_images_data(movie_id)[:backdrops].sample[:file_path]
    "https://image.tmdb.org/t/p/original#{image}"
  end

  private

  def service
    @_service ||= MovieService.new
  end

  def movie_images_data(movie_id)
    @_movie_images_data ||= service.movie_images(movie_id)
  end
end
