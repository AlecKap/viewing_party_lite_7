class Movie
  attr_reader :title,
              :vote_average,
              :id

  def initialize(attributes)
    @title = attributes[:title]
    @vote_average = attributes[:vote_average]
    @id = attributes[:id]
  end
end