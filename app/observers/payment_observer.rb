class PaymentObserver < ActiveRecord::Observer
  observe :contribution

  def after_create(resource)
    resource.define_key!
  end

  def before_save(resource)
    if resource.confirmed? && resource.confirmed_at.nil?
      notify_confirmation(resource)
    end
  end

  def from_confirmed_to_canceled(resource)
    notification_for_backoffice(resource, :payment_canceled_after_confirmed)
  end

  private

  def notify_confirmation(resource)
    resource.update(confirmed_at: Time.now)
    resource.notify_owner(:payment_confirmed,
                              { },
                              { project: resource.project,
                                bcc: Configuration[:email_payments] })
  end

  def notification_for_backoffice(resource, template_name, options = {})
    user = User.find_by(email: Configuration[:email_payments])

    if user
      key = resource.class.model_name.param_key
      Notification.notify_once(template_name,
                               user,
                               { "#{key}_id".to_sym => resource.id },
                               {  key.to_sym        => resource }.merge(options)
      )
    end
  end
end
