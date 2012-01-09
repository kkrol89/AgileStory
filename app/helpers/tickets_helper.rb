module TicketsHelper
  def tickets_types_as_form_collection
    Ticket::TYPES.map do |key, value|
      [key.to_s.capitalize, value]
    end
  end

  def story_type_icon_for(ticket)
    ticket.story.first(1).upcase
  end
end