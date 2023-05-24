class ViewingPartyFacade
  attr_reader :user

  def initialize(user, movie)
    @user = user
    @movie = movie
  end

  def new_viewing_party
    ViewingParty.new
  end

  def other_users
    User.where.not(id: @user)
  end

  def movie
    @movie = Movie.new(movie_details_data)
  end

  def runtime
    movie_details_data[:runtime]
  end

  private

  def service
    @_service ||= MovieService.new
  end

  def movie_details_data
    @_movie_details_data ||= service.movie_details(@movie)
  end
end