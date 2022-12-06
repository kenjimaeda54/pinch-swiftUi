//
//  InfoPanelView.swift
//  Pinch
//
//  Created by kenjimaeda on 03/12/22.
//

import SwiftUI

struct InfoPanelView: View {
	//MARK: - PROPERTY
	var scale: CGFloat
	var offsset: CGSize
	
	@State var isVisible: Bool = false
	
	var body: some View {
		HStack {
			
			Image(systemName: "circle.circle")
				.symbolRenderingMode(.hierarchical)
				.resizable()
				.frame(width: 30,height: 30)
				.onLongPressGesture(minimumDuration: 1) {
					withAnimation(.easeOut) {
						isVisible.toggle()
					}
				}
			
			Spacer()
			
			HStack(spacing: 2) {
				Image(systemName: "arrow.up.left.and.arrow.down.right")
				Text("\(scale)")
				Spacer()
				
				Image(systemName: "arrow.left.and.right")
				Text("\(offsset.width)")
				Spacer()
				
				Image(systemName: "arrow.up.and.down")
				Text("\(offsset.height)")
				Spacer()
				
			}//HTASCK
			.font(.footnote) //font e intesente par diminuir o tamanho dos icones
			.padding(10)
			.frame(maxWidth: 420)
			.background(.ultraThickMaterial)
			.opacity(isVisible ? 1 : 0 )
			.clipShape(
				RoundedRectangle(cornerRadius: 5, style: .continuous)
			)
	
			Spacer()
		}//HSTACK


	}
	
}

struct InfoPanelView_Previews: PreviewProvider {
	static var previews: some View {
		InfoPanelView(scale: 1, offsset: .zero)
			.previewLayout(.sizeThatFits)
			.preferredColorScheme(.dark)
	}
}
