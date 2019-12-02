//
//  Mission.swift
//  Moonshot2
//
//  Created by Ryan Leach on 11/26/19.
//  Copyright © 2019 Ryan Leach. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable {
	struct CrewRole: Codable {
		let name: String
		let role: String
	}
	
	let id: Int
	let launchDate: Date?
	let crew: [CrewRole]
	let description: String
	
	var displayName: String {
		"Apollo \(id)"
	}
	
	var image: String {
		"apollo\(id)"
	}
	
	var formattedLaunchDate: String {
		if let launchDate = launchDate {
			let formatter = DateFormatter()
			formatter.dateStyle = .long
			return formatter.string(from: launchDate)
		} else {
			return "N/A"
		}
	}
}
