class JournelEntriesController < ApplicationController
    before_action :set_journel_entry, only: [:edit, :show, :update]
    def new
        @journel = AppJournel.find_by(id: params[:journel_id])
    end

    def create
        journel = AppJournel.find_by(id: params[:journel_id])
        journel_entry = journel.journel_entries.new(journel_entry_params)
        
        if journel_entry.save
            flash[:success] = "Journal entry created"
        else
            flash[:danger] = "Something went wrong"
        end
        redirect_to journel_path(journel.id)
    end

    def show
    end

    def edit
    end

    def update
        if @journel_entry.update(journel_entry_params)
            flash[:success] = "Journal entry updated"
        else
            flash[:danger] = "Something went wrong"
        end
        redirect_to journel_journel_entry_path(@journel_entry.id)
    end

    private
    def journel_entry_params
        params.require(:journel_entry).permit(:title, :body)
    end

    def set_journel_entry
        @journel_entry = JournelEntry.find_by(id: params[:id])
    end
end
