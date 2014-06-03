module Monopoly
  module Space
    module Property
      class PropertyGroup

        attr_reader :name

        def initialize(name)
          @name = name
          @properties = []
        end

        def add_property(property)
          @properties << property
        end

        def property_count
          @properties.count
        end

        def owns_count(owner)
          count = 0
          @properties.each do |property|
            count += 1 unless property.owner != owner || property.owner.nil?
          end
          count
        end

        def owns_all(owner)
          property_count == owns_count(owner) && property_count > 0
        end
      end
    end
  end
end