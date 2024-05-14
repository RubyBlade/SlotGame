class SlotGame
  def initialize(config)
    @reels = config[:reels]
  end

  def spin
   loop do
    screen = generate_screen
    display_screen(screen)

    if check_win(screen)
      puts "Congratulations! You won!"
    else
      puts "No win this time. Try again!"
    end

    puts "Press Enter to spin again or type 'exit' to quit."
    input = gets.chomp.downcase
    break if input == 'exit'
   end
  end

  private

  def generate_screen
    screen = []
    3.times { screen << @reels.map { |reel| reel.sample } }
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
