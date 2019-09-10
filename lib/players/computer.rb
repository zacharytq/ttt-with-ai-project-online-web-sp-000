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

    MOVES = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

    def move(board)
      moves = {:one => [],
               :neg => [],
               :zero => []}
      MOVES.map do |move|
        holder_board = Board.new(board.cells)
        holder_board.update(move, self)
        weight = solve(holder_board)
        case weight
        when 1
          moves[:one] << move
        when 0
          moves[:zero] << move
        when -1
          moves[:neg] << move
        end

      end

      output = ""
      if moves[:one].empty? == false
        output = moves[:one].sample
      elsif moves[:zero].empty? == false
        output = moves[:zero].sample
      else
        output = moves[:neg].sample
      end
      output
    end

    def get_opponent_token
      self.token == "X" ? "O" : "X"
    end

    def get_branches(board)
      output = []
      counter = 1
      board.cells.map do |x|
        if x == " "
          output << counter
          counter +=1
        end
      end
      output
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
      elsif won?(board) == self.get_opponent_token
        static_eval -=1
      end
      static_eval
    end

    def solve(board, player = false)
      static_eval = get_static_eval(board)
      if board.full? || self.won?(board)
        static_eval
      else
        branches = self.get_branches(board)
        best_value = 0
        if player
          branches.map do |i|
            best_value = -1
            holder_board = Board.new(board.cells)
            holder_board.update(i, self)
            v = solve(holder_board)
            best_value = [best_value, v].max
          end
        else
          branches.map do |i|
            best_value = 1
            holder_board = Board.new(board.cells)
            holder_board.update_with_token(i, self.get_opponent_token)
            v = solve(holder_board, true )
            best_value = [best_value, v].min
          end
        end
        best_value
      end
    end
  end
end
