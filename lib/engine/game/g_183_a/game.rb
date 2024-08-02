# frozen_string_literal: true

require_relative 'entities'
require_relative 'map'
require_relative 'meta'
require_relative '../base'

module Engine
  module Game
    module G183A
      class Game < Game::Base
        include_meta(G183A::Meta)
        include Entities
        include Map

        register_colors(green: '#237333',
                        gray: '#9a9a9d',
                        red: '#d81e3e',
                        blue: '#0189d1',
                        yellow: '#FFF500',
                        brown: '#7b352a')

        CURRENCY_FORMAT_STR = '$%s'

        BANK_CASH = 99_999

        CERT_LIMIT = {1=> 56, 2 => 28, 3 => 20, 4 => 16, 5 => 13, 6 => 11 }.freeze

        STARTING_CASH = { 1=> 2100 , 2 => 1050, 3 => 700, 4 => 525, 5 => 420, 6 => 350 }.freeze

        CAPITALIZATION = :full

        MUST_SELL_IN_BLOCKS = false

        MARKET = [
          %w[76
             82
             90
             100p
             112
             126
             142
             160
             180
             200
             225
             250
             275
             300
             325
             350e],
          %w[70
             76
             82
             90p
             100
             112
             126
             142
             160
             180
             200
             220
             240
             260
             280
             300],
          %w[65
             70
             76
             82p
             90
             100
             111
             125
             140
             155
             170
             185
             200],
          %w[60y 66 71 76p 82 90 100 110 120 130],
          %w[55y 62 67 71p 76 82 90 100],
          %w[50y 58y 65 67p 71 75 80],
          %w[45o 54y 63 67 69 70],
          %w[40o 50y 60y 67 68],
          %w[30b 40o 50y 60y],
          %w[20b 30b 40o 50y],
          %w[10b 20b 30b 40o],
        ].freeze

        PHASES = [
          {
            name: 'Yellow',
            train_limit: 4,
            tiles: [:yellow],
            operating_rounds: 2,
          },
          {
            name: 'Green',
            train_limit: 4,
            tiles: %i[yellow green],
            operating_rounds: 2,
            status: ['can_buy_companies'],
          },
          {
            name: 'Brown',
            train_limit: 3,
            tiles: %i[yellow green brown],
            operating_rounds: 3,
            status: ['can_buy_companies']
          },
          {
            name: 'Gray',
            train_limit: 2,
            tiles: %i[yellow green brown gray],
            operating_rounds: 3,
            status: ['can_buy_companies'],
          }
        ].freeze

        TRAINS = [{ name: '2', distance: 2, price: 80, rusts_on: '4', num: 8 },
                  { name: '3', distance: 3, price: 180, rusts_on: '6', num: 5 },
                  { name: '4', distance: 4, price: 300, rusts_on: 'D', num: 4 },
                  {
                    name: '5',
                    distance: 5,
                    price: 450,
                    num: 2
                  },
                  { name: '6', distance: 6, price: 630, num: 2 },
                  {
                    name: 'D',
                    distance: 999,
                    price: 1100,
                    num: 20,
                    available_on: 'Gray',
                    discount: { '4' => 300, '5' => 300, '6' => 300 },
                  },
                  {name: '2P', distance: 2, num: 1, price: 0,}].freeze

        MUST_BID_INCREMENT_MULTIPLE = true
        SELL_BUY_ORDER = :sell_buy_sell
        TRACK_RESTRICTION = :permissive
        DISCARDED_TRAINS = :remove

        #GAME_END_CHECK = { bankrupt: :current_round, stock_market: :current_round, bank: :full_or, final_phase: :one_more_full_or_set}.freeze
        GAME_END_CHECK = { bankrupt: :current_round, custom: :full_or }.freeze

        GAME_END_REASONS_TEXT = Base::GAME_END_REASONS_TEXT.merge(
          custom: 'Fixed number of Rounds'
        )

        # Two lays or one upgrade, second tile costs 20
        #TILE_LAYS = [{ lay: true, upgrade: true }, { lay: :not_if_upgraded, upgrade: false, cost: 20 }].freeze

        # Two lays with one being an upgrade, second tile costs 20
        TILE_LAYS = [
          { lay: true, upgrade: true },
          { lay: true, upgrade: :not_if_upgraded, cost: 20, cannot_reuse_same_hex: true },
        ].freeze

        PROGRESS_INFORMATION = [
          { type: :AUCTION, color:'red' },
          { type: :SR, name: '1', color:'blue'  },
          { type: :OR, name: '1.1', color:'yellow' },
          { type: :OR, name: '1.2', color:'yellow' },
          { type: :SR, name: '2', phasechange:true, color:'blue' },
          { type: :OR, name: '2.1',  color:'green' },
          { type: :OR, name: '2.2',  color:'green' },
          { type: :SR, name: '3',color:'blue'},
          { type: :OR, name: '3.1', color:'green' },
          { type: :OR, name: '3.1', color:'green' },
          { type: :SR, name: '4', phasechange:true, color:'blue'},
          { type: :OR, name: '4.1',  color:'brown' },
          { type: :OR, name: '4.2',  color:'brown' },
          { type: :OR, name: '4.3',  color:'brown' },
          { type: :SR, name: '5', lastorset:true, phasechange:true, color:'blue'},
          { type: :OR, name: '5.1', color:'gray' },
          { type: :OR, name: '5.2', color:'gray' },
          { type: :OR, name: '5.3', color:'gray' },
          { type: :End, color:'red'},
        ].freeze

        def timeline
          @timeline = [
            'Start of OR 2.1: Green Tiles are now available',
            'Start of OR 4.1: Brown Tiles are now available',
            'Start of OR 5.1: Gray Tiles are now available',
          ].freeze
        end

        def new_operating_round(round_num = 1)
          if progress_information[@round_counter][:phasechange]
            phase.next!
            @operating_rounds = @phase.operating_rounds
            # may be a bug, train depot only refreshes on train purchase or export, not on phase change
            @depot.depot_trains(clear: true)
          end

          super
        end

        # Game will end directly after the end of OR 10
        def custom_end_game_reached?
          @game_end_triggered = progress_information[@round_counter][:lastorset] unless @game_end_triggered
          @game_end_triggered
        end

        def stock_round
          Round::Stock.new(self, [
            Engine::Step::DiscardTrain,
            Engine::Step::HomeToken,
            Engine::Step::BuySellParShares,
          ])
        end

        def new_auction_round
          Round::Auction.new(self, [
            Engine::Step::CompanyPendingPar,
            Engine::Step::WaterfallAuction,
          ])
        end

        def operating_round(round_num)
          Round::Operating.new(self, [
            Engine::Step::Bankrupt,
            Engine::Step::SpecialTrack,
            Engine::Step::BuyCompany,
            Engine::Step::HomeToken,
            Engine::Step::Track,
            Engine::Step::Token,
            Engine::Step::Route,
            G183A::Step::Dividend,
            Engine::Step::DiscardTrain,
            Engine::Step::BuyTrain,
            [Engine::Step::BuyCompany, { blocks: true }],
          ], round_num: round_num)
        end

        def show_progress_bar?
          true
        end

        def progress_information
          self.class::PROGRESS_INFORMATION
        end

        def setup
          setup_companies
        end

        def setup_companies
          @company_trains = {}
          @company_trains['P6'] = find_and_remove_train_by_id('2P-0', buyable: true)
        end

        def company_bought(company, entity)
          on_acquired_train(company, entity) if company.sym =='P6'
        end

        def on_acquired_train(company, entity)
          train = @company_trains[company.id]
          buy_train(entity, train, :free)
          @log << "#{entity.name} gains a #{train.name} train"
          # Company closes after it is flipped into a train
          company.close!
          @log << "#{company.name} closes"
        end

        def find_and_remove_train_by_id(train_id, buyable: true)
          train = train_by_id(train_id)
          return unless train

          @depot.remove_train(train)
          train.buyable = buyable
          train.reserved = true
          train
        end

        def action_processed(action)
          if action.is_a?(Action::LayTile) && action.tile.name == '3A1'
            @log << '-- Woods Tile placed, CC can now be started! --'
          end

          super
        end

        # CC can not be pared until W tile is laid (if ever),
        def can_par?(corporation, _parrer)
          if corporation.name == 'CC'
            return @hexes.find { |hex| ['3A1', '3A2', '3A3', '3A4'].include?(hex.tile.name)} 
          end
          return !corporation.ipoed
        end

        # Travelling Troupe Private payout subsidy during dividends
        def token_subsidy(entity, phase)
          return 0 if !entity.companies.find {|company| company.sym=='P4'} 
          potential_subsidies = entity.tokens.map {
            |token| 
            if token.city 
              token.city.revenue[phase.tiles.last]
              #(phase.tiles.reverse_each { |color| token.city.revenue[color] })
            else 
              0 
            end
          }
          potential_subsidies.max
        end

      end
    end
  end
end
