class SlotGame
  def initialize(config)
    @reels = config[:reels]
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
    screen = Array.new(3) { Array.new(3) }
    (0..2).each do |col|
      @reels[col].sample(3).each_with_index do |value, row|
        screen[row][col] = value
      end
    end
    screen
  end

  def display_screen(screen)
    screen.each { |row| puts row.join("  ") }
  end

  def check_win(screen)
    winning_lines = [
      [screen[0][0], screen[1][1], screen[2][2]],
      [screen[0][2], screen[1][1], screen[2][0]],
      screen[0],
      screen[1],
      screen[2]
    ]

    winning_lines.any? { |line| line.uniq.length == 1 }
  end
end
