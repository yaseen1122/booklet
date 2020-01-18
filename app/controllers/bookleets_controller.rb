class BookleetsController < ApplicationController
  before_action :set_bookleet, only: [:show, :edit, :update, :destroy]

  # GET /bookleets
  # GET /bookleets.json
  def index
    @bookleets = Bookleet.all
  end

  # GET /bookleets/1
  # GET /bookleets/1.json
  def show
  end

  # GET /bookleets/new
  def new
    @bookleet = Bookleet.new
  end

  # GET /bookleets/1/edit
  def edit
  end

  # POST /bookleets
  # POST /bookleets.json
  def create
    @bookleet = Bookleet.new(bookleet_params)

    respond_to do |format|
      if @bookleet.save
        format.html { redirect_to bookleets_path, notice: 'Bookleet was successfully created.' }
        format.json { render :show, status: :created, location: @bookleet }
        format.js
      else
        format.html { render :new }
        format.json { render json: @bookleet.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /bookleets/1
  # PATCH/PUT /bookleets/1.json
  def update
    respond_to do |format|
      if @bookleet.update(bookleet_params)
        format.html { redirect_to @bookleet, notice: 'Bookleet was successfully updated.' }
        format.json { render :show, status: :ok, location: @bookleet }
      else
        format.html { render :edit }
        format.json { render json: @bookleet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookleets/1
  # DELETE /bookleets/1.json
  def destroy
    @bookleet.destroy
    respond_to do |format|
      format.html { redirect_to bookleets_url, notice: 'Bookleet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def generate_booklet
    selected_booklet_files =  params[:booklet_hash]
    @bookleet_name         =  params[:booklet_name]
    @result_files          =  BookletGenerator.new(selected_booklet_files,@bookleet_name).result
  end

  def download_booklet
    # begin
      @file_name       = params[:file_name]
      file_destination = "#{Rails.root}/booklet_files/#{@file_name}"
      send_file file_destination, type: "application/pdf", x_sendfile: true
    # rescue Exception => e
    #   flash.now[:errors] = 'Some error occured . File download failed. Please contact to support.'
    #   redirect_to new_user_url
    #   redirect_to @bookleet
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bookleet
      @bookleet = Bookleet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bookleet_params
      params.require(:bookleet).permit(:name)
    end
end
