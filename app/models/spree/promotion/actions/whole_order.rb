module Spree
  class Promotion
    module Actions
      class WholeOrder < PromotionAction
        include Spree::CalculatedAdjustments
        include Spree::AdjustmentSource

        before_validation -> { self.calculator ||= Calculator::FlatPercentItemTotal.new }

        def perform(options = {})
          order = options[:order]
          create_unique_adjustment(order, order)
        end

        def compute_amount(order)
          #[(order.item_total + order.ship_total + order.additional_tax_total), compute(order)].min * -1
          #(order.item_total + order.ship_total + order.additional_tax_total) * -1
          compute(order, true) * -1
        end
      end
    end
  end
end