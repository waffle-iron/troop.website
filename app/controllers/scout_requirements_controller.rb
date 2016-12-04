class ScoutRequirementsController < ApplicationController
   before_action :set_scout_requirement, only: [:show, :edit, :update]
   before_action :authenticate_user!
   before_action :require_admin_user, only: [:destroy, :index]
  #
  # GET /scout_requirements
  # GET /scout_requirements.json
   def index
     @scout_requirements = ScoutRequirement.all
   end
  #
  # GET /scout_requirements/1
  # GET /scout_requirements/1.json
   def show

   end
  #
  # GET /scout_requirements/new
   def new
    @scout_requirement = ScoutRequirement.new
   end
  #
  # GET /scout_requirements/1/edit
   def edit

   end
  #
  # POST /scout_requirements
  # POST /scout_requirements.json
   def create
    @scout_requirement = ScoutRequirement.new(scout_requirement_params)

    respond_to do |format|
      if @scout_requirement.save
        format.html {
          flash[:success] = "Scout's Requirement was successfully was successfully created."
          redirect_to :back
        }
        format.json { render :show, status: :created, location: @scout_requirement }
      else
        format.html { render :new }
        format.json { render json: @scout_requirement.errors, status: :unprocessable_entity }
      end
    end
  end
  #
  # PATCH/PUT /scout_requirements/1
  # PATCH/PUT /scout_requirements/1.json
   def update
    respond_to do |format|
      if @scout_requirement.update(scout_requirement_params)
        format.html {
          flash[:success] = "Scout's Requirement was successfully updated."
          redirect_to :back
        }
        format.json { render :show, status: :ok, location: @scout_requirement }
      else
        format.html { render :edit }
        format.json { render json: @scout_requirement.errors, status: :unprocessable_entity }
      end
    end
   end
  #
  # DELETE /scout_requirements/1
  # DELETE /scout_requirements/1.json
   def destroy
    @scout_requirement.destroy
    respond_to do |format|
      format.html {
        flash[:danger] = 'Sign off for this requirement was successfully removed.'
        redirect_to scout_requirements_path
      }
      format.json { head :no_content }
    end
   end

   private
  # Use callbacks to share common setup or constraints between actions.
   def set_scout_requirement
     @scout_requirement = ScoutRequirement.find(params[:id])
   end
  #
  # Never trust parameters from the scary internet, only allow the white list through.
   def scout_requirement_params
     params.require(:scout_requirement).permit(:scout_id, :requirement_id, :sign_off, :completed_date)
   end
  #
   def require_admin_user
     if !current_user.admin?
       flash[:danger] = 'Sorry you do not have permissions to modify scout_requirements'
       redirect_to category_path
     end
   end
end