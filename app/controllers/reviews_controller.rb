class ReviewsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.product_id = params[:id]
 if @review.save
   flash[:success] = "Review posted!"
   redirect_to products_url
 else
   render 'products'
 end
  end

  def destroy
  end

private

    def review_params
      params.require(:review).permit(:content, :user_id, :product_id)
    end

end
