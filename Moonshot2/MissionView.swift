//
//  MissionView.swift
//  Moonshot2
//
//  Created by Ryan Leach on 12/2/19.
//  Copyright © 2019 Ryan Leach. All rights reserved.
//

import SwiftUI

struct MissionView: View {
	struct CrewMember {
		let role: String
		let astronaut: Astronaut
	}

	let mission: Mission
	let missions: [Mission]
	let astronauts: [CrewMember]
	
	
    var body: some View {
		GeometryReader { geometry in
			ScrollView(.vertical) {
				VStack {
					Image(self.mission.image)
						.resizable()
						.scaledToFit()
						.frame(maxWidth: geometry.size.width * 0.7)
						.padding(.top)
					
					Text(self.mission.formattedLaunchDate)
						.font(.headline)
					
					Text(self.mission.description)
					.padding()
					
					ForEach(self.astronauts, id: \.role) { crewMember in
						NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut, missions: self.missions)) {
							HStack {
								Image(crewMember.astronaut.id)
									.resizable()
									.frame(width: 83, height: 60)
									.clipShape(Capsule())
									.overlay(Capsule().stroke(Color.primary, lineWidth: 1))
								
								VStack(alignment: .leading) {
									Text(crewMember.astronaut.name)
										.font(.headline)
									Text(crewMember.role)
										.foregroundColor(.secondary)
								}
								
								Spacer()
							}
							.padding(.horizontal)
						}
						.buttonStyle(PlainButtonStyle())
					}
					
					Spacer(minLength: 25)
				}
			}
		}
		.navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
	
	init(mission: Mission, astronauts: [Astronaut], missions: [Mission]) {
		self.mission = mission
		self.missions = missions
		
		var matches = [CrewMember]()
		
		for member in mission.crew {
			if let match = astronauts.first(where: { $0.id == member.name }) {
				matches.append(CrewMember(role: member.role, astronaut: match))
			} else {
				fatalError("Missing \(member)")
			}
		}
		
		self.astronauts = matches
	}
}

struct MissionView_Previews: PreviewProvider {
	static let missions: [Mission] = Bundle.main.decode("missions.json")
	static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
	
    static var previews: some View {
		MissionView(mission: missions[1], astronauts: astronauts, missions: missions)
    }
}
