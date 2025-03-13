class Movie < ApplicationRecord
  belongs_to :director
  include PgSearch::Model
  # pour pouvoir chercher "superman batm" dans le title et synopsis
  # pg_search_scope :search_by_title_and_synopsis,
  #   against: [ :title, :synopsis ],
  #   using: {
  #     tsearch: { prefix: true } # %params[:query]% <-- now `superman batm` will return something!
  #   }

  # pour pouvoir chercher dans le title et synopsis ET dans le director
  #   pg_search_scope :global_search,
  #   against: [ :title, :synopsis ],
  #   associated_against: {
  #     director: [ :first_name, :last_name ]
  #   },
  #   using: {
  #     tsearch: { prefix: true }
  #   }

  # multisearch pour pouvoir chercher dans plus de 1 table (movie et tv show, par ex.)  #resultat POLYMORPHIQUE
  multisearchable against: [:title, :synopsis]


end
