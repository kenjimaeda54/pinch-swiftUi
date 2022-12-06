//
//  ContentView.swift
//  Pinch
//
//  Created by kenjimaeda on 03/12/22.
//

import SwiftUI

struct ContentView: View {
	
	//MARK: - PROPERTY
	@State var isAnimation = false
	@State var imageScale: CGFloat = 1
	@State var imageOffesset: CGSize = .zero
	@State var drawerIsOpen = false
	
	var pages: [PagesModel] = pageDatas
	@State var currentIndex = 0
	
	//MARK: Function
	func resetOffest() {
		return withAnimation(.spring()) {
			imageScale = 1;
			imageOffesset = .zero
		}
		
	}
	
	
	func handleMinus() {
		if imageScale <= 1 {
			resetOffest()
			return
		}
		
		if imageScale > 1 {
			withAnimation(.spring()) {
				imageScale -= 1
			}
		}
		
	}

	
	func handlePlus() {
		if imageScale > 5 {
			withAnimation(.spring()) {
				imageScale = 5
			}
			return
		}
		
		if imageScale < 5 {
			withAnimation(.spring()) {
				imageScale += 1
			}
		}
		
	}
	
	//MARK: - CONTENT
	var body: some View {
		NavigationStack {
			ZStack {
				Color.clear
				
				Image(pages[currentIndex].name)
					.resizable()
					.aspectRatio(contentMode: .fit) //com aspect radio coner radius funciona
					.shadow(color: .black.opacity(0.2), radius:12,x: 2,y: 2)
					.opacity(isAnimation ? 1 : 0)
					.cornerRadius(10)
					.scaleEffect(imageScale)
					.offset(x: imageOffesset.width,y: imageOffesset.height)
					.padding()
				//quando der dois tap
					.onTapGesture(count: 2, perform: {
						if imageScale == 1 {
							
							withAnimation(.spring()) {
								imageScale = 5
							}
							
							
						}else {
							
							resetOffest()
						}
						
					})
					.gesture(
						DragGesture()
							.onChanged({ dragEvent in
							  //isso e importante para dar movimento mais suave
								withAnimation(.linear(duration: 1)) {
									imageOffesset = dragEvent.translation
									
								}
								
							})
							.onEnded({ _ in
								if imageScale <= 1 {
									resetOffest()
								}
							})
						
					)
					.gesture(
						 MagnificationGesture()
							.onChanged({ value in
								if value >= 1 && value <= 5 {
									withAnimation(.linear(duration: 1)) {
										imageScale = value
									}
									
								}else  if imageScale > 5 {
									withAnimation(.linear(duration: 1)) {
										imageScale = 1
									}
								}
							})
							.onEnded({ value in
								if value > 5 {
									imageScale = 5
								}else if value < 1 {
									 resetOffest()
								}
							})
						 
					)
			}// ZStack
			
			.onAppear(perform: {
				withAnimation(.linear(duration: 1)) {
					isAnimation = true
				}
			})
			.navigationTitle("Pinch & Zoom") //para apaercer precisa colocar um conteudo dentro do navaigtion,exemplo zstack
			.navigationBarTitleDisplayMode(.inline)
			//se overlay não ficar acima e precisno no zstakc usar Clear.color
			.overlay(alignment: .top, content: {
				InfoPanelView(scale: imageScale, offsset: imageOffesset)
					.padding(.horizontal)
					.padding(.vertical,30)
				
				
			})
			.overlay(alignment: .topTrailing,content: {
				HStack(spacing: 5){
					Image(systemName:  drawerIsOpen ? "chevron.compact.right" : "chevron.compact.left")
						.font(.system(size: 46))
						.foregroundColor(.secondary)
						.padding(8)
						
					
			
				 
					//render dinamico
					ForEach(pages) { page in
						Image(page.thumbNail)
							.resizable() //resizable tem que ser a primeira propriedade se não ira acusar erro
							.scaledToFit()
							.frame(width: 100,height: 120)
							.padding(.vertical,10)
							.cornerRadius(8)
							.shadow(radius: 4)
							.animation(.easeOut(duration: 0.5), value: drawerIsOpen)
							.onTapGesture {
								withAnimation(.spring()) {
									currentIndex = page.id
								}
							}
			
					}
		
				}
	
				.onTapGesture {
						drawerIsOpen.toggle()
				
				}
				.background(.ultraThinMaterial)
				.cornerRadius(5)
				.frame(width: 240)
				.padding(EdgeInsets(top: 16, leading: 8, bottom: 8, trailing: 20))
				.opacity(isAnimation ? 1 : 0)
				.offset(x: drawerIsOpen ? 20 : 220)
				.padding(.top, UIScreen.main.bounds.height / 15 )
				
				
			})
		
		 
			.overlay(alignment: .bottom,content:  {
					HStack {
						Button (action: handleMinus,
						label: {
							 Controls(icon: "minus.magnifyingglass")
						})
						Button (action: resetOffest,
						label: {
							 Controls(icon: "arrow.up.left.and.down.right.magnifyingglass")
						})

						Button (action: handlePlus,label: {
							 Controls(icon: "plus.magnifyingglass")
						})
				 }
					.padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
					.background(.ultraThinMaterial)
					.cornerRadius(10)
			})
			.padding(.vertical,10)
		}//: NavigationStack
		
		
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
