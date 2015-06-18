class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]



def index
    if params[:tag].present? 
      @pins = Pin.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 12)
    else
      @pins = Pin.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 12)
    end  
end
  def show
  end

  def new
    @pin = current_user.pins.build
    @categories = Category.all.map{|c| [ c.name, c.id ] }

  end

  def edit
    @categories = Category.all.map{|c| [ c.name, c.id ] }
  end

  def create
    @pin = current_user.pins.build(pin_params)
    @pin.category_id = params[:category_id]
    respond_to do |format|
      if @pin.save
        format.html { redirect_to @pin, notice: 'Pin was successfully created.' }
        format.json { render :show, status: :created, location: @pin}
      else
        format.html { render :new }
        format.json { render json: @pin.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if
    @pin.update(pin_params)
     @pin.category_id = params[:category_id]
      redirect_to @pin, notice: 'Pin was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @pin.destroy
    redirect_to pins_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pin
      @pin = Pin.find(params[:id])
    end

        def correct_user
      @pin = current_user.pins.find_by(id: params[:id])
      redirect_to pins_path, notice: "Not authorized to edit this pin" if @pin.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pin_params
      params.require(:pin).permit(:description, :image, :date, :tag_list, :link, :title, :category)
    end
end