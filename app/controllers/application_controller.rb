class ApplicationController < ActionController::API
  def render_json(body, status_code = :ok)
    render json:   body,
           status: status_code
  end

  def render_error(message, status_code = :bad_request)
    render_json(
      { error: message },
      status_code
    )
  end
end
