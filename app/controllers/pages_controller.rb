class PagesController < ApplicationController
  layout "pages"
  # GET /pages
  # GET /pages.xml
  def index
    @pages = Page.paginate(:per_page => 20, :page => (params[:page] || 1), :include => :document, :order => "document_id, page_no")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.xml
  def show
    @page = Page.find(params[:id])
    @detail = Detail.new(:page => @page)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end
  end

  def pagesearch
    @pages = Page.paginate_search(params[:query], :page => params[:page], :per_page => 20)
    render :template => "pages/index"
  end
end
