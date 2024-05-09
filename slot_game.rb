require_relative './lib/slot_logic'

config = {
  reels: [
    [1, 2, 3, 7, 8, 9, 4, 5, 6, 7, 8, 9, 10],
    [1, 2, 3, 9, 10, 4, 5, 6, 7, 3, 4, 5, 8, 9, 10],
    [1, 9, 10, 2, 7, 8, 9, 3, 4, 5, 6, 7, 8, 9, 10, 3, 4, 5]
  ]
}

game = SlotGame.new(config)
game.spin
