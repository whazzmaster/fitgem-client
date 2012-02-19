class FitbitDataPresenter < BasePresenter
  presents :fitbit_data

  def data_table
    if h.user_signed_in? && h.current_user.fitbit_account.verified?
      h.render 'examples/resources/api_result_table', :fitbit_data_items => fitbit_data.data
    elsif h.user_signed_in?
      h.render 'examples/link'
    else
      h.render 'examples/login_and_link'
    end
  end
end