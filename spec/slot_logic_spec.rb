require './lib/slot_logic.rb'

describe SlotGame do

  describe "#initialize" do
    #Проверяем, что после создания экземпляра SlotGame атрибут @reels устанавливается корректно на основе переданной конфигурации.
    it "initializes with correct reels" do
      config = { reels: [[1, 2, 3], [4, 5, 6], [7, 8, 9]] }
      game = SlotGame.new(config)
      expect(game.instance_variable_get(:@reels)).to eq(config[:reels])
    end
  end

  describe "#generate_screen" do
   #Проверяем, что метод generate_screen создает экран правильного размера
   #и что каждый символ на экране является допустимым значением из барабанов.
    it "generates a screen of correct size" do
      config = { reels: [[1, 2, 3], [4, 5, 6], [7, 8, 9]] }
      game = SlotGame.new(config)
      screen = game.send(:generate_screen)
      expect(screen.length).to eq(3)
      expect(screen.all? { |row| row.length == 3 }).to be true
    end

    it "generates a screen with valid symbols" do
      config = { reels: [[1, 2, 3], [4, 5, 6], [7, 8, 9]] }
      game = SlotGame.new(config)
      screen = game.send(:generate_screen)
      reels = config[:reels].flatten
      expect(screen.flatten.all? { |symbol| reels.include?(symbol) }).to be true
    end
  end

  describe "#check_win" do
    #Проверяем, что метод check_win правильно определяет победную комбинацию на экране.
    it "returns true when there is a win" do
      config = { reels: [[1, 1, 1], [2, 1, 4], [5, 6, 1]] }
      game = SlotGame.new(config)
      screen = [
        [1, 2, 3],
        [4, 1, 6],
        [7, 8, 1]
      ]
      expect(game.send(:check_win, screen)).to be true
    end

    it "returns false when there is no win" do
      config = { reels: [[1, 2, 3], [4, 5, 6], [7, 8, 9]] }
      game = SlotGame.new(config)
      screen = [
        [1, 2, 3],
        [4, 3, 6],
        [7, 8, 1]
      ]
      expect(game.send(:check_win, screen)).to be false
    end
  end

end
