require 'spec_helper'

describe TicketAttachement do
  it { should belong_to(:ticket) }
end
