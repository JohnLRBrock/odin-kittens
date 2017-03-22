class KittensController < ApplicationController
  def index
    @kittens = Kitten.all
    respond_to do |format|
      format.html
      format.json { render json: @kittens }
    end
  end

  def show
    @kitten = Kitten.exists?(params[:id]) ? Kitten.find(params[:id]) : nil
    respond_to do |format|
      format.html
      format.json { render json:@kitten }
    end
  end

  def new
    @kitten = Kitten.new
  end

  def create
    kitten = Kitten.create(kitten_params)
    flash[:notice] = 'New kitten created'
    redirect_to kitten
  end

  def update
    id = params[:id]
    if Kitten.exists?(id)
      kitten = Kitten.find(id)
      kitten.update(kitten_params)
      flash[:notice] = 'Updated kitten'
      redirect_to kitten
    else
      flash[:error] = 'That kitten did not exist'
      redirect_to root_url
    end
  end

  def edit
    @kitten = Kitten.exists?(params[:id]) ? Kitten.find(params[:id]) : nil
  end

  def destroy
    id = params[:id]
    if Kitten.exists?(id)
      Kitten.find(id).destroy
      flash[:notice] = 'Kitten deleted.'
    else
      flash[:error] = 'That kitten does not exist'
    end
    redirect_to root_url
  end

  private
    def kitten_params()
      params.require(:kitten).permit(:name, :age, :cuteness, :softness)
    end
end
