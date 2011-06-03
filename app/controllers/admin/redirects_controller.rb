class Admin::RedirectsController < Admin::ResourceController

  def new
    @redirect = Redirect.new
  end
    
  private
    
    def collection
      params[:search] ||= {}
      params[:search][:meta_sort] ||= "old_url.asc"
      @search = Redirect.search(params[:search])
      @collection = @search.paginate(:per_page => Spree::Config[:orders_per_page], :page => params[:page])
    end

end
