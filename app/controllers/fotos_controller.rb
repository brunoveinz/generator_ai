class FotosController < ApplicationController
  before_action :set_foto, only: %i[ show edit update destroy ]

  # GET /fotos or /fotos.json
  def index
    @fotos = Foto.all
  end

  # GET /fotos/1 or /fotos/1.json
  def show
  end

  # GET /fotos/new
  def new
    @foto = Foto.new
  end

  # GET /fotos/1/edit
  def edit
  end

  # POST /fotos or /fotos.json
  def create
    @foto = Foto.new(foto_params)

    respond_to do |format|
      if @foto.save
        format.html { redirect_to foto_url(@foto), notice: "Foto was successfully created." }
        format.json { render :show, status: :created, location: @foto }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @foto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fotos/1 or /fotos/1.json
  def update
    respond_to do |format|
      if @foto.update(foto_params)
        format.html { redirect_to foto_url(@foto), notice: "Foto was successfully updated." }
        format.json { render :show, status: :ok, location: @foto }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @foto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fotos/1 or /fotos/1.json
  def destroy
    @foto.destroy

    respond_to do |format|
      format.html { redirect_to fotos_url, notice: "Foto was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_foto
      @foto = Foto.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def foto_params
      params.require(:foto).permit(:title, :body)
    end
end
