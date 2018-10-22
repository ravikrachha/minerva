class JournelsController < ApplicationController
  before_action :set_journel, only: [:show, :search_entries, :graph_data]
  before_action :set_session

  def index
  	@journels = AppJournel.all
  end

  def new
  end
  
  def show
    #clear search session value
    session[:journel_entries]["search"] = ""
    journel_entries = @journel.journel_entries
    @journel_entries_date = journel_entries.order(:created_at).group_by{|je| je.created_at.beginning_of_day}
    graph_data = {}
    @graph_data = prepare_graph_data(journel_entries)
  end

  def create
  	journel = AppJournel.new(journel_params)
  	
  	if journel.save
  		flash[:success] = "Journal created"
  	else
  		flash[:danger] = "Something went wrong"
  	end
  	redirect_to journels_path
  end

  def search_entries
    # Set search params in session, it will be used narrow the graph data
    session[:journel_entries]["search"] = params[:search]
    journel_entries = @journel.journel_entries.where('title like ?', "%#{params[:search]}%")
    @journel_entries_date = journel_entries.order(:created_at).group_by{|je| je.created_at.beginning_of_day}
    @graph_data = prepare_graph_data(journel_entries)
    render "show"
  end

  def search
    @journels = AppJournel.all.where('name like ?', "%#{params[:search]}%")
    render "index"
  end

  def graph_data
    if session[:journel_entries]["search"].present?
      journel_entries = @journel.journel_entries.where('title like ?', "%#{session[:journel_entries]["search"]}%")
    else
      journel_entries = @journel.journel_entries
    end 
    @graph_data = prepare_graph_data(journel_entries)
  end

  private

  def journel_params
  	params.require(:journel).permit(:name)
  end

  def set_journel
    @journel = AppJournel.find_by(id: params[:id])
  end

  def set_session
    session[:journel_entries] = session[:journel_entries] || {}
  end

  def prepare_graph_data(journel_entries)
    graph_data = {}
    if params[:graph_filter] == "w" || params[:graph_filter] == "m"
      data = journel_entries.group_by_day(:created_at, format: "%m/%d/%Y").count
      graph_data = {
        data: data,
        xtitle: "Days",
        ytitle: "Entries"
      }
    else
      data = journel_entries.group_by_month(:created_at, format: "%b %Y").count
      graph_data = {
        data: data,
        xtitle: "Months",
        ytitle: "Entries"
      }
    end
    graph_data
  end
end
