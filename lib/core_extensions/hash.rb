module CoreExtensions
  module Hash
    # def slice(*keys)
    #   keys.map do
    #
    #   end
    # end
    #
    # def stringify_keys
    #
    # end
    #
    # def symbolize_keys
    #   transform_keys {|key|}
    # end

    def except(*keys)
      dup.except!(*keys)
    end

    def except!(*keys)
      keys.each { |key| delete(key)}
      self
    end
  end
end

Hash.send(:include, CoreExtensions::Hash) unless Hash.method_defined? :except