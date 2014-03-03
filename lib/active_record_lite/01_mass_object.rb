require_relative '00_attr_accessor_object.rb'

class MassObject < AttrAccessorObject
  def self.attributes
    raise Exception, "must not call #attributes on MassObject directly" if self == MassObject
    @attributes ||= []
  end

  def self.my_attr_accessible(*new_attributes)
    self.attributes.concat(new_attributes)
  end

end
