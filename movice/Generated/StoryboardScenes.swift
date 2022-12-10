// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

// swiftlint:disable sorted_imports
import Foundation
import UIKit

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length implicit_return

// MARK: - Storyboard Scenes

// swiftlint:disable explicit_type_interface identifier_name line_length type_body_length type_name
internal enum StoryboardScene {
  internal enum DetailView: StoryboardType {
    internal static let storyboardName = "DetailView"

    internal static let initialScene = InitialSceneType<DetailViewController>(storyboard: Self.self)

    internal static let detailView = SceneType<DetailViewController>(storyboard: Self.self, identifier: "DetailView")
  }
  internal enum HomeView: StoryboardType {
    internal static let storyboardName = "HomeView"

    internal static let initialScene = InitialSceneType<HomeViewController>(storyboard: Self.self)

    internal static let homeView = SceneType<HomeViewController>(storyboard: Self.self, identifier: "HomeView")
  }
  internal enum MainTabBarView: StoryboardType {
    internal static let storyboardName = "MainTabBarView"

    internal static let initialScene = InitialSceneType<MainTabBarViewController>(storyboard: Self.self)

    internal static let mainTabBarView = SceneType<MainTabBarViewController>(storyboard: Self.self, identifier: "MainTabBarView")
  }
  internal enum ReviewView: StoryboardType {
    internal static let storyboardName = "ReviewView"

    internal static let initialScene = InitialSceneType<ReviewViewController>(storyboard: Self.self)

    internal static let reviewView = SceneType<ReviewViewController>(storyboard: Self.self, identifier: "ReviewView")
  }
  internal enum ReviewedDetailView: StoryboardType {
    internal static let storyboardName = "ReviewedDetailView"

    internal static let initialScene = InitialSceneType<ReviewedDetailViewController>(storyboard: Self.self)

    internal static let reviewedDetailView = SceneType<ReviewedDetailViewController>(storyboard: Self.self, identifier: "ReviewedDetailView")
  }
  internal enum ReviewedView: StoryboardType {
    internal static let storyboardName = "ReviewedView"

    internal static let initialScene = InitialSceneType<ReviewedViewController>(storyboard: Self.self)

    internal static let reviewedView = SceneType<ReviewedViewController>(storyboard: Self.self, identifier: "ReviewedView")
  }
  internal enum SearchView: StoryboardType {
    internal static let storyboardName = "SearchView"

    internal static let searchView = SceneType<SearchViewController>(storyboard: Self.self, identifier: "SearchView")
  }
  internal enum WatchListView: StoryboardType {
    internal static let storyboardName = "WatchListView"

    internal static let initialScene = InitialSceneType<WatchListViewController>(storyboard: Self.self)

    internal static let watchListView = SceneType<WatchListViewController>(storyboard: Self.self, identifier: "WatchListView")
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length type_body_length type_name

// MARK: - Implementation Details

internal protocol StoryboardType {
  static var storyboardName: String { get }
}

internal extension StoryboardType {
  static var storyboard: UIStoryboard {
    let name = self.storyboardName
    return UIStoryboard(name: name, bundle: BundleToken.bundle)
  }
}

internal struct SceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type
  internal let identifier: String

  internal func instantiate() -> T {
    let identifier = self.identifier
    guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
      fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
    }
    return controller
  }

  @available(iOS 13.0, tvOS 13.0, *)
  internal func instantiate(creator block: @escaping (NSCoder) -> T?) -> T {
    return storyboard.storyboard.instantiateViewController(identifier: identifier, creator: block)
  }
}

internal struct InitialSceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type

  internal func instantiate() -> T {
    guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
      fatalError("ViewController is not of the expected class \(T.self).")
    }
    return controller
  }

  @available(iOS 13.0, tvOS 13.0, *)
  internal func instantiate(creator block: @escaping (NSCoder) -> T?) -> T {
    guard let controller = storyboard.storyboard.instantiateInitialViewController(creator: block) else {
      fatalError("Storyboard \(storyboard.storyboardName) does not have an initial scene.")
    }
    return controller
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
