require 'debug'
class DocumentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @documents = current_user.documents
    @documents = @documents.where("created_at >= ?", params[:start_date]) if params[:start_date].present?
    @documents = @documents.where("created_at <= ?", params[:end_date]) if params[:end_date].present?
  end

  def new
    @document = current_user.documents.build
  end

  def show
    @document = Document.find(params[:id])
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Dokuments tika izdzēsts.' }
      format.json { head :no_content }
    end
  end

  def edit
    @document = Document.find(params[:id])
  end

  def update
    @document = Document.find(params[:id])

    if @document.update(document_params)
      redirect_to @document, notice: 'Dokuments tika atjaunināts.'
    else
      render :edit
    end
  end

  def create
    @document = current_user.documents.build(document_params)

    respond_to do |format|
      if @document.save
        format.html { redirect_to @document, notice: 'Dokuments veiksmīgi izveidots!' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end


  private

  def document_params
    params.require(:document).permit(:title, :content, documents: [])
  end

  def set_document
    @document = Document.find(document_params[:id])

    unless @document
      flash[:alert] = 'Dokuments netika atrasts'
      redirect_to documents_path
    end
  end
end
