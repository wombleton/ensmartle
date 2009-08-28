class DocumentsController < ApplicationController
  layout "pages", :except => :referendum
  # GET /pages
  # GET /pages.xml
  def index
    @documents = Document.paginate_by_date(params[:year], params[:month], params[:day], params[:page])
    @documents_by_date = @documents.group_by(&:date)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
    end
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.create(params[:document])
    if @document.save
      flash[:notice] = 'Successfully parsed document.'
      redirect_to @document
    else
      flash[:notice] = "Could not parse document: " << @document.errors.full_messages.join("; ")
      render :action => "new"
    end
  end

  def show
    @document = Document.find(params[:id])
  end

  def redirect
    if params[:id].nil?
      redirect_to documents_path
    else
      @page = Page.find(params[:id])
      redirect_to @page
    end
  end
end
