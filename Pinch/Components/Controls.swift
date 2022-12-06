//
//  Controls.swift
//  Pinch
//
//  Created by kenjimaeda on 05/12/22.
//

import SwiftUI

struct Controls: View {
	var icon: String
    var body: some View {
			Image(systemName: icon)
			.font(.system(size: 36))
    }
}

struct Controls_Previews: PreviewProvider {
    static var previews: some View {
			Controls(icon: "minus.magnifyingglass")
				.previewLayout(.sizeThatFits)
				.preferredColorScheme(.dark)
				.padding()
    }
}
