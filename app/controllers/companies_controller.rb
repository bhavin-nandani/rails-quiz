class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  def index
    @companies = Company.all
  end

  def show
  end

  def new
    @company = Company.new
  end

  def edit
  end

  def create
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save
        format.html { redirect_to companies_url, notice: 'Company was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: turbo_stream.replace('error_explanation', partial: 'layouts/form_errors', locals: { object: @company }) }
      end
    end
  end

  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to companies_url, notice: 'Company was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: turbo_stream.replace('form_errors', partial: 'layouts/form_errors', locals: { object: @company }) }
      end
    end
  end

  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
    end
  end

  private

    def set_company
      @company = Company.find(params[:id])
    end

    def company_params
      params.require(:company).permit(:name)
    end
end
