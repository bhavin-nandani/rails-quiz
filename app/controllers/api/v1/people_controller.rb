class Api::V1::PeopleController < ApplicationController
    def index
        @people = Person.all

        @people = @people.where(email: params[:email]) if params[:email].present?
        @people = @people.page(params[:page]).per(params[:per_page])
        
        # render json: @people
        render 'api/v1/people/index' , formats: [:json]
    end
end
