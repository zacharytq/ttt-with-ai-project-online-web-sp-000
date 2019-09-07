module Players
  class Computer < Player
    WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6] ]

    def move(board)
      function_board = Board.new(board.cells)

    end

    def get_opponent_token
      self.token == "X" ? "O" : "X"
    end

    def get_branches(board)
      output = []
      counter 1
      board.map do |x|
        if x == " "
          output << counter
          counter +=1
        end
        output
      end
    end

    def won?(board)
      WIN_COMBINATIONS.each do |combination|
          if board.cells[combination[0]] == board.cells[combination[1]] &&
            board.cells[combination[1]] == board.cells[combination[2]] &&
            board.taken?(combination[0]+1)
            return combination[0]
          end
        end
      return false
    end

    def get_static_eval(board)
      static_eval = 0
      if won?(board) == self.token
        static_eval += 1
      elsif won?(board) != self.token
        static_eval -=1
      end
      static_eval
    end

    def solve(board, player = true, depth = 0)
      static_eval = get_static_eval(board)
      if board.full? || board.won?
        return static_eval
      else
        branches = get_branches(board)
        moves = []
        if player
          moves = branches.map do |i|
            holder_board = Board.new(board.cells)
            holder_board.update(i, self.token)
            moves << 



  end
end
