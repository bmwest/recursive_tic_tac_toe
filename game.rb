require 'pry'

def print_char(c)
  puts "#{c.join(' | ')}"
end

def nil_control(item)
  if item.include?(nil)
    item.map! { |x| x == nil ? ' ' : x}
  end
end

def print_grid(board = [])
    board.each_with_index {|item, index|
      nil_control(item)
      if index == 0 || index == 1
        print_char(item)
        puts '----------'
      else
        print_char(item)
      end
    }
end

def accept_move
  print "Please enter your next move (x or o)\n> "
  move = gets.chomp
  if move.downcase == 'x' || move.downcase == 'o'
    return move
  end
  accept_move
end

def accept_row
  print "Please enter the row of next move (0, 1, or 2)\n> "
  row = gets.chomp
  if row.downcase == '0' || row.downcase == '1' || row.downcase == '2'
    return row
  end
  accept_row
end

def accept_column
  print "Please enter the column of your next move (0, 1, or 2)\n> "
  column = gets.chomp
  if column.downcase == '0' || column.downcase == '1' || column.downcase == '2'
    return column
  end
  accept_column
end

def player_move(board)
  choice = accept_move
  r = accept_row.to_i
  c = accept_column.to_i
  if board[r][c] == nil
    board[r].insert(c, choice)
    return "#{board[r][c]}"
  elsif board[r][c] == ' '
    board[r].delete_at(c)
    board[r].insert(c, choice)
    return "#{board[r][c]}"
  elsif full_board?(board) == "true"
    return
  end
  puts "This position is has been taken."
  player_move(board)
end

def computer_move(board)
  moves = ['x','o']
  row_placement = [0, 1, 2]
  column_placement = [0, 1, 2]

  m = moves.sample
  r = row_placement.sample
  c = column_placement.sample
  if board[r][c] == nil
    board[r].insert(c, m)
    puts "computer moves #{m} to [#{r}][#{c}]"
    return "#{board[r][c]}"
  elsif board[r][c] == ' '
    board[r].delete_at(c)
    board[r].insert(c, m)
    puts "computer moves #{m} to [#{r}][#{c}]"
    return "#{board[r][c]}"
  elsif full_board?(board) == "true"
    return
  end
  computer_move(board)
end

def full_board?(board)
  if board[0].include?(' ') || board[0].empty? || board[1].include?(' ') || board[1].empty? || board[2].include?(' ') || board[2].empty?
    return "false"
  else
    puts "board is full"
    return "true"
  end
end

board_a = [
  ['x', 'o', 'x'],
  ['x', nil, 'o'],
  ['x', 'o', nil]
]

board_b = [
  [nil, 'o', 'x'],
  ['x', 'o', nil],
  ['x', 'o', nil]
]

board_c = [
  [],
  [],
  []
]

while true
  player_move(board_c)
  computer_move(board_c)
  print_grid(board_c)
  if full_board?(board_c) == "true"
    puts "#{board_c[1]}"
    break
  end
end
