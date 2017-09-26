//
//  MatchmakerViewController.swift
//  TutorialGameCenter
//
//  Created by Olivier Butler on 26/09/2017.
//  Copyright © 2017 Olivier Tests. All rights reserved.
//
import UIKit
import GameKit

class MatchMakerViewControllerDelegate: UIViewController, GKMatchmakerViewControllerDelegate {
    func matchmakerViewControllerWasCancelled(_ viewController: GKMatchmakerViewController) {
        print ("User gave up on greating a match")
    }
    
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFailWithError error: Error) {
        print ("Error \(error)")
    }
    
    var isAuthenticatedYet = false
    
    @IBAction func matchButtonPressed(_ sender: UIButton) {
        let matchRequest = GKMatchRequest()
        matchRequest.minPlayers = 2;
        matchRequest.maxPlayers = 10;
        let matchViewController = GKMatchmakerViewController(matchRequest: matchRequest)

        matchViewController?.matchmakerDelegate = self;
        
        self.present(matchViewController!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticateLocalPlayer()
        
    }
    
    // MARK: - AUTHENTICATE LOCAL PLAYER
    func authenticateLocalPlayer() {
        let localPlayer: GKLocalPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(ViewController, error) -> Void in
            if((ViewController) != nil) {
                // 1 Show login if player is not logged in
                self.present(ViewController!, animated: true, completion: nil)
            } else if (localPlayer.isAuthenticated) {
                self.isAuthenticatedYet = true
            } else {
                print("Local player could not be authenticated!")
                print(error!)
            }
        }
    }
}
