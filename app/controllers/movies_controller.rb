class MoviesController < ApplicationController
    before_action :authenticate_user!, except:[:index,:show]

  before_action :set_id, only:[:edit, :show, :update,:destroy] 
  def index
    @movies = Movie.all
  end

  def new
    @movie = current_user.movies.build
  end

  def edit
  end

  def show
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
    params.require(:movie).permit(:title, :description, :movie_length,:director,:rating)
  end

  def set_id
    @movie = Movie.find(params[:id])    
  end

end
