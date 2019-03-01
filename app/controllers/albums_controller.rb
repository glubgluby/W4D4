class AlbumsController < ApplicationController



    def index
        debugger
        if params.has_key?(:band_id)
            @albums = Album.where(band_name: params[:band_id])
        else
            @albums = Album.all
        end
        render :index
    end

    def new
        @album = Album.new
        render :new
    end

    def create
        debugger
        @album = Album.new(album_params)
        if @album.save
            redirect_to band_url(@album.band_name)
        else
            flash[:errors] = @album.errors.full_messages
            redirect_to band_url(@album.band_name)
        end
    end
    def show
        @album = Album.find_by(id: params[:id])
        render :show
    end

    def edit
        @album = Album.find_by(id: params[:id])
        render :edit
    end

    def destroy
        @album = Album.find_by(id: params[:id])
        @album.destroy
        redirect_to band_url(@album.band_name)
    end
    def update
        @album = Album.find(params[:id])
        if @album.update_attributes(album_params)
            render :show
        else
            flash[:errors] = ["Woah that was whack"]
            render :edit
        end
    end

    private
    def album_params
        params.require(:album).permit(:title, :year, :live?, :band_name)
    end
end