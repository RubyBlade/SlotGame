require './lib/slot_logic.rb'

RSpec.describe SlotGame do
  let(:config) do
    {
      reels: [
        [1, 2, 3, 7, 8, 9, 4, 5, 6, 7, 8, 9, 10],
        [1, 2, 3, 9, 10, 4, 5, 6, 7, 3, 4, 5, 8, 9, 10],
        [1, 9, 10, 2, 7, 8, 9, 3, 4, 5, 6, 7, 8, 9, 10, 3, 4, 5]
      ]
    }
  end

  subject { SlotGame.new(config) }

  describe '#spin' do
    it 'generates a screen with 3 rows and 3 columns' do
      allow(subject).to receive(:display_screen) #Мокаем метод, чтобы он не выводил ничего во время теста.
      screen = subject.send(:generate_screen)
      expect(screen.length).to eq(3)
      expect(screen.all? { |row| row.length == 3 }).to be true
    end

    it 'displays "Congratulations! You won!" when there is a winning line' do
      allow(subject).to receive(:display_screen)
      #Мокаем метод generate_screen, чтобы вернуть заранее определенный экран с выигрышной линией.
      allow(subject).to receive(:generate_screen).and_return([
        [10, 10, 10],
        [4, 5, 6],
        [7, 8, 9]
      ])
      expect { subject.spin }.to output(/Congratulations! You won!/).to_stdout
    end

    it 'displays "No win this time. Try again!" when there is no winning line' do
      allow(subject).to receive(:display_screen) #Мокаем методы
      allow(subject).to receive(:generate_screen).and_return([
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
      ])
      expect { subject.spin }.to output(/No win this time. Try again!/).to_stdout
    end
  end
end
