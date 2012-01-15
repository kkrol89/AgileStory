class Board::BaseController < ApplicationController
  def board
    @board ||= Board.find(params[:board_id])
  end

  def project
    @project ||= board.project
  end
end