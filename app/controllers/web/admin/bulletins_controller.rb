# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  def index
    @q = Bulletin.all.ransack(params[:q])
    @bulletins = @q.result.page(params[:page])
  end

  def publish
    @bulletin = Bulletin.find params[:id]
    if @bulletin.publish!
      redirect_to request.referer || admin_root_path, notice: t('.success')
    else
      redirect_to admin_root_path, notice: t('.failure')
    end
  end

  def reject
    @bulletin = Bulletin.find params[:id]
    if @bulletin.reject!
      redirect_to request.referer || admin_root_path, notice: t('.success')
    else
      redirect_to admin_root_path, notice: t('.failure')
    end
  end

  def archive
    @bulletin = Bulletin.find params[:id]
    if @bulletin.archive!
      redirect_to request.referer || admin_root_path, notice: t('.success')
    else
      redirect_to admin_root_path, notice: t('.failure')
    end
  end
end
