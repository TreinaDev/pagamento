class Transaction
  attr_accessor :id, :name, :value, :one_shot, :installments, :total_value,
                :installment_value

  def initialize(id, name, value, installments)
    @id = id
    @name = name
    @value = value.to_d
    @installments = installments.to_i
  end

  def calculate(discount_rate, interest_rate)
    calculate_discount(discount_rate)
    calculate_interest_rate(interest_rate)
    calculate_installments
  end

  def calculate_discount(discount_rate)
    @one_shot = @value - (discount_rate * @value)
  end

  def calculate_interest_rate(interest_rate)
    @total_value = @value + (interest_rate * @value)
  end

  def calculate_installments
    @installment_value = @total_value / @installments
  end
end
