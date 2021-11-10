//
//  TheController.swift
//  DynamicUI
//
//  Created by Mahan Mirshafa on 11/9/21.
//

import Foundation
import SwiftUI

class TheController: MainController {
    
    override var dataset: MainModel {
//        DataProvider().localDS(.first)
//        DataProvider().localDS(.second)
        DataProvider().localDS(.third)
    }
}

struct MainController_Preview: PreviewProvider {
    static var previews: some View {
        TheController().showPreview()
    }
}
