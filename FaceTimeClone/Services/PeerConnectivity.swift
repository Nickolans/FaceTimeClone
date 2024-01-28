//
//  PeerConnectivity.swift
//  FaceTimeClone
//
//  Created by Nickolans Griffith on 1/27/24.
//

import Foundation
import MultipeerConnectivity
import Combine

final class PeerConnectivity: NSObject {
    
    private let peerId: MCPeerID
    private var session: MCSession?
    private var browser: MCNearbyServiceBrowser?
    private var advertiser: MCNearbyServiceAdvertiser?
    private var subject: CurrentValueSubject<String, Never>?
    
    init(displayName: String) {
        self.peerId = .init(displayName: displayName)
        super.init()
        createSession()
    }
    
    private func createSession() {
        self.session = MCSession(peer: self.peerId)
        session?.delegate = self
    }
    
    func beginDiscovery() {
        self.browser = .init(peer: self.peerId, serviceType: "ftclone-video")
        browser?.delegate = self
        browser?.startBrowsingForPeers()
    }
    
    func beginAdverting() {
        self.advertiser = .init(peer: self.peerId, discoveryInfo: nil, serviceType: "ftclone-video")
        advertiser?.delegate = self
        advertiser?.startAdvertisingPeer()
    }
    
    func beginSendData(_ message: String) {
        guard let session = session, let data = message.data(using: .utf8) else { return }
        
        do {
            try session.send(data, toPeers: session.connectedPeers, with: .reliable)
        } catch {
            print("ERROR SENDING MESSAGE: \(error.localizedDescription)")
        }
    }
    
    func listenForMessages() -> CurrentValueSubject<String, Never> {
        self.subject = CurrentValueSubject<String, Never>("Started...")
        return self.subject!
    }
}

extension PeerConnectivity: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        //
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        guard let subject = self.subject, let message = String(data: data, encoding: .utf8) else { return }
        subject.send(message)
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        //
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        //
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        //
    }
}

extension PeerConnectivity: MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        guard let session = self.session else { return }
        browser.invitePeer(peerID, to: session, withContext: nil, timeout: -1)
        browser.stopBrowsingForPeers()
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        print("PEER LOST: \(peerID.displayName)")
    }
}

extension PeerConnectivity: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        guard let session = self.session else { return }
        invitationHandler(true, session)
        advertiser.stopAdvertisingPeer()
    }
}
