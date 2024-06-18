class PeopleController < ApplicationController

  def index
    @people = Person.all
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.create(person_attributes)
    if @person.persisted?
      redirect_to people_path, notice: 'Successfully created entry'
    else
      respond_to do |format|
        format.html { render :new }
        format.turbo_stream { render turbo_stream: turbo_stream.replace('error_explanation', partial: 'form_errors', locals: { person: @person }) }
      end
    end
  end

  private

  def person_attributes
    params.require(:person).permit(:name, :email, :phone_number)
  end

end

