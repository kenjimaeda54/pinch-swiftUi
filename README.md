# Pinch 
Aplicativo completo em relação a gestos em swift</br>
Pessoa pode fazer o famoso pinch, aumentar, diminuir a imagem, volar a qualquer momento ao tamanho original além de possuir botoes de controlers

## Feature
- Nos movimentos usando gesture é importante o uso de withAnimation, assim o movimento sera mais suave.
- Para possibilidade de aplicar movimento de pincel(aplica ou diminui com os dedos) usamos  o geture MagnificationGesture


```swift
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

```

##
- Cuidados importantes no momento de construí interfaces 
- Para aparecer o título do navigationTitle essencial colocar conteúdos dentro do navigation, vazio não ira aparecer o título
- Outro detalhe e overlay caso não fica na medida desejada precisa no Zstack aplicar Color.Clear
- Por fim cuidado com imagem a propriedade resizable esta acima de todas, pois inverso não conseguira usar

```swift
ZStack {
Color.clear

.navigationTitle("Pinch & Zoom") 
			.navigationBarTitleDisplayMode(.inline)
			.overlay(alignment: .top, content: {
				InfoPanelView(scale: imageScale, offsset: imageOffesset)
					.padding(.horizontal)
					.padding(.vertical,30)
				
				
			})

}


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

```
##
- Para gerar listas de forma dinâmica, aqui usamos a palavra ForEach


```swift
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




```



