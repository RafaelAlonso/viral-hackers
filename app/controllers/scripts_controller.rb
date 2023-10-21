class ScriptsController < ApplicationController
  before_action :set_script, only: %i[show]

  def index
    @scripts = current_user.scripts
  end

  def new
    @script = Script.new
  end

  def create
    @script = Script.new(script_params)
    @script.user = current_user
    if @script.save
      ScriptOutputJob.perform_later(@script.id)
      redirect_to @script
    else
      render :new
    end
  end

  def show
  end

  private

  def set_script
    @script = Script.find_by(id: params[:id])
    redirect_back fallback_location: authenticated_root_path, alert: 'Could not find script' unless @script.present?
  end

  def script_params
    params.require(:script).permit(:category_id, :context, :duration, :mood, :description, :target_audience)
  end
end
