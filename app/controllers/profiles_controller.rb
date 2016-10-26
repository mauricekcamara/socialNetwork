class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  load_and_authorize_resource
  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  def create
    if current_user.profile.present?
      flash[:error] = "you already have a profile"
      redirect_to edit_profile_path(current_user)
    else
     @profile = Profile.new(profile_params)
     @profile.user = current_user
    
    # @profile = Users::Profile.new(profile_params)
    # @profile.user = current_user
  
    # authorize! :create, @profile

      respond_to do |format|
        if @profile.save
          format.html { redirect_to main_app.root_url, notice: 'Profile was successfully created.' }
          format.json { render :show, status: :created, location: @profile }
        else
          format.html { render :new }
          format.json { render json: @profile.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to main_app.root_url, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:title, :location, :user_id, :phone, schools_attributes: [:id, :name, :year, :degree, :done, :_destroy])
    end
end
