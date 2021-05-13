"
The subscription is a single entry in a SubscriptionRegistry.
Several subscriptions by the same object is possible.

This subscription references the receiver weakly. If the receiver is garbage collected, the subscription is automatically removed from the SubscriptionRegistry. A MessageSend is dynamically generated to make ephemeron finalization easier.
"
Class {
	#name : 'WeakAnnouncementSubscription',
	#superclass : 'Object',
	#instVars : [
		'receiver',
		'selector',
		'announcer',
		'announcementClass',
		'subscriber'
	],
	#category : 'Announcements-Core-GemStone'
}

{ #category : 'instance creation' }
WeakAnnouncementSubscription class >> announcer: anAnnouncer
announcementClass: anAnnouncementClass
receiver: anObject
selector: aSelector [

	^self new
		receiver: anObject;
		selector: aSelector;
		announcer: anAnnouncer;
		announcementClass: anAnnouncementClass;
		beEphemeron: true;
		yourself
]

{ #category : 'accessing' }
WeakAnnouncementSubscription >> action [

	^MessageSend
		receiver: receiver
		selector: selector
]

{ #category : 'accessing' }
WeakAnnouncementSubscription >> announcementClass [

	^announcementClass
]

{ #category : 'accessing' }
WeakAnnouncementSubscription >> announcementClass: anAnnouncementClass [

	announcementClass := anAnnouncementClass
]

{ #category : 'accessing' }
WeakAnnouncementSubscription >> announcer [

	^announcer
]

{ #category : 'accessing' }
WeakAnnouncementSubscription >> announcer: anAnnouncer [

	announcer := anAnnouncer
]

{ #category : 'announcing' }
WeakAnnouncementSubscription >> deliver: anAnnouncement [

	^ (self handlesAnnouncement: anAnnouncement ) ifTrue: [
		[self action cull: anAnnouncement cull: announcer] 
"Pharo has:
			on: UnhandledError fork: [:ex | ex pass ]]
GemStone has:
"			on: Error
			do: announcer deliveryErrorHandler]
]

{ #category : 'testing' }
WeakAnnouncementSubscription >> handlesAnnouncement: anAnnouncement [

	^ announcementClass handlesAnnouncement: anAnnouncement
]

{ #category : 'converting' }
WeakAnnouncementSubscription >> makeStrong [

	| newSub |
	newSub := AnnouncementSubscription new
		announcer: announcer;
		announcementClass: announcementClass;
		valuable: self action;
		subscriber: receiver;
		yourself.
	self beEphemeron: false.
	^announcer
		replace: self
		with: newSub
]

{ #category : 'converting' }
WeakAnnouncementSubscription >> makeWeak [
	"This subscription is already weak."

	^self
]

{ #category : 'finalizing' }
WeakAnnouncementSubscription >> mourn [

	announcer removeSubscription: self
]

{ #category : 'accessing' }
WeakAnnouncementSubscription >> receiver: anObject [

	receiver := anObject
]

{ #category : 'accessing' }
WeakAnnouncementSubscription >> selector: aSelector [

	selector := aSelector
]

{ #category : 'accessing' }
WeakAnnouncementSubscription >> subscriber [

	^receiver
]

{ #category : 'accessing' }
WeakAnnouncementSubscription >> subscriber: anObject [

	receiver := anObject
]
