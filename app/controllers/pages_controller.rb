class PagesController < ApplicationController
  layout "pages"
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

  # GET /pages/1
  # GET /pages/1.xml
  def show
    @page = Page.find(params[:id], :include => :document)

    doc = @page.document
    @prev_page = @page.page_no > 0 ? doc.pages[@page.page_no - 1] : nil
    @next_page = @page.number < doc.pages.size ? doc.pages[@page.number] : nil

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end
  end

  def pagesearch
    @pages = Page.paginate_search(params[:query], :page => params[:page], :per_page => 20)
  end
end
