class BusinessProfileSerializer < BaseProfileSerializer
  attributes :name

  def name
    object.first_name
  end
end
