class ClientDomainConstraint
  def matches?(request)
    domains = ['client.com','localhost']
    domains.include?(request.domain.downcase)
  end
end