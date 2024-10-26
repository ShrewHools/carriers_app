# frozen_string_literal: true

class AddDefaultData < ActiveRecord::Migration[6.1]
  def up
    ShippingRoute.create(origin: 'Berlin', destination: 'Warsaw')
    ShippingRoute.create(origin: 'Belfast', destination: 'Cardiff')
    ShippingRoute.create(origin: 'Prague', destination: 'Brussels')
    ShippingRoute.create(origin: 'Amsterdam', destination: 'Cologne')

    LoadType.create(name: '5 pallets')
    LoadType.create(name: '10 pallets')
    LoadType.create(name: '26 pallets')
  end

  def down
    ShippingRoute.destroy_all
    LoadType.destroy_all
  end
end
