class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    if params[:query].present?
      # POUR CHERCHER "Superman" CASE SENSITIVE
      # @movies = @movies.where(title: params[:query])

      # POUR CHERCHER "superman" CASE INSENSITIVE
      # @movies = @movies.where("title ILIKE ?", "%#{params[:query]}%")

      # POUR CHERCHER "superman" CASE INSENSITIVE
      # sql_subquery = "title ILIKE :query OR synopsis ILIKE :query"
      # @movies = @movies.where(sql_subquery, query: "%#{params[:query]}%" )

      # POUR CHERCHER dans les tables movies et directors
      #   sql_subquery = <<~SQL
      #     movies.title ILIKE :query
      #     OR movies.synopsis ILIKE :query
      #     OR directors.first_name ILIKE :query
      #     OR directors.last_name ILIKE :query
      #   SQL
      #   @movies = @movies.joins(:director).where(sql_subquery, query: "%#{params[:query]}%")
      # end

      # POUR CHERCHER dans les tables movies et directors - multi termes
      # sql_subquery = <<~SQL
      # movies.title @@ :query
      # OR movies.synopsis @@ :query
      # OR directors.first_name @@ :query
      # OR directors.last_name @@ :query
      # SQL
      # @movies = @movies.joins(:director).where(sql_subquery, query: "%#{params[:query]}%")

      # PG SEARCH !!!
      # pour pouvoir chercher "superman batm" dans le title et synopsis (voir le model MOVIE)
      # @movies = Movie.search_by_title_and_synopsis("#{params[:query]}")

      # pour pouvoir chercher aussi "nolan" (DIRECTOR) et dans le title et synopsis
      # @movies = Movie.global_search("#{params[:query]}")

        # multisearch pour pouvoir chercher dans plus de 1 table (movie et tv show, par ex.)

        #resultat POLYMORPHIQUE
      @movies = PgSearch.multisearch("#{params[:query]}")

    end
  end
end
