class MoviesController < ApplicationController
    before_action :authenticate_user!, except:[:index,:show]

  before_action :set_id, only:[:edit, :show, :update,:destroy]

  def search
    if params[:search].present?
      @movies = Movie.search(params[:search])
    else
      @movies = Movie.all
    end    
  end
  
  def index
    @movies = Movie.all
  end

  def new
    @movie = current_user.movies.build
  end

  def edit
  end

  def show
    @reviews = Review.where(movie_id: @movie.id).order("created_at Desc")

    if @review.blank?
      @avg_review = 0
    else
      @avg_review = @reviews.average(:rating).round(2)
    end
  end

  def create
    @movie = current_user.movies.build(movie_params)
    if @movie.save
      redirect_to movies_path, notice: "Movie is successfully created for review"
    else
      render 'new'
    end
  end

  def update
    if @movie.update(movie_params)
      redirect_to movies_path, notice: "Movie is successfully updated"
    else
      render 'new'
    end
  end

  def destroy
    @movie.destroy
    redirect_to @movie, notice: "Movie is deleted"
  end
  private 
  
  def movie_params
    params.require(:movie).permit(:title, :description, :movie_length,:director,:rating, :image)
  end

  def set_id
    @movie = Movie.find(params[:id])    
  end

end
