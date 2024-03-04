//
//  UIHostingController+SwiftUI.swift
//  RickAndMortyTests
//
//  Created by Victor Kreniski on 03/03/24.
//

import SwiftUI
import UIKit

extension View {
    var asViewController: UIViewController {
        UIHostingController(rootView: self)
    }
}
