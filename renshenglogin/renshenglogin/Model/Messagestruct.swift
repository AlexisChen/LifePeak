//
//  Messagestruct.swift
//  renshenglogin
//
//  Created by Owen Li on 5/14/18.
//  Copyright © 2018 Alexis Chen. All rights reserved.
//

import Foundation
import CoreLocation
import MessageKit


internal struct Messagestruct: MessageType{
    var sender: Sender
    var messageId: String
    var sentDate: Date
    var data: MessageData

    private init(kind: MessageData, sender: Sender, messageId: String, date: Date) {
        self.sender = sender
        self.messageId = messageId
        self.sentDate = date
        self.data = kind
        
    }
    init(text: String, sender: Sender, messageId: String, date: Date) {
        self.init(kind: .text(text), sender: sender, messageId: messageId,
            date: date)
    }
    init(attributedText: NSAttributedString, sender: Sender, messageId: String, date: Date) {
        self.init(kind: .attributedText(attributedText), sender: sender, messageId: messageId,
            date: date)
    }
    init(emoji: String, sender: Sender, messageId: String, date: Date) {
        self.init(kind: .emoji(emoji), sender: sender, messageId: messageId,
            date: date)
    }

}
