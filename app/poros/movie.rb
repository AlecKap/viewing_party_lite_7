class Movie
  attr_reader :title,
              :vote_average,
              :id,
              :summary

  def initialize(attributes)
    @id = attributes[:id]
    @title = attributes[:title]
    @vote_average = attributes[:vote_average]
    @summary = attributes[:overview]
  end
end