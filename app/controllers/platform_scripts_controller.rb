class PlatformScriptsController < ApplicationController
  before_action :set_script, only: [:create]
  before_action :set_platform_script, except: [:create]

  def create
    @platform_script = @script.platform_scripts.new(platform_script_params)
    if @platform_script.save
      PlatformScriptOutputJob.perform_later(@platform_script.id)
      redirect_to @platform_script
    end
  end

  def retry
    if @platform_script.update(status: :pending)
      PlatformScriptOutputJob.perform_later(@platform_script.id)
    else
      render :show, alert: 'Erro ao tentar gerar output'
    end
  end

  def cancel
    if @platform_script.canceled!
      redirect_back fallback_location: @platform_script
    else
      redirect_back fallback_location: authenticated_root_path, alert: 'Erro ao tentar cancelar script de plataforma.'
    end
  end

  def destroy
    if @platform_script.destroy
      redirect_to authenticated_root_path
    else
      redirect_back fallback_location: authenticated_root_path, alert: 'Erro ao tentar deletar script de plataforma.'
    end
  end

  private

  def set_script
    @script = current_user.scripts.find_by(id: params[:script_id])
    redirect_back fallback_location: authenticated_root_path, alert: 'Script não pôde ser encontrado' unless @script.present?
  end

  def set_platform_script
    @platform_script = PlatformScript.find_by(id: params[:script_id])
    redirect_back fallback_location: authenticated_root_path, alert: 'Script de plataforma não pôde ser encontrado' unless @platform_script.present?
  end

  def platform_script_params
    params.require(:platform_script).permit(:platform)
  end
end
