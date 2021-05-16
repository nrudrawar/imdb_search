class Movie < ApplicationRecord
  belongs_to :director

  include PgSearch::Model
  pg_search_scope :search_by_title_and_synopsis,
    against: [ :title, :synopsis ],
    associated_against: {
      director: [ :first_name, :last_name ]
    },
    using: {
      tsearch: { prefix: true } # tsearch is equivalent to @@ <-- now `superman batm` will return something!
    }
  multisearchable against: [:title, :synopsis]
end
