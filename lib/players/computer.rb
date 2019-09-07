module Players
  class Computer < Player
    def move(board)
      opponent = self.token == "X" ? "O" : "X"
      holder = board
      board.map do |x|
        if true
          charlie = over?
          binding.pry
        end
      end

    end
  end
end
