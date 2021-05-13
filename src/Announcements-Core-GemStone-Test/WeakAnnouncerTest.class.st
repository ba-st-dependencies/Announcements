"
SUnit tests for weak announcements
"
Class {
	#name : 'WeakAnnouncerTest',
	#superclass : 'AnnouncerTest',
	#category : 'Announcements-Core-GemStone-Test'
}

{ #category : 'asserting' }
WeakAnnouncerTest >> assert: anObject
identicalTo: bObject [

	^self assert: anObject == bObject
]

{ #category : 'utilities' }
WeakAnnouncerTest >> maximumReclamation [

	System _generationScavenge_vmMarkSweep.
	System _generationScavenge_vmMarkSweep.
	(Delay forMilliseconds: 10) wait.
]

{ #category : 'tests' }
WeakAnnouncerTest >> testMakeStrong [

	| counter collector forwarder subscription |
	counter := 0.
	collector := [ counter := counter + 1 ].
	forwarder := MessageSend receiver: collector selector: #value.
	subscription := announcer weak when: AnnouncementMockA send: #value to: forwarder.
	
	" shouldn't go away, we are still holding a reference to 'forwarder': "
	self maximumReclamation.
	announcer announce: AnnouncementMockA.
	self assert: counter equals: 1.
	
	"Shouldn't go away since we converted to a strong sub"
	subscription := subscription makeStrong.
	forwarder := nil.
	self maximumReclamation.
	announcer announce: AnnouncementMockA.
	self assert: counter equals: 2
]

{ #category : 'tests' }
WeakAnnouncerTest >> testNoDeadWeakSubscriptions [

	self maximumReclamation.
	self assert: (WeakAnnouncementSubscription allInstancesInMemory select: [ :sub | sub subscriber isNil ]) isEmpty.
	self assert: (WeakAnnouncementSubscription allInstancesInMemory select: [ :sub | sub subscriber isNil ]) isEmpty
]

{ #category : 'tests' }
WeakAnnouncerTest >> testWeakBlockUnsupported [
	"We support weak blocks though they aren't all that useful."

	| counter |
	counter := 0.
	self
		should: [announcer weak when: AnnouncementMockA send: #value to: []]
		raise: WeakBlockUnsupported.
	self
		should: [(announcer when: AnnouncementMockA do: [ :ann | counter := counter + 1 ] for: self) makeWeak]
		raise: WeakBlockUnsupported
]

{ #category : 'tests' }
WeakAnnouncerTest >> testWeakDoubleAnnouncer [

	| a1 a2 o |
	a1 := Announcer new.
	a2 := Announcer new.
	o := Object new.
	self 
		assert: a1 subscriptions numberOfSubscriptions
		equals: 0.
	self
		assert: a2 subscriptions numberOfSubscriptions
		equals: 0.
	
	a1 weak
		when: Announcement
		send: #abcdef
		to: o.
	a2 weak
		when: Announcement
		send: #abcdef
		to: o.	
	self 
		assert: a1 subscriptions numberOfSubscriptions
		equals: 1.
	self
		assert: a2 subscriptions numberOfSubscriptions
		equals: 1.
	
	self maximumReclamation.
	self 
		assert: a1 subscriptions numberOfSubscriptions
		equals: 1.
	self
		assert: a2 subscriptions numberOfSubscriptions
		equals: 1.	

	o := nil.
	self maximumReclamation.
	self 
		assert: a1 subscriptions numberOfSubscriptions
		equals: 0.
	self
		assert: a2 subscriptions numberOfSubscriptions
		equals: 0.
]

{ #category : 'tests' }
WeakAnnouncerTest >> testWeakObject [

	| counter collector forwarder |
	counter := 0.
	collector := [ counter := counter + 1 ].
	forwarder := MessageSend receiver: collector selector: #value.
	(announcer when: AnnouncementMockA send: #value to: forwarder) makeWeak.
	
	" shouldn't go away, we are still holding a reference to 'forwarder': "
	self maximumReclamation.
	announcer announce: AnnouncementMockA.
	self assert: counter equals: 1.
	
	" should go away as we let the only reference to 'forwarder' go: "
	forwarder := nil.
	self maximumReclamation.
	announcer announce: AnnouncementMockA.
	self assert: counter equals: 1
]

{ #category : 'tests' }
WeakAnnouncerTest >> testWeakSubscription [

	| obj subscription |
	obj := Object new.
	subscription := (announcer when: AnnouncementMockA send: #value to: obj) makeWeak.
	self assert: obj identicalTo: subscription subscriber
]
