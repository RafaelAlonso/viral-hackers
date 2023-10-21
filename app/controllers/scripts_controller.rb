class ScriptsController < ApplicationController
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
      redirect_to scripts_path
    else
      render :new
    end
  end

  def show
    @script = Script.find(params[:id])
  end

  private

  def script_params
    params.require(:script).permit(:category, :context, :duration, :mood, :description)
  end
end
