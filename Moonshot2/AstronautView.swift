//
//  AstronautView.swift
//  Moonshot2
//
//  Created by Ryan Leach on 12/2/19.
//  Copyright © 2019 Ryan Leach. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
	let astronaut: Astronaut
	let missions: [Mission]
	
    var body: some View {
		GeometryReader { geometry in
			ScrollView(.vertical) {
				VStack {
					Image(self.astronaut.id)
						.resizable()
						.scaledToFit()
						.frame(width: geometry.size.width)
					
					Text(self.astronaut.description)
						.padding()
					.layoutPriority(1)
					
					ForEach(self.missions, id: \.id) { mission in
						HStack {
							Image(mission.image)
								.resizable()
								.scaledToFit()
								.frame(width: 44, height: 44)
							
							
							VStack(alignment: .leading) {
								Text(mission.displayName)
									.font(.headline)
								Text(mission.formattedLaunchDate)
							}
							
							Spacer()
						}
						.padding(.horizontal)
					}
					
					Spacer(minLength: 25)
				}
			}
		}
		.navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
	
	init(astronaut: Astronaut, missions: [Mission]) {
		self.astronaut = astronaut
		
		var matches = [Mission]()
		
		for mission in missions {
			for crew in mission.crew {
				if crew.name == astronaut.id {
					matches.append(mission)
				}
			}
		}
		
		self.missions = matches
	}
}

struct AstronautView_Previews: PreviewProvider {
	static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
	static let missions: [Mission] = Bundle.main.decode("missions.json")
	
    static var previews: some View {
        AstronautView(astronaut: astronauts[0], missions: missions)
    }
}
