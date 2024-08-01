class SlotGame
  WILD_SYMBOL = 'W'  # Символ для 'wild'

  def initialize(config)
    @reels = config[:reels]
    @rows = 3
    @cols = @reels.length
    raise ArgumentError, "Reels must be an array of length #{@cols}" unless @reels.length == @cols
  end

  def spin
    screen = generate_screen
    display_screen(screen)

    if check_win(screen)
      puts "Congratulations! You won!"
    else
      puts "No win this time. Try again!"
    end
  end

  private

  def generate_screen
    screen = Array.new(@rows) { Array.new(@cols) }
    @cols.times do |col|
      reel = @reels[col]
      start_index = rand(reel.length)
      # Случайная позиция на барабане
      symbols = (0...@rows).map { |i| reel[(start_index + i) % reel.length] }

      # Добавляем wild с вероятностью 1/10
      if rand < 0.1
        wild_position = rand(@rows)
        symbols[wild_position] = WILD_SYMBOL
      end

      symbols.each_with_index do |value, row|
        screen[row][col] = value
      end
    end
    screen
  end

  def display_screen(screen)
    screen.each { |row| puts row.join("  ") }
  end

  def check_win(screen)
    winning_lines = []

    # Добавляем строки
    winning_lines.concat(screen)

    # Добавляем столбцы
    @cols.times { |col| winning_lines << screen.map { |row| row[col] } }

    # Добавляем диагонали
    winning_lines << (0...@rows).map { |i| screen[i][i] }
    winning_lines << (0...@rows).map { |i| screen[i][@rows - 1 - i] }

    # Проверка на выигрыш с учетом WILD
    winning_lines.any? { |line| winning_line?(line) }
  end

  def winning_line?(line)
    # Убираем символы WILD для проверки уникальности остальных символов
    non_wild_symbols = line.reject { |symbol| symbol == WILD_SYMBOL }

    # Если все оставшиеся символы одинаковы, или если все символы - WILD, то линия выигрышная
    non_wild_symbols.uniq.length <= 1
  end

end
