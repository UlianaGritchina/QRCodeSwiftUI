
import SwiftUI

struct MyBirthdayView: View {
    private let height =  UIScreen.main.bounds.height
    private let width =  UIScreen.main.bounds.width
    @State private var startingOffsetY: CGFloat = 0
    @State private var currentDragOffsetY: CGFloat = 0
    @State private var endingOffsetY: CGFloat = 0
    @State private var isSmall = false
    @State private var isOn = false
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .frame(width:isSmall ? width - 40 : width - 80,
                   height: isSmall ? height / 7 : height / 2.3)
            .foregroundColor(Color("sheet"))
            .blur(radius: 1)
            .shadow(color: .purple.opacity(0.5), radius: isSmall ? 5 : 10, x: 3, y: 3)
        
            .overlay(
                VStack {
                    Text("Today is the birthday of the developer of this awesome app")
                        .multilineTextAlignment(.center)
                        .font(.headline)
                    Spacer()
                    if !isSmall {
                        Text("🥳").font(.system(size: height / 10))
                    }
                    
                    Spacer()
                    HStack() {
                        link
                        if isSmall  {
                            Spacer()
                            Toggle("Party", isOn: $isOn).tint(.purple)
                        }
                    }
                }
                    .padding()
            )
            .offset(y: currentDragOffsetY)
            .offset(y: endingOffsetY)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        withAnimation(.spring()) {
                            currentDragOffsetY = value.translation.height
                            if currentDragOffsetY > 10 {
                                endingOffsetY = 210
                                isSmall = true
                            }
                            if currentDragOffsetY < -10 {
                                endingOffsetY = 0
                                isSmall = false
                            }
                        }
                    }
                    .onEnded { value in
                        withAnimation(.spring()) {
                            if currentDragOffsetY > 10 {
                                
                            }
                            
                            
                            
                            currentDragOffsetY = 0
                        }
                    }
            )
    }
    
}


struct MyBirthdayView_Previews: PreviewProvider {
    static var previews: some View {
        MyBirthdayView()
    }
}

extension MyBirthdayView {
    
    private var link: some View {
        Link(destination: URL(string: "https://apps.apple.com/ru/app/qr-generate/id1644582305")!) {
            Text("Write a Review")
                .bold()
                .font(.system(size: isSmall ? height / 60 : height / 50))
                .foregroundColor(.white)
                .frame(width: isSmall ? width / 3 : width / 1.5, height: isSmall ? height / 25 : height / 20)
                .background(Color.purple)
                .cornerRadius(10)
        }
    }
    
}
