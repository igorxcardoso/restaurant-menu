class Api::V1::ImportsController < ApplicationController
  # POST /api/v1/imports
  # Accepts raw JSON body or file param named `file` containing JSON
  def create
    payload = if params[:file].present?
                JSON.parse(params[:file].read)
              else
                JSON.parse(request.raw_post)
              end

    result = JsonImporterService.new(payload).call
    status = result ? :ok : :unprocessable_entity
    render json: { success: result }, status: status
  rescue JSON::ParserError => e
    render json: { success: false, error: "invalid_json", message: e.message }, status: :bad_request
  end
end
