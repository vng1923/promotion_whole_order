module Spree
  Calculator::FlatPercentItemTotal.class_eval do
    preference :flat_percent, :decimal, default: 0

    def self.description
      Spree.t(:flat_percent)
    end

    def compute(object, is_whole_order)
      computed_amount  = ((object.item_total + object.ship_total + object.additional_tax_total) * preferred_flat_percent / 100).round(2)
      if computed_amount > object.amount
        object.amount
      else
        computed_amount
      end
    end
  end
end