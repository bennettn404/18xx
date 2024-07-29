# frozen_string_literal: true

require_relative '../meta'

module Engine
  module Game
    module G183A
      module Meta
        include Game::Meta

        DEV_STAGE = :production

        GAME_SUBTITLE = 'v0.2'
        GAME_DESIGNER = 'Nicholas Bennett'
        GAME_INFO_URL = 'https://github.com/tobymao/18xx/wiki/183A'
        GAME_LOCATION = 'Placeholder, Placeholder'
        GAME_PUBLISHER = nil
        GAME_RULES_URL = 'https://boardgamegeek.com/filepage/206629/1882-rules'

        PLAYER_RANGE = [1, 6].freeze
      end
    end
  end
end
