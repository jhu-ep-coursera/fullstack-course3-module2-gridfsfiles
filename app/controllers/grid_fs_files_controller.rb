class GridFsFilesController < ApplicationController
  before_action :set_grid_fs_file, only: [:show, :edit, :update, :destroy, :contents]

  def contents
    send_data @grid_fs_file.contents, 
              {filename: @grid_fs_file.filename, type: @grid_fs_file.contentType, disposition: 'inline'}
  end

  # GET /grid_fs_files
  # GET /grid_fs_files.json
  def index
    @grid_fs_files = GridFsFile.all
  end

  # GET /grid_fs_files/1
  # GET /grid_fs_files/1.json
  def show
  end

  # GET /grid_fs_files/new
  def new
    @grid_fs_file = GridFsFile.new
  end

  # GET /grid_fs_files/1/edit
  def edit
  end

  # POST /grid_fs_files
  # POST /grid_fs_files.json
  def create
    @grid_fs_file = GridFsFile.new(grid_fs_file_params)

    respond_to do |format|
      if @grid_fs_file.save
        format.html { redirect_to @grid_fs_file, notice: 'Grid fs file was successfully created.' }
        format.json { render :show, status: :created, location: @grid_fs_file }
      else
        format.html { render :new }
        format.json { render json: @grid_fs_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /grid_fs_files/1
  # PATCH/PUT /grid_fs_files/1.json
  def update
    respond_to do |format|
      if @grid_fs_file.update(grid_fs_file_params)
        format.html { redirect_to @grid_fs_file, notice: 'Grid fs file was successfully updated.' }
        format.json { render :show, status: :ok, location: @grid_fs_file }
      else
        format.html { render :edit }
        format.json { render json: @grid_fs_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grid_fs_files/1
  # DELETE /grid_fs_files/1.json
  def destroy
    @grid_fs_file.destroy
    respond_to do |format|
      format.html { redirect_to grid_fs_files_url, notice: 'Grid fs file was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grid_fs_file
      @grid_fs_file = GridFsFile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grid_fs_file_params
      params.require(:grid_fs_file).permit(:filename, :contentType, :author, :topic, :uploadDate, :length, :chunkSize, :md5, :contents)
    end
end
