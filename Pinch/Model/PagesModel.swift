//
//  PagesModel.swift
//  Pinch
//
//  Created by kenjimaeda on 05/12/22.
//

import Foundation

struct PagesModel: Identifiable {
	let id: Int
	let name: String
}

extension PagesModel {
	
	var thumbNail: String {
		return "thumb-\(name)"
	}
	
	
}
