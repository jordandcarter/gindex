class WebsitesController < ApplicationController
  before_filter :require_user
  
  # GET /websites
  # GET /websites.xml
  def index
    @websites.sort! {|a,b| (b.counts.last.nil? ? 0 : b.counts.last.count) <=> (a.counts.last.nil? ? 0 : a.counts.last.count)}

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @websites }
    end
  end

  # GET /websites/1
  # GET /websites/1.xml
  def show
    @website = Website.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @website }
    end
  end

  # GET /websites/new
  # GET /websites/new.xml
  def new
    @website = Website.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @website }
    end
  end

  # GET /websites/1/edit
  def edit
    @website = Website.find(params[:id])
  end

  # POST /websites
  # POST /websites.xml
  def create
    @website = Website.find_or_create_by_url(params[:website][:url])

    respond_to do |format|
      if @website.save
      current_user.websites << @website
      #@website.count if @website.counts.last.nil?
      
        flash[:notice] = 'Website was successfully created.'
        format.html { redirect_to(websites_path) }
        format.xml  { render :xml => @website, :status => :created, :location => @website }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @website.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /websites/1
  # PUT /websites/1.xml
  def update
    @website = Website.find(params[:id])

    respond_to do |format|
      if @website.update_attributes(params[:website])
        flash[:notice] = 'Website was successfully updated.'
        format.html { redirect_to(@website) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @website.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /websites/1
  # DELETE /websites/1.xml
  def destroy
    @website = current_user.user_websites.find_by_website_id(params[:id])
    @website.destroy

    respond_to do |format|
      format.html { redirect_to(websites_url) }
      format.xml  { head :ok }
    end
  end
end
