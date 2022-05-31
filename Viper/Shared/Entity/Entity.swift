//
//  Entity.swift
//  Viper
//
//  Created by Gilberto vieira on 26/05/22.
//

import Foundation

protocol MirrorableEnum {}

extension MirrorableEnum {
    var mirror: (label: String, params: [String: Any]) {
        get {
            let reflection = Mirror(reflecting: self)
            guard reflection.displayStyle == .enum,
                let associated = reflection.children.first else {
                    return ("\(self)", [:])
            }
            let values = Mirror(reflecting: associated.value).children
            var valuesArray = [String: Any]()
            for case let item in values where item.label != nil {
                valuesArray[item.label!] = item.value
            }
            return (associated.label!, valuesArray)
        }
    }
}


enum AppEvent: MirrorableEnum {
    case livestreamStarted
    case liveStreamEnded(duration: Float)
    case gameRoomCreated(gameName: String, invitedFriends: [String])
}


enum Field: MirrorableEnum {

    case fieldCreated(fieldId: Int, fields: String)

}

