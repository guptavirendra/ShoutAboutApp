  //
//  ContactsViewModel.swift
//  smalltalk
//
//  Created by Mikko Hämäläinen on 24/09/15.
//  Copyright (c) 2015 Mikko Hämäläinen. All rights reserved.
//

import UIKit
import ReactiveCocoa
import Result
import XMPPFramework
import SwiftyJSON

class ContactsViewModel {
	let disposer = CompositeDisposable()
	let contacts = MutableProperty<[STContact]>([])
	private unowned var xmppClient: STXMPPClient
	
	init(xmpp: STXMPPClient) {
		self.xmppClient = xmpp
		self.setupBindings()
	}
	
	deinit {
		disposer.dispose()
	}
	
	private func setupBindings() {
		self.setupContactsFetchBindings()
	}
	
	private func setupContactsFetchBindings()
    {
		disposer.addDisposable(
			self.getContacts()
				.map {
					[unowned self] (result: Result<Any, NSError>) -> [String] in
					if (result.value != nil) {
						let json = result.value as! JSON
                        print("\(json)")
                        let array = json.arrayObject as? [[String:AnyObject]]
                        var arrayName = [String]()
                        for dict in array!
                        {
                            let string:NSNumber = (dict["id"] as? NSNumber)!
                           arrayName.append(string.stringValue)
                            
                        }
						return arrayName//(json.arrayObject as? [String])!
					}
					return []
				}
				.uncollect()
				.map {
					[unowned self] (username: String) -> (String, XMPPvCardTemp)? in
					//Get what we have in cache and do network call for the rest
					if let vcard = STXMPPClient.sharedInstance?.stream!.fetchVCard(username) {
						return (username, vcard)
					}
					
					return nil
				}
				.ignoreNil() //Do not add users without vcard to contacts yet, wait for the vcard to come first
				.observeOn(UIScheduler())
				.start {
					[unowned self] event in
					switch event {
					case let .Next(username, vcard):
						self.addContact(username, vcard:vcard)
					case let .Failed(error):
						NSLog("Error fetching contacts \(error)")
					default:
						break
					}
					
			}
		)
		//Monitor for incoming vCards
		disposer.addDisposable(
			self.xmppClient.stream.incomingVCards
				.toSignalProducer()
				.observeOn(UIScheduler())
				.start {
					[unowned self] event in
					switch event {
					case let .Next(username, vcard):
						self.addContact(username, vcard:vcard)
					default:
						break
					}
		})
	}
	
	private func addContact(username: String, vcard: XMPPvCardTemp) {
		//Don't add self to contacts list
		if (username == User.username || vcard.nickname == nil) {
			//return
		}
        if vcard.nickname == nil
        {
           vcard.nickname = username
        }
		
		var contacts = self.contacts.value
		let contact = STContact(username: username, displayName: vcard.nickname)
		contacts.append(contact)
		contacts.sortInPlace { (c1, c2) in
			return c1.displayName < c2.displayName
		}
		
		self.contacts.value  = contacts
	}
	
	private func getContacts() -> SignalProducer<Result<Any, NSError>, NSError> {
		return STHttp.get("\(Configuration.mainApi)/user_contact_list?app_user_id=31653&app_user_token=%242y%2410%246PRbH2TSZYMWqWuvQJcO%2FuW05ZnNXDYB4p7Bj8eogEJ9VVacfEJbK", auth:("31653"/*User.username*/,"%242y%2410%246PRbH2TSZYMWqWuvQJcO%2FuW05ZnNXDYB4p7Bj8eogEJ9VVacfEJbK" /*User.token*/))
	}
	
}
