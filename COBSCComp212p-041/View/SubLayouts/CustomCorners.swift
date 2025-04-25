//
//  CustomCorners.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2024-10-30.
//

import SwiftUI

struct CustomCorners: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius ))
        return Path(path.cgPath )
    }
}
