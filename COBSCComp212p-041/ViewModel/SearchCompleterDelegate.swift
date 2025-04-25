//
//  SearchCompleterDelegate.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2025-04-25.
//

import MapKit
import SwiftUI

class SearchCompleterDelegate: NSObject, MKLocalSearchCompleterDelegate {
    @Binding var results: [MKLocalSearchCompletion]

    init(results: Binding<[MKLocalSearchCompletion]>) {
        _results = results
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        results = completer.results
    }
}
