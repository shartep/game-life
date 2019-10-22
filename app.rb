
require_relative 'lib/game'

INIT_GENERATION = \
  # "      \n" +
  # "      \n" +
  # "  *** \n" +
  # " ***  \n" +
  # "      \n" +
  # "      \n"



  "                              \n" +
  "                              \n" +
  "                *             \n" +
  "    ***         *             \n" +
  "    *  *  *  *  ***   *  *    \n" +
  "    ***   *  *  *  *  *  *    \n" +
  "    *  *  *  *  *  *  *  *    \n" +
  "    *  *   **   ***    ***    \n" +
  "                         *    \n" +
  "                      ***     \n" +
  "                              \n"

game = Game.new(empty_cell: ' ', live_cell: '*', map: INIT_GENERATION)

100.times do
  puts game.screen
  puts ''
  game.do_step!

  break if game.stable
  sleep 1
end
