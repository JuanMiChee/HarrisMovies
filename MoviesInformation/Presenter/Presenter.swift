//
//  PresenterProtocol.swift
//  MoviesInformation
//
//  Created by Juan Harrington on 19/04/22.
//

import Foundation
protocol  Presenter {
    var view: View? { get set }
    
    func viewDidLoadPresenterFunction()
}
