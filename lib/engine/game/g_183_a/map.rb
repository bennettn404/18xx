# frozen_string_literal: true

module Engine
  module Game
    module G183A
      module Map
        TILES = {
          '3' => 3,
          '4' => 3,
          '5' => 2,
          '6' => 2,
          '7' => 'unlimited',
          '8' => 'unlimited',
          '9' => 'unlimited',
          '14' => 3,
          '15' => 4,
          '16' => 1,
          '17' => 1,
          '18' => 1,
          '19' => 1,
          '20' => 1,
          '23' => 3,
          '24' => 3,
          '25' => 2,
          '26' => 2,
          '27' => 2,
          '40' => 1,
          '41' => 2,
          '42' => 2,
          '43' => 2,
          '44' => 2,
          '45' => 2,
          '46' => 2,
          '47' => 2,
          '57' => 4,
          '58' => 3,
          '611' => 5,
          '619' => 3,
          '3A1' =>
          {
            'count' => 1,
            'color' => 'yellow',
            'code' =>
            'city=revenue:40,slots:2;path=a:_0,b:0;path=a:_0,b:3;label=W',
          },
          '3A2' =>
          {
            'count' => 1,
            'color' => 'green',
            'code' =>
            'city=revenue:60,slots:2;path=a:_0,b:0;path=a:_0,b:3;label=W',
          },          
          '3A3' =>
          {
            'count' => 1,
            'color' => 'brown',
            'code' =>
            'city=revenue:80,slots:3;path=a:_0,b:0;path=a:_0,b:3;label=W',
          },
          '3A4' =>
          {
            'count' => 1,
            'color' => 'gray',
            'code' =>
            'city=revenue:100,slots:4;path=a:_0,b:0;path=a:_0,b:3;label=W',
          },
          '3A5' =>
          {
            'count' => 1,
            'color' => 'yellow',
            'code' =>
            'city=revenue:30;path=a:_0,b:0;path=a:_0,b:1;path=a:_0,b:5;label=H',
          },
          '3A6' =>
          {
            'count' => 1,
            'color' => 'green',
            'code' =>
            'city=revenue:40,slots:2;path=a:_0,b:0;path=a:_0,b:1;path=a:_0,b:3;path=a:_0,b:5;label=H',
          },
          '3A7' =>
          {
            'count' => 1,
            'color' => 'brown',
            'code' =>
            'city=revenue:60,slots:3;path=a:_0,b:0;path=a:_0,b:1;path=a:_0,b:2;path=a:_0,b:3;path=a:_0,b:4;path=a:_0,b:5;label=H',
          },
          '3A8' =>
          {
            'count' => 1,
            'color' => 'gray',
            'code' =>
            'city=revenue:80,slots:3;path=a:_0,b:0;path=a:_0,b:1;path=a:_0,b:2;path=a:_0,b:3;path=a:_0,b:4;path=a:_0,b:5;label=H',
          },
          '3A9' =>
          {
            'count' => 1,
            'color' => 'yellow',
            'code' =>
            'path=a:0,b:3;path=a:1,b:4;label=T',
          },
          '3A10' =>
          {
            'count' => 1,
            'color' => 'yellow',
            'code' =>
            'path=a:0,b:2;path=a:1,b:3;label=T',
          },
          '3A11' =>
          {
            'count' => 1,
            'color' => 'yellow',
            'code' =>
            'path=a:0,b:4;path=a:1,b:3;label=T',
          },
          '3A12' =>
          {
            'count' => 1,
            'color' => 'yellow',
            'code' =>
            'path=a:0,b:3;path=a:1,b:2;label=T',
          },
          '3A13' =>
          {
            'count' => 1,
            'color' => 'yellow',
            'code' =>
            'path=a:0,b:5;path=a:1,b:3;label=T',
          },
          '3A14' =>
          {
            'count' => 1,
            'color' => 'yellow',
            'code' =>
            'path=a:1,b:3;path=a:4,b:5;label=T',
          },
          '3A15' =>
          {
            'count' => 1,
            'color' => 'yellow',
            'code' =>
            'path=a:0,b:3;path=a:2,b:4;label=T',
          },
          '3A16' =>
          {
            'count' => 1,
            'color' => 'yellow',
            'code' =>
            'path=a:1,b:2;path=a:4,b:5;label=T',
          },
          '3A17' =>
          {
            'count' => 1,
            'color' => 'yellow',
            'code' =>
            'path=a:1,b:2;path=a:3,b:4;label=T',
          },
        }.freeze

        LOCATION_NAMES = {
          'A9' => 'Random City 2',
          'B2' => 'West Mines',
          'B12' => 'Human City 1',
          'C3' => 'Town 1',
          'C9' => 'Town 4',
          'C11' => 'Town 2',
          'D14' => 'Human City 3',
          'E7' => 'Human City 2',
          'F2' => 'Dwarf City 1',
          'F6' => 'Random City 9',
          'F12' => 'Random City 3',
          'G9' => 'London',
          'H2' => 'Random City 4',
          'H10' => 'Cursed Woods',
          'I1' => 'Random Town 6',
          'I3' => 'Random City 5',
          'I7' => 'Random City 6',
          'J8' => 'Town 5',
          'K11' => 'Random City 1',
          'K13' => 'Town 3',
          'L2' => 'East Mines',
          'L6' => 'Gnome City 1',
          'L8' => 'Random City 7',
          'L14' => 'Dwarf City 2',
          'M7' => 'Random City 8',
          'N12' => 'Elf City 1',
        }.freeze

        HEXES = {
          white: {
            %w[A7 A11 A13 B6 B10 B14 C7 D2 D6 D8 D10 D12 E1 E9 E11 E13 F6 F8 F10 F14 G1 G5 G7 G11 I5 I9 I15 J2 J6 J14 J16 K1 K5 K7 K9 K15 L10 L12 L16 M5 M9 M11 M13 M15 N8] => '',
            %w[A9 D14 E7 F6 F12 H2 I7 K11 L6 L8 M7] => 'city=revenue:0',
            %w[C3 G9 I1 J8 K13] => 'town=revenue:0',
            %w[C5 D4 E3 E5 F4 G3 J4 K3 L4] => 'upgrade=cost:120,terrain:mountain',
            %w[I11 I13 J10 J12] => 'upgrade=cost:80,terrain:mountain',
            %w[B8 C13 G13 G15] => 'upgrade=cost:40,terrain:water',
            %w[C9 C11] => 'town=revenue:0;upgrade=cost:40,terrain:water',
            %w[I3] => 'city=revenue:0;upgrade=cost:120,terrain:mountain',
            %w[H6 H14] => 'label=T',
            ['B12'] => 'city=revenue:0;label=H',
            ['H10'] =>
            'city=revenue:0,hide:1;label=W;'\
            'border=edge:1,type:impassable;border=edge:2,type:impassable;'\
            'border=edge:4,type:impassable;border=edge:5,type:impassable',
          },
          red: {
            ['B2'] => 'offboard=revenue:yellow_30|green_40|brown_60|gray_80;path=a:0,b:_0;path=a:5,b:_0',
            ['B4'] => 'path=a:4,b:3;path=a:5,b:3',
            ['L2'] => 'offboard=revenue:yellow_30|green_40|brown_50|gray_60;path=a:1,b:_0;path=a:2,b:_0',
            ['N10'] => 'path=a:1,b:0',
            ['N12'] =>'city=revenue:yellow_60|green_30|brown_20|gray_0,slots:1;path=a:3,b:_0,terminal:1',
          },
          blue: {
            ['A15'] =>'path=a:3,b:5;path=a:4,b:5',
            ['B16'] =>
            'offboard=revenue:yellow_10|green_10|brown_10|gray_10;path=a:2,b:_0;path=a:3,b:_0;path=a:4,b:_0',
            ['C15'] =>'path=a:2,b:1;path=a:3,b:1',
          },
          gray: {
            ['E15'] =>'junction;path=a:2,b:_0,terminal:1',
            ['H4'] =>'junction;path=a:0,b:_0,terminal:1;path=a:3,b:_0,terminal:1',
            ['H8'] =>'path=a:3,b:0;path=a:3,b:1;path=a:3,b:5',
            ['H12'] =>'path=a:0,b:2;path=a:0,b:3;path=a:0,b:4',
            ['H16'] =>'junction;path=a:3,b:_0,terminal:1',
            ['N6'] =>'path=a:2,b:0',
          },
          yellow: {
            ['F2'] => 'city=revenue:20;path=a:2,b:_0;path=a:_0,b:4;',
            ['L14'] => 'city=revenue:20;path=a:2,b:_0;path=a:_0,b:3;',
          },
        }.freeze

        LAYOUT = :flat

      end
    end
  end
end
