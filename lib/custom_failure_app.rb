# lib/custom_failure_app.rb
class CustomFailureApp < Devise::FailureApp
  def respond
    json_api_error_response
  end

  def json_api_error_response
    self.status = 401
    self.content_type = "application/json"
    self.response_body = {
      success: false,
      errors: "Invalid email or password"
    }.to_json
  end
end
