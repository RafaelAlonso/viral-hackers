class ScriptsController < ApplicationController
  before_action :set_script, only: %i[show retry cancel destroy]

  def index
    @scripts = current_user.scripts.includes(:category).order(id: :desc)
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

  def retry
    if @script.update(status: :pending)
      ScriptOutputJob.perform_later(@script.id)
    else
      render :show, alert: 'Erro ao tentar gerar output'
    end
  end

  def cancel
    if @script.canceled!
      redirect_back fallback_location: @script
    else
      redirect_back fallback_location: authenticated_root_path, alert: 'Erro ao tentar cancelar script.'
    end
  end

  def destroy
    if @script.destroy
      redirect_to authenticated_root_path
    else
      redirect_back fallback_location: authenticated_root_path, alert: 'Erro ao tentar deletar script.'
    end
  end

  private

  def set_script
    @script = Script.find_by(id: params[:id])
    redirect_back fallback_location: authenticated_root_path, alert: 'Script não pôde ser encontrado' unless @script.present?
  end

  def script_params
    params.require(:script).permit(:category_id, :context, :duration, :mood, :description, :target_audience)
  end
end
