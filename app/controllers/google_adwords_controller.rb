#Generado con Keppler.
class GoogleAdwordsController < ApplicationController  
  before_filter :authenticate_user!
  layout 'admin/application'
  load_and_authorize_resource
  before_action :set_google_adword, only: [:show, :edit, :update, :destroy]
  before_action :show_history, only: [:index]

  # GET /google_adwords
  def index
    google_adwords = GoogleAdword.searching(@query).all
    @objects, @total = google_adwords.page(@current_page), google_adwords.size
    redirect_to google_adwords_path(page: @current_page.to_i.pred, search: @query) if !@objects.first_page? and @objects.size.zero?
  end

  # GET /google_adwords/1
  def show
  end

  # GET /google_adwords/new
  def new
    @google_adword = GoogleAdword.new
  end

  # GET /google_adwords/1/edit
  def edit
  end

  # POST /google_adwords
  def create
    @google_adword = GoogleAdword.new(google_adword_params)

    if @google_adword.save
      redirect_to @google_adword, notice: t('keppler.messages.successfully.created', model: t("keppler.models.singularize.google_adword").humanize) 
    else
      render :new
    end
  end

  # PATCH/PUT /google_adwords/1
  def update
    if @google_adword.update(google_adword_params)
      redirect_to @google_adword, notice: t('keppler.messages.successfully.updated', model: t("keppler.models.singularize.google_adword").humanize) 
    else
      render :edit
    end
  end

  # DELETE /google_adwords/1
  def destroy
    @google_adword.destroy
    redirect_to google_adwords_url, notice: t('keppler.messages.successfully.deleted', model: t("keppler.models.singularize.google_adword").humanize) 
  end

  def destroy_multiple
    GoogleAdword.destroy redefine_ids(params[:multiple_ids])
    redirect_to google_adwords_path(page: @current_page, search: @query), notice: t('keppler.messages.successfully.removed', model: t("keppler.models.singularize.google_adword").humanize) 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_google_adword
      @google_adword = GoogleAdword.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def google_adword_params
      params.require(:google_adword).permit(:url, :campaign_name, :description, :script)
    end

    def show_history
      if current_user.has_role? :admin
        @activities = PublicActivity::Activity.where(trackable_type: 'GoogleAdword').order("created_at desc").limit(50)
      else
        @activities = PublicActivity::Activity.where("trackable_type = 'GoogleAdword' and owner_id=#{current_user.id}").order("created_at desc").limit(50)
      end
    end
end
