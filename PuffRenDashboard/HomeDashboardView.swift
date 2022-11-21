//
//  ContentView.swift
//  PuffRenDashboard
//
//  Created by Max Kai on 2022/11/16.
//

import SwiftUI

struct HomeDashboardView: View {
    @State private var showAnimation: Bool = true
    var body: some View {
        VStack {
            PieSliceView(slices: [
                (5, .red),
                (3, .orange),
                (4, .yellow)
            ])
            .scaleEffect()
            .animation(.spring(), value: showAnimation)
        }
        .padding()
    }
}

struct HomeDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        HomeDashboardView()
    }
}
