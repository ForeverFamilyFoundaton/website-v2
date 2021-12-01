class SitterformsController < ApplicationController
  before_action :set_sitterform, only: [:show, :edit, :update, :destroy]

  def index
    @sitterform = Sitterform.all
  end

  def new
    @user = User.find(current_user.id)
    if Sitterform.exists?(user_id: current_user.id)
      @sitterform = Sitterform.find_by(user_id: current_user.id)
      build_known_deads
      redirect_to action: 'edit', id: @sitterform.id
    else
      @sitterform = Sitterform.new()
      build_known_deads
    end
    @relationships = Relationship.all

    @sitterform.user_id = current_user.id
  end

  def edit
    @sitterform = Sitterform.find(params[:id])
    if (@sitterform.user_id != current_user.id)
      redirect_to root_path
    end

    @user = User.find(@sitterform.user_id)
    n = @sitterform.known_deads.count
    (5-n).times {@sitterform.known_deads.build}
  end

  def create
    @sitterform = current_user.build_sitterform sitterform_params
    if @sitterform.save
      if @sitterform.signature_checkbox
        @user = current_user
        @user.sitter_registration = false
        @user.save
      end
      UserMailer.new_sitter_registration_notification(current_user).deliver
      redirect_to current_user, notice: 'Sitterform was successfully created.'
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @sitterform.update(sitterform_params)
        if @sitterform.signature_checkbox
          @user = current_user
          @user.sitter_registration = false
          @user.save
        end
        format.html { redirect_to @sitterform, notice: 'Sitterform was successfully updated.' }
        format.json { render :show, status: :ok, location: @sitterform }
      else
        build_known_deads
        format.html { render :edit }
        format.json { render json: @sitterform.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @sitterform = Sitterform.find(params[:id])
    @sitterform.destroy
    respond_to do |format|
      format.html { redirect_to @sitterform, notice: 'Sitterform was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def build_known_deads
      if @sitterform.known_deads.nil?
        5.times {@sitterform.known_deads.build}
      else
        n = @sitterform.known_deads.count
        (5-n).times {@sitterform.known_deads.build}
      end
    end

    def set_sitterform
      @sitterform = Sitterform.find(params[:id])

    end

    def sitterform_params
      params.require(:sitterform).permit(
        :alt_email,
        :been_to_medium,
        :belief_type_id,
        :blog,
        :cell,
        :facebook,
        :instagram,
        :lost_loved_one,
        :medium_contacts,
        :phone,
        :pinterest,
        :related_contact_info,
        :twitter,
        :user_id,
        :website,
        :youtube,
        :signature,
        :signature_checkbox,
        known_deads_attributes: [
          :_destroy,
          :id,
          :name,
          :relationship_id,
          :sitterform_id,
          :user_id,
          :year_of_death
        ]
      )
    end
end

