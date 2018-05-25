class ReviewsController < ApplicationController

	before_action :set_review, only:[:edit, :update, :destroy]
	before_action :set_movie
	before_action :authenticate_user!, except:[:index]
	
	def new
		@review = Review.new		
	end

	def edit	
	end

	def create
		@review = Review.new(review_params)
		@review.user_id = current_user.id
		@review.movie_id = @movie.id
		if @review.save
		redirect_to movie_path(@movie)
		else
		render 'new'
		end
	end

	def update
		@review = Review.update(review_params)
		redirect_to movie_path(@movie)		
	end

	def destroy
		if @review.destroy
			# redirect_to movie_path(@movie)
		end
	end

	private
	def review_params
		params.require(:review).permit(:rating, :comment)		
	end

	def set_review
		@review = Review.find(params[:id])		
	end

	def set_movie
		@movie = Movie.find(params[:movie_id])		
	end
end
