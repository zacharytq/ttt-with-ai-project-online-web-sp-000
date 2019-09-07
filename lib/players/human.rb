module Players
  class Human < Player
    def move(board)
      puts "Please make a move."
      x = gets
      done = board.valid_move?(x)
      while done == false
        puts "please make a move"
        x = gets
        done = board.valid_move?(x)
      end
      x
    end
  end
end
