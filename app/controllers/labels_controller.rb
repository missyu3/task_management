class LabelsController < ApplicationController
  before_action :find_params, only: [:destroy]

  def new
    @label = Label.new
  end

  def create
    @label = Label.new(label_params)
    if @label.save
      redirect_to labels_path
    else
      render :new
    end
  end

  def index
    @labels = Label.all
  end

  def destroy
    @label.destroy
    redirect_to labels_path
  end

  private

  def label_params
    params.require(:label).permit(:name)
  end

  def find_params
    @label = Label.find(params[:id])
  end

end
