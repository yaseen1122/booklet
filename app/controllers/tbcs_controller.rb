class TbcsController < ApplicationController
  before_action :set_booklet, only: [:create,:show, :edit, :update, :destroy]
  before_action :set_tbc, only: [:show, :edit, :update, :destroy]

  # GET /tbcs
  # GET /tbcs.json
  def index
    @tbcs = Tbc.all
  end

  # GET /tbcs/1
  # GET /tbcs/1.json
  def show
  end

  # GET /tbcs/new
  def new
    @tbc = Tbc.new
  end

  # GET /tbcs/1/edit
  def edit
  end

  # POST /tbcs
  # POST /tbcs.json
  def create
    @tbc = @booklet.tbcs.new(tbc_params)
    respond_to do |format|
      if @tbc.save
        format.html { redirect_to @tbc, notice: 'Tbc was successfully created.' }
        format.json { render :show, status: :created, location: @tbc }
        format.js
      else
        format.html { render :new }
        format.json { render json: @tbc.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /tbcs/1
  # PATCH/PUT /tbcs/1.json
  def update
    respond_to do |format|
      if @tbc.update(tbc_params)
        format.html { redirect_to @tbc, notice: 'Tbc was successfully updated.' }
        format.json { render :show, status: :ok, location: @tbc }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @tbc.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /tbcs/1
  # DELETE /tbcs/1.json
  def destroy
    @tbc.destroy
    respond_to do |format|
      format.html { redirect_to tbcs_url, notice: 'Tbc was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_booklet
      @booklet = Bookleet.find(params[:bookleet_id])
    end
    def set_tbc
      @tbc = Tbc.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tbc_params
      params.require(:tbc).permit(:name)
    end
end
