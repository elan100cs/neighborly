class ProjectTotalBuilder
  def initialize(project)
    @project = project
  end

  def attributes
    {
      net_amount:                net_amount,
      platform_fee:              platform_fee,
      pledged:                   pledged,
      progress:                  progress,
      total_contributions:       total_contributions,
      total_payment_service_fee: total_payment_service_fee
    }
  end

  def perform
    ProjectTotal.find_or_create_by(project_id: @project.id).
      update_attributes(attributes)
  end

  private

  def contributions
    @project.contributions.with_state(:confirmed, :refunded)
  end

  def net_amount
    contributions.sum(:value)
  end

  def platform_fee
    Contribution::FEE_PER_BOND * contributions.sum(:bonds)
  end

  def pledged
    contributions.sum(:value)
  end

  def progress
    if @project.goal.zero?
      0
    else
      (pledged / @project.goal * 100).to_i
    end
  end

  def total_contributions
    contributions.length
  end

  def total_payment_service_fee
    contributions.inject(0) { |sum, c| sum + c.payment_service_fee }
  end
end
