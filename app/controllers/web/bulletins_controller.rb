# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  after_action :verify_authorized, except: %i[index show]

  def index
    @q = Bulletin.published.order(created_at: :desc).ransack(params[:q])
    @bulletins = @q.result.with_attached_image.page(params[:page]).per(16)
  end

  def show
    @bulletin = Bulletin.find(params[:id])

    authorize @bulletin
  end

  def new
    authorize Bulletin

    @bulletin = current_user.bulletins.build
  end

  def create
    authorize Bulletin

    @bulletin = current_user.bulletins.build(bulletin_params)

    if @bulletin.save
      redirect_to @bulletin, notice: t('.success')
    else
      render :new, alert: t('.failure')
    end
  end

  def edit
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin
  end

  def update
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin

    if @bulletin.update(bulletin_params)
      redirect_to bulletin_path(@bulletin), notice: t('.success')
    else
      render :edit, alert: t('.failure')
    end
  end

  def to_moderate
    @bulletin = Bulletin.find params[:id]
    authorize @bulletin, :update?

    if @bulletin.to_moderate!
      redirect_to profile_path, notice: t('.success')
    else
      redirect_to profile_path, notice: t('.failure')
    end
  end

  def archive
    @bulletin = Bulletin.find params[:id]
    authorize @bulletin, :update?

    if @bulletin.archive!
      redirect_to profile_path, notice: t('.success')
    else
      redirect_to profile_path, notice: t('.failure')
    end
  end

  private

  def bulletin_params
    params.required(:bulletin).permit(:title, :description, :category_id, :image)
  end
end
