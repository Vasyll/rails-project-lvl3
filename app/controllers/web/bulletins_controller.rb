# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  def index
    @bulletins = Bulletin.all.order(created_at: :desc)
  end

  def show
    @bulletin = Bulletin.find(params[:id])
  end

  def new
    return redirect_to root_path, alert: t('.failure') unless signed_in?

    @bulletin = current_user.bulletins.build
  end

  def create
    return redirect_to root_path, alert: t('.failure') unless signed_in?

    @bulletin = current_user.bulletins.build(bulletin_params)

    if @bulletin.save
      redirect_to @bulletin, notice: t('.success')
    else
      render :new, alert: t('.failure')
    end
  end

  def edit
    return redirect_to root_path, alert: t('.failure') unless signed_in?

    @bulletin = Bulletin.find(params[:id])
  end

  def update
    return redirect_to root_path, alert: t('.failure') unless signed_in?

    @bulletin = Bulletin.find(params[:id])

    if @bulletin.update(bulletin_params)
      redirect_to bulletin_path(@bulletin), notice: t('.success')
    else
      render :edit, alert: t('.failure')
    end
  end

  def to_moderation
    @bulletin = Bulletin.find params[:id]
    if @bulletin.to_moderation!
      redirect_to profiles_path, notice: t('.success')
    else
      redirect_to profiles_path, notice: t('.failure')
    end
  end

  def to_archive
    @bulletin = Bulletin.find params[:id]
    if @bulletin.to_archive!
      redirect_to profiles_path, notice: t('.success')
    else
      redirect_to profiles_path, notice: t('.failure')
    end
  end

  private

  def bulletin_params
    params.required(:bulletin).permit(:title, :description, :category_id, :image)
  end
end
