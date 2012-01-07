module TicketsHelper
  def tickets_types_as_form_collection
    Ticket::TYPES.map do |key, value|
      [key.to_s.capitalize, value]
    end
  end
end