//
//  BlurWindow.swift
//  Pinterest
//
//  Created by Harpreet Singh on 13/01/26.
//

import SwiftUI

struct BlurWindow: NSViewRepresentable {
    
    func makeNSView(context: Context) -> NSVisualEffectView {
        
        let view = NSVisualEffectView()
        view.blendingMode = .behindWindow
        return view
    }
    
    func updateNSView(_ nsView: NSViewType, context: Context) {
        
    }
    
    
}

#Preview {
    BlurWindow()
}
