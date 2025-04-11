module DeviseErrorResponder
  def render_authenticate_error
    render_error(401, I18n.t("devise.failure.unauthenticated"))
  end

  def render_login_error
    key = Devise.authentication_keys.first.to_s
    render_error(401, I18n.t("devise.failure.invalid", authentication_keys: key.humanize(capitalize: false)))
  end

  def render_error(status, message, data = nil)
    response = {
      success: false,
      error: {
        status: status,
        message: message
      }
    }
    response[:data] = data if data.present?

    render status: status, json: response
  end
end
