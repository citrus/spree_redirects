class Spree::Admin::RedirectsController < Spree::Admin::ResourceController

  def new
    @redirect = Spree::Redirect.new
  end
    
  private
    
    def collection
      params[:search] ||= {}
      params[:search][:meta_sort] ||= "old_url.asc"
      @search = Spree::Redirect.search(params[:search])
      @collection = @search.page(params[:page]).per(Spree::Config[:orders_per_page])
    end

end
