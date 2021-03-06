class Api::V1::AnswersController < Api::V1::MasterApiController
	before_action :authenticate , only: [:index, :show]
	before_action :set_answer, only: [:update, :delete]
	before_action :set_poll
	before_action(only: [:update, :destroy, :create]) { |controlador| controlador.authenticate_owner(@poll.user) }


	def create
		@answer = Answer.new(answers_params)
		if @answer.save
			render template: "api/v1/answers/show"
		else
			render json: { error: @answer.errors }, status: :unprocessable_entity
		end
	end
	def update
		if @answer.update(answers_params)
			render template: "api/v1/answers/show"
		else
			render json: { error: @answer.errors }, status: :unprocessable_entity
		end
	end
	def destroy
		@answer.destroy
		render json: { message: "Se ha eliminado" }
	end
    
    private

	def set_poll
		@poll = MyPoll.find(params[:poll_id])
	end	
	def answers_params
		params.require(:answer).permit(:description, :question_id)
	end
	def set_answer
		@answer = Answer.find(params[:id])
	end
end