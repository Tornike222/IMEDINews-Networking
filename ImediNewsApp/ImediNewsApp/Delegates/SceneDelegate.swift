import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    //MARK: - Scene with Navigation Controller
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let navigationController = UINavigationController(rootViewController: NewsViewController())
        navigationController.navigationBar.topItem?.title = "Imedi News"
        navigationController.navigationBar.prefersLargeTitles = true
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
}
