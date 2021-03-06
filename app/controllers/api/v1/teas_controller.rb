class Api::V1::TeasController < ApplicationController

  def index
    teas = Tea.all
    render json: TeaSerializer.new(teas)
  end
  
  def show
    tea = Tea.find_by(id: params[:id])
      if tea
          render json: TeaSerializer.new(tea)
      else
          render json: {message: 'Tea not found'}
      end
  end

  def create
    category = Category.find_by(id: tea_params["category_id"])

    tea = Tea.new(tea_params)
    tea.category = category

    if tea.save!
      render json: TeaSerializer.new(tea)
    else
      render json: {message: 'Your tea creation did not save'}
    end
  end

  def update
    tea = Tea.find_by(id: params[:id])
    tea.update(tea_params)
    render json: TeaSerializer.new(tea), status: 200
  end

  def destroy
    tea = Tea.find_by(id: params[:id])
    tea.delete
    render json: {teaId: tea.id}
  end

  private

  def tea_params
    params.require(:tea).permit(:name, :time, :amount, :temp, :water, :notes, :category_id)
  end
end
