import SwiftUI

struct ContentView: View {
    @State private var animationInProgress = false
    @State private var scale = 1.0
    @State private var color: Color = .clear

    struct AnimatedButtonStyle: ButtonStyle {
        @Binding var scale: Double
        @Binding var color: Color

        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .background( Circle()
                    .fill(color)
                    .scaleEffect(scale + 0.35)
                )
                .foregroundStyle(.cyan)
                .scaleEffect(scale)
                .animation(.interpolatingSpring(duration: 0.22), value: scale)
        }
    }

    var body: some View {
        Button {
            if !animationInProgress {
                withAnimation(.interpolatingSpring(stiffness: 170, damping: 15)) {
                    animationInProgress = true
                    scale = 0.86
                    color = .gray.opacity(0.3)
                } completion: {
                    animationInProgress = false
                    withAnimation(.bouncy) {
                        scale = 1
                        color = .clear
                    }
                }
            }
        } label: {
            GeometryReader { geometry in

                let width = geometry.size.width / 2
                let systemName = "play.fill"

                HStack(alignment: .center, spacing: 0) {
                    Image(systemName: systemName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: animationInProgress ? width : .zero)
                        .opacity(animationInProgress ? 1 : .zero)
                    Image(systemName: systemName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: width)
                    Image(systemName: systemName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: animationInProgress ? 0.5 : width)
                        .opacity(animationInProgress ? .zero : 1)
                }
                .frame(maxHeight: .infinity, alignment: .center)
            }
        }
        .frame(maxWidth: 62)
        .buttonStyle(AnimatedButtonStyle(scale: $scale, color: $color))
    }
}



