class AttrAccessorObject

  def self.my_attr_accessor(*names)
    names.each do |name|
      define_method("#{name}".to_sym) do
        instance_variable_get("@#{name}".to_sym)
      end

      define_method("#{name}=".to_sym) do |value=nil|
        instance_variable_set("@#{name}".to_sym, value)
      end
    end
  end
end