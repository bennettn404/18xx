# frozen_string_literal: true

module Engine
  module Game
    module G183A
      module Entities
        COMPANIES = [
          {
            name: 'P1 - Legally required trigger pulling private',
            value: 20,
            revenue: 5,
            desc: 'This private does nothing, maybe it will block a tile, idk',
            sym: 'P1',
            abilities: [],
            color: nil,
          },
          {
            name: 'P2 - Unlicensed Gnome Bank',
            value: 20,
            revenue: -10,
            desc: 'Most likely should be removed. Possibly make this unsellable. Comes with $80 which is awarded to the owning player immediately. If the owning player or corp does not have enough money to fully pay the -10 revenue of this private, pay as much as possible then close this private without penalty.',
            sym: 'P2',
            abilities: [],
            color: nil,
          },
          {
            name: 'P3 - Dwarven Miners',
            value: 50,
            revenue: 10,
            desc: 'Owning corp may close this company during the tile-laying step to ignore one mountain terrain cost when laying a yellow tile.',
            sym: 'P3',
            abilities: [
              {
                type: 'tile_discount',
                discount: 120,
                terrain: 'mountain',
                owner_type: 'corporation',
                count: 1,
              },
            ],
            color: nil,
          },
          {
            name: 'P4 - Travelling Troupe',
            value: 70,
            revenue: 15,
            desc: 'When owned by a corp, the company gets money into its treasury equal to one of the city values it has a station token. This happens during the run train step, regardless of the number of trains or lack thereof the corp has. This does not count as paying revenue for the purposes of stock movements and this money can never be given out as dividends.',
            sym: 'P1',
            abilities: [],
            color: nil,
          },
          {
            name: 'P5 - ComesWithAShare',
            value: 100,
            revenue: 10,
            desc: 'Comes with a share of a random non-CC Corp',
            sym: 'P5',
            abilities: [
              {
                type: 'shares',
                shares: 'random_share',
                corporations: %w[SH NH ND WE SEH NG SD],
              }
            ],
            color: nil,
          },
          {
            name: 'P6 - Transport Tortoise',
            value: 130,
            revenue: 15,
            desc: 'CAN ONLY BE BOUGHT INTO A COMPANY STARTING PHASE 5. A permanent 2-Train. Functions identically as a normal train. Counts for train capacity and fufills the requirement to have a train. Can be bought between companies. This company never closes.',
            sym: 'P5',
            abilities: [
              { type: 'close', on_phase: 'never'}
            ],
            color: nil,
          },
        ].freeze

        CORPORATIONS = [
          {
            sym: 'CC',
            name: 'Cursed Creatures',
            tokens: [0, 40, 100],
            logo: '183_a/CC',
            simple_logo: '183_a/CC.alt',
            coordinates: 'H10',
            color: '#d4881c',
          },
          {
            sym: 'SH',
            name: 'Southern Humans',
            logo: '183_a/SH',
            simple_logo: '183_a/SH.alt',
            tokens: [0, 40, 100],
            coordinates: 'B12',
            color: '#51b4e0',
          },          
          {
            sym: 'NH',
            name: 'Northern Humans',
            logo: '183_a/NH',
            simple_logo: '183_a/NH.alt',
            tokens: [0, 40, 100],
            coordinates: 'E7',
            color: '#2c72b1',
          },          
          {
            sym: 'ND',
            name: 'North Dwarves',
            logo: '183_a/ND',
            simple_logo: '183_a/ND.alt',
            tokens: [0, 40, 100],
            coordinates: 'F2',
            color: '#d4002f',
          },          
          {
            sym: 'WE',
            name: 'Waning Elves',
            logo: '183_a/WE',
            simple_logo: '183_a/WE.alt',
            tokens: [0, 40, 100],
            coordinates: 'N12',
            color: '#4d2972',
          },          
          {
            sym: 'SEH',
            name: 'South Eastern Humans',
            logo: '183_a/SEH',
            simple_logo: '183_a/SEH.alt',
            tokens: [0, 40, 100],
            coordinates: 'D14',
            color: '#248e53',
          },          
          {
            sym: 'NG',
            name: 'North Gnomes',
            logo: '183_a/NG',
            simple_logo: '183_a/NG.alt',
            tokens: [0, 40, 100],
            coordinates: 'L6',
            color: '#7db042',
          },          
          {
            sym: 'SD',
            name: 'Southern Dwarves',
            logo: '183_a/SD',
            simple_logo: '183_a/SD.alt',
            tokens: [0, 40, 100],
            coordinates: 'L14',
            color: '#b18069',
          },
        ].freeze
      end
    end
  end
end
