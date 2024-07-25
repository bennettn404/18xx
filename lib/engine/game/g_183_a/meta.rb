# frozen_string_literal: true

require_relative '../meta'

module Engine
  module Game
    module G183A
      module Meta
        include Game::Meta

        DEV_STAGE = :production

        GAME_SUBTITLE = 'Railroading'
        GAME_DESIGNER = 'Nicholas Bennett'
        GAME_INFO_URL = 'https://github.com/tobymao/18xx/wiki/183A'
        GAME_LOCATION = 'Placeholder, Placeholder'
        GAME_PUBLISHER = :all_aboard_games
        GAME_RULES_URL = 'https://boardgamegeek.com/filepage/206629/1882-rules'

        PLAYER_RANGE = [1, 6].freeze
      end
    end
  end
end
