# lib/middleware/jwt_exception_handler.rb
class JwtExceptionHandler
  def initialize(app)
    @app = app
    logger.debug "JwtExceptionHandler middleware initialized"
  end

  def call(env)
    @app.call(env)
  rescue JWT::DecodeError => e
    logger.debug "JWT DecodeError: #{e.message}"
    error_response("Invalid token", e.message)
  rescue JWT::ExpiredSignature => e
    logger.debug "JWT ExpiredSignature: #{e.message}"
    error_response("Token has expired")
  rescue JWT::VerificationError => e
    logger.debug "JWT VerificationError: #{e.message}"
    error_response("Token verification failed")
  end

  private

  def logger
    defined?(Rails) && Rails.respond_to?(:logger) ? Rails.logger : Logger.new(STDOUT)
  end

  def error_response(message, details = nil)
    body = { error: message }
    body[:details] = details if details
    [
      401,
      { "Content-Type" => "application/json" },
      [ body.to_json ]
    ]
  end
end
