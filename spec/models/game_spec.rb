require 'rails_helper'
require 'pry'

RSpec.describe Game, type: :model do
  describe '#available' do
    context 'When there is no game at all' do
      it 'Should return an empty array' do
        expect(Game.available).to eq []
      end
    end

    context 'When there are games' do
      let!(:game) { FactoryGirl.create(:game) }

      context 'When all games have both players' do
        it 'Should return an empty array' do
          expect(Game.available).to eq []
        end
      end

      context 'When there are some open games' do
        it 'Should return all open games' do
          # a game that has only one player (player1)
          game2 = FactoryGirl.create(:game, player_2: nil)

          # a game that has only one player (player2)
          game3 = FactoryGirl.create(:game, player_1: nil)

          expect(Game.available.count).to eq 2
          expect(Game.available).to include game2
          expect(Game.available).to include game3
        end
      end
    end
  end

  describe '#populate game' do
    def expect_a_piece(attributes)
      piece = game.pieces.where(attributes).first
      unless piece
        puts 'Missing piece'
        pp attributes
      end
      expect(piece).to be_a_kind_of(Piece)
    end

    let(:game) { FactoryGirl.create(:game) }

    before(:each) { game.populate_game! }

    it 'should start with 32 pieces' do
      expect(game.pieces.size).to eq(32)
    end

    it 'should not populate the game again if it has already been populated' do
      game = FactoryGirl.create(:game)
      game.populate_game!

      game.populate_game!
      expect(game.pieces.count).to eq 32
    end

    it 'should populate the game with the correct starting locations' do
      expect_a_piece(x_coordinate: 0, y_coordinate: 0, color: 'white', type: 'Rook')
      expect_a_piece(x_coordinate: 1, y_coordinate: 0, color: 'white', type: 'Knight')
      expect_a_piece(x_coordinate: 2, y_coordinate: 0, color: 'white', type: 'Bishop')
      expect_a_piece(x_coordinate: 3, y_coordinate: 0, color: 'white', type: 'Queen')
      expect_a_piece(x_coordinate: 4, y_coordinate: 0, color: 'white', type: 'King')
      expect_a_piece(x_coordinate: 5, y_coordinate: 0, color: 'white', type: 'Bishop')
      expect_a_piece(x_coordinate: 6, y_coordinate: 0, color: 'white', type: 'Knight')
      expect_a_piece(x_coordinate: 7, y_coordinate: 0, color: 'white', type: 'Rook')

      expect_a_piece(x_coordinate: 0, y_coordinate: 1, color: 'white', type: 'Pawn')
      expect_a_piece(x_coordinate: 1, y_coordinate: 1, color: 'white', type: 'Pawn')
      expect_a_piece(x_coordinate: 2, y_coordinate: 1, color: 'white', type: 'Pawn')
      expect_a_piece(x_coordinate: 3, y_coordinate: 1, color: 'white', type: 'Pawn')
      expect_a_piece(x_coordinate: 4, y_coordinate: 1, color: 'white', type: 'Pawn')
      expect_a_piece(x_coordinate: 5, y_coordinate: 1, color: 'white', type: 'Pawn')
      expect_a_piece(x_coordinate: 6, y_coordinate: 1, color: 'white', type: 'Pawn')
      expect_a_piece(x_coordinate: 7, y_coordinate: 1, color: 'white', type: 'Pawn')

      expect_a_piece(x_coordinate: 0, y_coordinate: 6, color: 'black', type: 'Pawn')
      expect_a_piece(x_coordinate: 1, y_coordinate: 6, color: 'black', type: 'Pawn')
      expect_a_piece(x_coordinate: 2, y_coordinate: 6, color: 'black', type: 'Pawn')
      expect_a_piece(x_coordinate: 3, y_coordinate: 6, color: 'black', type: 'Pawn')
      expect_a_piece(x_coordinate: 4, y_coordinate: 6, color: 'black', type: 'Pawn')
      expect_a_piece(x_coordinate: 5, y_coordinate: 6, color: 'black', type: 'Pawn')
      expect_a_piece(x_coordinate: 6, y_coordinate: 6, color: 'black', type: 'Pawn')
      expect_a_piece(x_coordinate: 7, y_coordinate: 6, color: 'black', type: 'Pawn')

      expect_a_piece(x_coordinate: 0, y_coordinate: 7, color: 'black', type: 'Rook')
      expect_a_piece(x_coordinate: 1, y_coordinate: 7, color: 'black', type: 'Knight')
      expect_a_piece(x_coordinate: 2, y_coordinate: 7, color: 'black', type: 'Bishop')
      expect_a_piece(x_coordinate: 3, y_coordinate: 7, color: 'black', type: 'Queen')
      expect_a_piece(x_coordinate: 4, y_coordinate: 7, color: 'black', type: 'King')
      expect_a_piece(x_coordinate: 5, y_coordinate: 7, color: 'black', type: 'Bishop')
      expect_a_piece(x_coordinate: 6, y_coordinate: 7, color: 'black', type: 'Knight')
      expect_a_piece(x_coordinate: 7, y_coordinate: 7, color: 'black', type: 'Rook')
    end
  end

  describe '#render_piece' do
    let(:game) { FactoryGirl.create(:game) }

    context 'When there is a piece for the coordinate' do
      it 'Should return the icon' do
        FactoryGirl.create(:piece, x_coordinate: 0, y_coordinate: 1, player: game.player_1, game: game, icon: 'myimage.png')

        expect(game.render_piece(0, 1)).to eq 'myimage.png'
      end
    end

    context 'When there is not a piece for the coordinate' do
      it 'Should return empty string' do
        expect(game.render_piece(0, 1)).to eq nil
      end
    end
  end

  describe '#check?' do
    let(:opposite_color) { 'black' }
    let(:game) { create(:game) }
    # player2's king
    let(:player2_king) { create(:king, player: game.player_2, game: game, x_coordinate: 3, y_coordinate: 3, color: 'black') }
    let!(:player1_king) { create(:king, player: game.player_1, game: game, x_coordinate: 0, y_coordinate: 0, color: 'white') }

    context "When no chess piece from the opponent can capture the current player's king" do
      it 'Returns false' do
        player2_king

        expect(game.check?(opposite_color)).to be false
      end
    end

    context "When there's at least one chess piece from the opponent can capture the current player's king" do
      context "When the oppnent player's rook can capture the current player's king" do
        # _______________
        # |__|__|k |__|L1|
        # |__|__|__|__|__|
        # |__|__|L2|__|__|
        context 'With the rook on the same vertical line and no obstruction in between' do
          it 'returns true' do
            # data setup
            create(:rook, player: game.player_1, game: game, x_coordinate: 3, y_coordinate: 1, color: 'white')
            player2_king

            expect(game.check?(opposite_color)).to be true
          end
        end

        context 'With the rook on the same horizontal line and no obstruction in between' do
          it 'returns true' do
            # data setup
            create(:rook, player: game.player_1, game: game, x_coordinate: 5, y_coordinate: 3, color: 'white')
            player2_king

            expect(game.check?(opposite_color)).to be true
          end
        end
      end

      context "When the oppnent player's bishop can capture the current player's king" do
        # _______________
        # |L1|__|__|__|L2|
        # |__|__|__|__|__|
        # |__|__|k |__|__|
        # |__|__|__|__|__|
        # |L3|__|__|__|L4|

        context 'With the bishop on the bottom left diagonal and no obstruction in between' do
          it 'returns true' do
            # data setup
            create(:bishop, player: game.player_1, game: game, x_coordinate: 1, y_coordinate: 1)
            player2_king

            expect(game.check?(opposite_color)).to be true
          end
        end

        context 'With the bishop on the bottom right diagonal and no obstruction in between' do
          it 'returns true' do
            # data setup
            create(:bishop, player: game.player_1, game: game, x_coordinate: 5, y_coordinate: 1)
            player2_king

            expect(game.check?(opposite_color)).to be true
          end
        end

        context 'With the bishop on the top left diagonal and no obstruction in between' do
          it 'returns true' do
            # data setup
            create(:bishop, player: game.player_1, game: game, x_coordinate: 1, y_coordinate: 5)
            player2_king

            expect(game.check?(opposite_color)).to be true
          end
        end

        context 'With the bishop on the top right diagonal and no obstruction in between' do
          it 'returns true' do
            # data setup
            create(:bishop, player: game.player_1, game: game, x_coordinate: 5, y_coordinate: 5)
            player2_king

            expect(game.check?(opposite_color)).to be true
          end
        end
      end

      context "When the oppnent player's queen can capture the current player's king" do
        # _______________
        # |L1|__|L2|__|L3|
        # |__|__|__|__|__|
        # |L4|__|k |__|__|
        # |__|__|__|__|__|
        # |L5|__|__|__|L6|
        context 'With the queen on the same vertical line and no obstruction in between' do
          it 'returns true' do
            # data setup
            create(:queen, player: game.player_1, game: game, x_coordinate: 3, y_coordinate: 1)
            player2_king

            expect(game.check?(opposite_color)).to be true
          end
        end

        context 'With the queen on the same horizontal line and no obstruction in between' do
          it 'returns true' do
            # data setup
            create(:queen, player: game.player_1, game: game, x_coordinate: 1, y_coordinate: 3)
            player2_king

            expect(game.check?(opposite_color)).to be true
          end
        end

        context 'With the queen on the bottom left diagonal and no obstruction in between' do
          it 'returns true' do
            # data setup
            create(:queen, player: game.player_1, game: game, x_coordinate: 1, y_coordinate: 1)
            player2_king

            expect(game.check?(opposite_color)).to be true
          end
        end

        context 'With the queen on the bottom right diagonal and no obstruction in between' do
          it 'returns true' do
            # data setup
            create(:queen, player: game.player_1, game: game, x_coordinate: 5, y_coordinate: 1)
            player2_king

            expect(game.check?(opposite_color)).to be true
          end
        end

        context 'With the queen on the top left diagonal and no obstruction in between' do
          it 'returns true' do
            # data setup
            create(:queen, player: game.player_1, game: game, x_coordinate: 1, y_coordinate: 5)
            player2_king

            expect(game.check?(opposite_color)).to be true
          end
        end

        context 'With the queen on the top right diagonal and no obstruction in between' do
          it 'returns true' do
            # data setup
            create(:queen, player: game.player_1, game: game, x_coordinate: 5, y_coordinate: 5)
            player2_king

            expect(game.check?(opposite_color)).to be true
          end
        end
      end

      context "When the oppnent player's pawn can capture the current player's king" do
        # _______________
        # |__|__|k |__|__|
        # |__|L1|__|L2|__|

        context 'With the pawn on the immediate diagonal square below the king on the left' do
          it 'returns true' do
            # data setup
            create(:pawn, player: game.player_1, game: game, x_coordinate: 2, y_coordinate: 2)
            player2_king

            expect(game.check?(opposite_color)).to be true
          end
        end

        context 'With the pawn on the immediate diagnal square below the king on the right' do
          it 'returns true' do
            # data setup
            create(:pawn, player: game.player_1, game: game, x_coordinate: 4, y_coordinate: 2)
            player2_king

            expect(game.check?(opposite_color)).to be true
          end
        end
      end

      context "When the oppnent player's knight can capture the current player's king" do
        #  _______________
        # 5|__|L1|__|L2|__|
        # 4|L3|__|__|__|L4|
        # 3|__|__|N |__|__|
        # 2|L5|__|__|__|L6|
        # 1|__|L7|__|L8|__|
        #   1   2  3  4  5

        # player1's knight
        let!(:player1_knight) { create(:knight, player: game.player_1, game: game, x_coordinate: 3, y_coordinate: 3) }

        context 'with the king on location 1 (L1)' do
          it 'returns true' do
            # data setup
            create(:king, player: game.player_2, game: game, x_coordinate: 2, y_coordinate: 5, color: 'black')

            expect(game.check?(opposite_color)).to be true
          end
        end

        context 'with the king on location 2 (L2)' do
          it 'returns true' do
            # data setup
            create(:king, player: game.player_2, game: game, x_coordinate: 4, y_coordinate: 5, color: 'black')

            expect(game.check?(opposite_color)).to be true
          end
        end

        context 'with the king on location 3 (L3)' do
          it 'returns true' do
            # data setup
            create(:king, player: game.player_2, game: game, x_coordinate: 1, y_coordinate: 4, color: 'black')

            expect(game.check?(opposite_color)).to be true
          end
        end

        context 'with the king on location 4 (L4)' do
          it 'returns true' do
            # data setup
            create(:king, player: game.player_2, game: game, x_coordinate: 5, y_coordinate: 4, color: 'black')

            expect(game.check?(opposite_color)).to be true
          end
        end

        context 'with the king on location 5 (L5)' do
          it 'returns true' do
            # data setup
            create(:king, player: game.player_2, game: game, x_coordinate: 1, y_coordinate: 2, color: 'black')

            expect(game.check?(opposite_color)).to be true
          end
        end

        context 'with the king on location 6 (L6)' do
          it 'returns true' do
            # data setup
            create(:king, player: game.player_2, game: game, x_coordinate: 5, y_coordinate: 2, color: 'black')

            expect(game.check?(opposite_color)).to be true
          end
        end

        context 'with the king on location 7 (L7)' do
          it 'returns true' do
            # data setup
            create(:king, player: game.player_2, game: game, x_coordinate: 2, y_coordinate: 1, color: 'black')

            expect(game.check?(opposite_color)).to be true
          end
        end

        context 'with the king on location 8 (L8)' do
          it 'returns true' do
            # data setup
            create(:king, player: game.player_2, game: game, x_coordinate: 4, y_coordinate: 1, color: 'black')

            expect(game.check?(opposite_color)).to be true
          end
        end
      end
    end
  end

  describe '#checkmate?' do
    let(:game) { create(:game) }
    let!(:player1_king) { create(:king, player: game.player_1, game: game, x_coordinate: 0, y_coordinate: 0, color: 'white', captured: false) }
    let!(:player2_king) { create(:king, player: game.player_2, game: game, x_coordinate: 4, y_coordinate: 4, color: 'black', captured: false) }

    let(:opposite_color) { 'black' }

    context 'the king can run away' do
      let!(:player2_bishop) { create(:bishop, player: game.player_2, game: game, x_coordinate: 2, y_coordinate: 2, color: 'black', captured: false) }
      # _______________
      # |__|__|__|__|BK| 4
      # |__|__|__|__|__| 3
      # |__|__|BB|__|__| 2
      # |__|__|__|__|__| 1
      # |wk|__|__|__|__| 0
      # | 0  1  2  3  4
      it 'should returns false' do
        expect(game.checkmate?(opposite_color)).to be false
        expect(player1_king.x_coordinate).to be 0
        expect(player1_king.y_coordinate).to be 0
      end
    end

    context 'the king cannot run away' do
      let!(:player2_rook) { create(:rook, player: game.player_2, game: game, x_coordinate: 4, y_coordinate: 0, color: 'black', captured: false) }
      let!(:player2_rook_2) { create(:rook, player: game.player_2, game: game, x_coordinate: 0, y_coordinate: 4, color: 'black', captured: false) }
      let!(:player2_bishop) { create(:bishop, player: game.player_2, game: game, x_coordinate: 2, y_coordinate: 2, color: 'black', captured: false) }
      # _______________
      # |BR|__|__|__|BK| 4
      # |__|__|__|__|__| 3
      # |__|__|BB|__|__| 2
      # |__|__|__|__|__| 1
      # |wk|__|__|__|BR| 0
      # | 0  1  2  3  4
      it 'returns true' do
        # used to be "black", I thought it might be a mistake
        # so I changed it to 'white'
        expect(game.checkmate?('white')).to be true
        #expect(player1_king.x_coordinate).to be 0
        #expect(player1_king.y_coordinate).to be 0
      end
    end
  end

  describe '#misstep?' do
    # White King at bottom (4,0), Black King at top (4,7)
    let(:game) { create(:game) }
    let!(:black_king) { create(:king, player: game.player_2, game: game, x_coordinate: 4, y_coordinate: 7, color: 'black', captured: false) }
    let!(:white_king) { create(:king, player: game.player_1, game: game, x_coordinate: 4, y_coordinate: 0, color: 'white', captured: false) }
    let(:opposite_color) { 'black' }

    context 'with the white king already in check' do
      # _______________
      # |__|__|__|__|BK| 7
      # |__|__|__|__|BQ| 6
      # |__|__|__|__|__| 5
      # |__|__|__|__|__| 4
      # |__|__|__|__|__| 3
      # |wb|__|wn|__|__| 2
      # |__|__|__|__|__| 1
      # |__|__|__|__|wk| 0
      # | 0  1  2  3  4
      # White king is in check by the Black Queen
      let!(:black_queen) { create(:queen, player: game.player_2, game: game, x_coordinate: 4, y_coordinate: 6, color: 'black', captured: false) }
      # White knight could block queen
      let!(:white_knight) { create(:knight, player: game.player_1, game: game, x_coordinate: 2, y_coordinate: 2, color: 'white', captured: false) }
      # White bishop could capture queen
      let!(:white_bishop) { create(:bishop, player: game.player_1, game: game, x_coordinate: 0, y_coordinate: 2, color: 'white', captured: false) }

      context 'if the move does not break the check' do
        it 'should return true (moving king is still in check)' do
          # _______________
          # |__|__|__|__|BK| 7
          # |__|__|__|__|BQ| 6
          # |__|__|__|__|__| 5
          # |__|__|__|__|__| 4
          # |__|__|__|__|__| 3
          # |wb|__|wn|__|__| 2
          # |__|__|__|__|wk| 1
          # |__|__|__|__|^_| 0
          # | 0  1  2  3  4
          expect(game.check?('white')).to be true
          expect(game.misstep?(white_king, 4, 1)).to be true
        end

        it 'should return true (moving unrelated piece not affecting check)' do
          # _______________
          # |__|__|__|__|BK| 7
          # |__|__|__|__|BQ| 6
          # |__|__|__|__|__| 5
          # |__|__|__|__|__| 4
          # |__|__|__|__|__| 3
          # |_\|__|wn|__|__| 2
          # |__|wb|__|__|__| 1
          # |__|__|__|__|wk| 0
          # | 0  1  2  3  4
          expect(game.check?('white')).to be true
          expect(game.misstep?(white_bishop, 1, 1)).to be true
        end
      end

      context 'if the moves breaks the check' do
        it 'should return false (moving king runs away)' do
          # _______________
          # |__|__|__|__|BK| 7
          # |__|__|__|__|BQ| 6
          # |__|__|__|__|__| 5
          # |__|__|__|__|__| 4
          # |__|__|__|__|__| 3
          # |wb|__|wn|__|__| 2
          # |__|__|__|__|__| 1
          # |__|__|__|wk<--| 0
          # | 0  1  2  3  4
          expect(game.check?('white')).to be true
          expect(game.misstep?(white_king, 3, 0)).to be false
        end

        it 'should return false (get in between the king and the threat)' do
          # _______________
          # |__|__|__|__|BK| 7
          # |__|__|__|__|BQ| 6
          # |__|__|__|__|__| 5
          # |__|__|__|__|__| 4
          # |__|__|__|__|wn| 3
          # |wb|__|---->/__| 2
          # |__|__|__|__|__| 1
          # |__|__|__|__|wk| 0
          # | 0  1  2  3  4
          expect(game.check?('white')).to be true
          expect(game.misstep?(white_knight, 4, 3)).to be false
        end

        it 'should return false (eat the threatening bad guy)' do
          # _______________
          # |__|__|__|__|BK| 7
          # |__|__|__|__|wb| 6
          # |__|__|__|_/|__| 5
          # |__|__| /|__|__| 4
          # |__| /|__|__|__| 3
          # | /|__|wn|__|__| 2
          # |__|__|__|__|__| 1
          # |__|__|__|__|wk| 0
          # | 0  1  2  3  4
          # binding.pry
          expect(game.check?('white')).to be true
          expect(game.misstep?(white_bishop, 4, 6)).to be false
        end
      end
    end

    context 'with the white king not in check' do
      # _______________
      # |__|__|__|__|BK| 7
      # |__|__|__|BR|BQ| 6
      # |__|__|__|__|__| ...
      # |__|__|__|__|wr| 1
      # |__|__|__|__|wk| 0
      # | 0  1  2  3  4

      let!(:black_queen) { create(:queen, player: game.player_2, game: game, x_coordinate: 4, y_coordinate: 6, color: 'black', captured: false) }
      let!(:black_rook) { create(:queen, player: game.player_2, game: game, x_coordinate: 3, y_coordinate: 6, color: 'black', captured: false) }
      let!(:white_rook) { create(:rook, player: game.player_1, game: game, x_coordinate: 4, y_coordinate: 1, color: 'white', captured: false) }

      context 'if the move exposes the king to check' do
        it 'should return true (moving king into danger)' do
          # _______________
          # |__|__|__|__|BK| 7
          # |__|__|__|BR|BQ| 6
          # |__|__|__|__|__| ...
          # |__|__|__|__|wr| 1
          # |__|__|__|wk<--| 0
          # | 0  1  2  3  4
          expect(game.check?('white')).to be false
          expect(game.misstep?(white_king, 3, 0)).to be true
        end

        it 'should return true (moving blocking piece out of the way)' do
          # _______________
          # |__|__|__|__|BK| 7
          # |__|__|__|BR|BQ| 6
          # |__|__|__|__|__| ...
          # |wr<-----------| 1
          # |__|__|__|__|wk| 0
          # | 0  1  2  3  4
          expect(game.check?('white')).to be false
          expect(game.misstep?(white_rook, 0, 1)).to be true
        end
      end
    end
  end
end
