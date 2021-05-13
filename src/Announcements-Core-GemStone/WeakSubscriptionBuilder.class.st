Class {
	#name : 'WeakSubscriptionBuilder',
	#superclass : 'Object',
	#instVars : [
		'announcer'
	],
	#category : 'Announcements-Core-GemStone'
}

{ #category : 'instance creation' }
WeakSubscriptionBuilder class >> on: anAnnouncer [

	^super new
		announcer: anAnnouncer;
		yourself
]

{ #category : 'accessing' }
WeakSubscriptionBuilder >> announcer: anAnnouncer [

	announcer := anAnnouncer
]

{ #category : 'accessing' }
WeakSubscriptionBuilder >> weak [
	"This already handles the creation of weak registrations."

	^self
]

{ #category : 'registration' }
WeakSubscriptionBuilder >> when: anAnnouncementClass
send: aSelector
to: anObject [

	| subscription |
	(anObject isKindOf: BlockClosure)
		ifTrue: [WeakBlockUnsupported signal].
	subscription := WeakAnnouncementSubscription
		announcer: announcer
		announcementClass: anAnnouncementClass
		receiver: anObject
		selector: aSelector.
	^announcer basicSubscribe: subscription
]
