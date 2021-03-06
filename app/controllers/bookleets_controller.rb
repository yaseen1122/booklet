class BookleetsController < ApplicationController
  before_action :set_bookleet, only: [:show, :edit, :update, :destroy,:upload_booklets,:delete_booklets]

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
    @booklet               = Bookleet.where(name:  @bookleet_name).last
    save_selected_files(@booklet, selected_booklet_files) if  (@booklet.present? && @result_files == "200")
  end


  def save_selected_files(bookleet,selected_files)
    bookleet.update(selected_files: selected_files.as_json)
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


  def upload_booklets
    begin
      (params[:files] || []).each do |uploaded_io|
      # Moving the file to some safe place; as tmp files will be flushed timely
        File.open(Rails.root.join('booklet_files', uploaded_io.original_filename), 'wb') do |file|
          file.write(uploaded_io.read)
        end
      end
      @booklet_files = Dir.glob("#{Rails.root}/booklet_files/**/*")
      @bookleet_selected_files = @bookleet.selected_files
      return @result = "200"
    rescue Exception => e
      return @result = "500"
    end
  end

  def delete_booklets
    begin
      delete_selected_files = params[:delete_selected_files]
      if delete_selected_files.present?
        delete_selected_files.each do |dsf|
          File.delete(dsf) if File.exist?(dsf)
        end
      end
      @booklet_files = Dir.glob("#{Rails.root}/booklet_files/**/*")
      @bookleet_selected_files = @bookleet.selected_files
      return @result = "200"
    rescue Exception => e
      return @result = "500"
    end
  end

  def delete_selected_file
    begin
      delete_selected_file_path = params[:delete_selected_file_path]
      current_tb_id = params[:current_selected_tbc_id].split('-').last
      @bookleet   = Bookleet.find(params[:booklet_id])
      @bookleet.selected_files[current_tb_id].delete(delete_selected_file_path)
      @bookleet.save!
      return @result = "200"
    rescue Exception => e
      return @result = "500"
    end

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
