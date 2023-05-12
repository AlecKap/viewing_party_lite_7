class MovieDetailsFacade
  def initialize(params)
    @params = params
    @movie = movie
  end

  def user_id
    @params[:user_id]
  end

  def movie
    @movie = Movie.new(movie_details_data)
  end

  def runtime
    movie_details_data[:runtime]
  end

  def genres
    genres = []
    movie_details_data[:genres].each do |genre|
      genres << genre[:name]
    end
    genres.to_sentence
  end

  def cast
    cast_mem_and_char = []
    cast_data[:cast][0..9].each do |cast_mem|
      cast_mem_and_char << "#{cast_mem[:name]} as #{cast_mem[:character]}"
    end
    cast_mem_and_char
  end

  def reviews
    review_info = []
    movie_reviews_data[:results].each do |review| 
      review_info << "Review: #{review[:content]} Written By: #{review[:author]}"
    end
    review_info
  end

  def total_reviews
    movie_reviews_data[:total_results]
  end

  private

  def service
    @_service ||= MovieService.new
  end

  def movie_details_data
    if @params[:movie_id].present?
      @_movie_details_data ||= service.movie_details(@params[:movie_id])
    else
      @_movie_details_data ||= service.movie_details(@params[:id])
    end
  end

  def cast_data
    if @params[:movie_id].present?
      @_cast_data ||= service.movie_cast(@params[:movie_id])
    else
      @_cast_data ||= service.movie_cast(@params[:id])
    end
  end

  def movie_reviews_data
    if @params[:movie_id].present?
      @_movie_reviews_data ||= service.movie_reviews_details(@params[:movie_id])
    else
      @_movie_reviews_data ||= service.movie_reviews_details(@params[:id])
    end
  end
end
