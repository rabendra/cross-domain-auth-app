module API
  class ContactsController < BaseController
    def create
      permitted_params[:contacts].each do |attributes|
        Users::CreateInvitationJob.perform_later(current_user, attributes.to_h)
      end

      head :no_content
    end

    private

    def permitted_params
      params.permit(contacts: %i(first_name last_name email))
    end
  end
end
