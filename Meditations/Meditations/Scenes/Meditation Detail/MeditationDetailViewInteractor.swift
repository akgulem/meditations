//
//  MeditationDetailViewInteractor.swift
//  Meditations
//
//  Created by Emrah Akgül on 14.03.2021.
//

import Foundation
import Meditations_Network

protocol MeditationDetailViewInteractorInterface {}

protocol MeditationDetailViewInteractorOutput: class {}

final class MeditationDetailViewInteractor {
    weak var output: MeditationDetailViewInteractorOutput?
    
    init() {}
}

extension MeditationDetailViewInteractor: MeditationDetailViewInteractorInterface {}
