class ReviewsController < ApplicationController
    before_action :find_restaurant
    before_action :find_review, only: [:edit, :update, :destroy]
    before_action :authenticate_user!, only: [:new, :edit]
    
    
    def new
        @review = Review.new
    
    end
    
    def create
        @review = Review.new(review_params)
        @review.restaurant_id = @restaurant.id
        @review.user_id = current_user.id
        
        if @review.save
            redirect_to restaurant_path(@restaurant)
        else
            render 'new'
            
        end
    end
    
    def edit
       
    end
    
    def update
        
        
        if @review.update(review_params)
            redirect_to restaurant_path(@restaurant)
        else
            remder 'edit'
        end
    end
    
    def destroy
        @review.destroy
        redirect_to restaurant_path(@restaurant)
        
    end
    
    private
    
        def review_params
            params.require(:review).permit(:rating, :comment)
        end
        
        def find_restaurant
            @restaurant = Restaurant.find(params[:restaurant_id])
        end
        
        def find_review
            @review = Review.find(params[:id])
        end
end
