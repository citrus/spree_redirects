class Admin::RedirectsController < Admin::ResourceController

  def new
    @redirect = Redirect.new
  end
    
  private
    
    def collection
      params[:search] ||= {}
      params[:search][:meta_sort] ||= "old_url.asc"
      @search = Redirect.search(params[:search])
      @collection = @search.page(params[:page]).per(Spree::Config[:orders_per_page])
    end

end
