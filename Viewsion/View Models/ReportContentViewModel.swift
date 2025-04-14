//
//  ReportContentViewModel.swift
//  Viewsion
//
//  Created by Denzil Dsa on 11/30/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation

class ReportContentViewModel: ObservableObject {
    @Published var reportedContent: ReportedContent?
    @Published var contentReported: Bool = false
    private var service: ReportedContentService
    
    init() {
        service = ReportedContentService()
    }
    
    func Create(contentReport: ReportedContent) {
        service.Create(report: contentReport) { result in
            switch result {
            case .success(let bool):
                DispatchQueue.main.async {
                    self.contentReported = bool
                }
                print("Reported content successfully.")
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                }
            }
        }
    }
}
