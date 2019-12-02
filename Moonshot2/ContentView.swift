//
//  ContentView.swift
//  Moonshot2
//
//  Created by Ryan Leach on 11/26/19.
//  Copyright © 2019 Ryan Leach. All rights reserved.
//

import SwiftUI

// MARK:- Content View
struct ContentView: View {
	let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
	let missions: [Mission] = Bundle.main.decode("missions.json")
	@State var showingDates = true
	
    var body: some View {
		NavigationView {
			List(missions) { mission in
				NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts, missions: self.missions)) {
					Image(mission.image)
					.resizable()
					.scaledToFit()
					.frame(width: 44, height: 44)				
				
					VStack(alignment: .leading) {
						Text(mission.displayName)
							.font(.headline)
						if self.showingDates {
							Text(mission.formattedLaunchDate)
						} else {
							VStack(alignment: .leading) {
								ForEach(mission.crew, id: \.name) { member in
									Text(self.matchCrew(member: member))
								}
							}
						}
					}
				}
			}.navigationBarTitle("Apollo Missions ")
				.navigationBarItems(trailing: Button(showingDates ? "Crew" : "Launch Date") {
					self.showingDates.toggle()
			})
		}
	}
	
	func matchCrew(member: Mission.CrewRole) -> String {
		for astronaut in self.astronauts {
			if astronaut.id == member.name {
				return astronaut.name
			}
		}
		return "Unknown"
	}
}

// MARK:- Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
