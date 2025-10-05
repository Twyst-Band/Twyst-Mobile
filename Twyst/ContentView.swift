import SwiftUI

enum AppRoute: Hashable {
    case hero
    case login
    case register
    case pairSetup
    case bodyProfileSetup
    case main
}

struct ContentView: View {
    @State private var path: [AppRoute] = []

    var body: some View {
        NavigationStack(path: $path) {
            HeroView(
                onLogin: { path.append(.login) },
                onRegister: { path.append(.register) }
            )
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .login:
                    LoginView(
                        onSuccess: { path.append(.main) },
                        onBack: { path.removeLast() }
                    )
                case .register:
                    RegisterView(
                        onSuccess: { path.append(.pairSetup) },
                        onBack: { path.removeLast() }
                    )
                case .pairSetup:
                    PairSetupView(
                        onComplete: { path.append(.bodyProfileSetup) }
                    )
                case .bodyProfileSetup:
                    BodyProfileSetupView(
                        onComplete: { path.append(.main) },
                        onBack: { path.removeLast() }
                    )
                case .main:
                    MainView()
                case .hero:
                    HeroView(
                        onLogin: { path.append(.login) },
                        onRegister: { path.append(.register) }
                    )
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
