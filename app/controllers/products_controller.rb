class ProductsController < ApplicationController
  before_action :admin_user,     only: [:edit, :update, :destroy]

  def show
    @product = Product.find(params[:id])
    @review = current_user.reviews.build if logged_in?
    @reviews = Review.paginate(page: params[:page])

  end

  def new
    @product = Product.new
  end

  def index
    @products = Product.paginate(page: params[:page])
  end

  def create
    @product = Product.new(product_params)
    respond_to do |format|
    if @product.save
      format.html { redirect_to products_url, notice: "Product successfully added!" }
      # format.json { render :show, status :created, location: @product }
      # Handle a successful save.
    else
      format.html { render :new }
      format.json { render json: @product.errors, status: :unprocessable_entity }
      # render 'new'
      end
    end
  end

def edit
  @product = Product.find(params[:id])
end

def update
  @product = Product.find(params[:id])
  if @product.update_attributes(product_params)
    # Handle a successful update.
    flash[:success] = "Product details updated"
    redirect_to @product
  else
    render 'edit'
  end
end

def destroy
  Product.find(params[:id]).destroy
  flash[:success] = "Product deleted"
  redirect_to products_url
end

private

   def product_params
     params.require(:product).permit(:name, :description, :price)
   end

end
