class TvShow < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:title, :synopsis]
  # multisearch pour pouvoir chercher dans plus de 1 table (movie et tv show, par ex.)
  #resultat POLYMORPHIQUE
end
