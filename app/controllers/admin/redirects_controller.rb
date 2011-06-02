class Admin::RedirectsController < Admin::ResourceController

  before_filter :load_data, :only => [ :new, :create, :edit, :update ]
   
	def index
	   #  render :template => request.xhr? ? 'admin/uploads/picker' : 'admin/uploads/index', :layout => !request.xhr?
  end
  
  def new
    @redirect = Redirect.new
  end
  
    
  private
  
    def load_data
      @state_options   = State.order(:name).all.map{|s| [s.name, s.id] }
      @country_options = Country.order(:name).all.map{|c| [c.name, c.id] }
    end
  
    def collection
      params[:search] ||= {}
      params[:search][:meta_sort] ||= "old_url.asc"
      @search = Redirect.search(params[:search])
      @collection = @search.paginate(:per_page => Spree::Config[:orders_per_page], :page => params[:page])
    end

end
