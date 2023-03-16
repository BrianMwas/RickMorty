//
//  RMVCharacterController.swift
//  RickMorty
//
//  Created by Brian on 15/03/2023.
//

import UIKit

/// Controller to show and search for characters
final class RMCharacterController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
        
        let request = RMRequest(endpoint: .character)
    
        RMService.shared.execute(.listCharactersRequest, expecting: RMGetAllCharactersResponse.self) {result in
            switch result {
            case .success(let success):
                print(String(describing: success))
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
}
