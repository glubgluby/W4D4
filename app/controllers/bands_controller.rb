class BandsController < ApplicationController
    def new
        render :new
    end

    def show
        @band = Band.find_by(id: params[:id])
        render :show
    end

    def edit
        render :edit
    end
    
    def destroy
        @band = Band.find(params[:id])
        @band.destroy
        redirect_to bands_url
    end

    def update
        @band = Band.find(params[:id])
        if @band.update_attributes(parse_band)
            render :show
        else
            flash[:errors] = ["brah your band needs a name dude"]
            render :edit
        end
    end

    def create
        @band = Band.new(parse_band)
        if @band.save
            redirect_to band_url(@band)
        else
            flash[:errors] = ["brah your band needs a name dude"]
            render :new
        end

    end

    def index
        @bands = Band.all
        render :index
    end


    private
    def parse_band
        params.require(:band).permit(:name)
    end
end