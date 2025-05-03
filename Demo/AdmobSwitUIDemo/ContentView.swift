import SwiftUI
import AdmobSwiftUI

struct ContentView: View {
    @StateObject private var nativeViewModel = AdMobNativeViewModel(requestInterval: 1)
    private let adViewControllerRepresentable = AdViewControllerRepresentable()
    private let adCoordinator = InterstitialAdCoordinator()
    private let rewardCoordinator = RewardedAdCoordinator()
    
    @State private var hiddenNative = false
    
    var body: some View {
        ScrollView {
            VStack (spacing: 20) {
                Button("Show InterstitialAd") {
                    Task {
                        do {
                            let ad = try await adCoordinator.loadAppOpenAd()
                            ad.present(from: adViewControllerRepresentable.viewController)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
                
                Button("show reward") {
                    Task {
                        do {
                            let reward = try await rewardCoordinator.loadInterstitialAd()
                            reward.present(from: adViewControllerRepresentable.viewController) {
                                print("Reward amount: \(reward.adReward.amount)")
                            }
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
                
                Button("reload native") {
                    nativeViewModel.refreshAd()
                }
                
                Button("hidden native") {
                    hiddenNative.toggle()
                }
                
                AdBannerView()
                    .frame(height: 50)
                    .background(Color.red)
                
                if !hiddenNative {
                    AdMobNativeView(nativeViewModel: nativeViewModel, style: .largeBanner)
                        .frame(height: 200)
                        .background(Color(UIColor.secondarySystemBackground))
                    
//                    AdMobNativeView(nativeViewModel: nativeViewModel, style: .card)
//                        .frame(height: 380) // 250 ~ 300
//                        .background(Color(UIColor.secondarySystemBackground))
                }
                
                
                    
            }
            .padding()
        }
        .background {
            // Add the adViewControllerRepresentable to the background so it
            // doesn't influence the placement of other views in the view hierarchy.
            adViewControllerRepresentable
                .frame(width: .zero, height: .zero)
        }
        .onAppear {
            nativeViewModel.refreshAd()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
