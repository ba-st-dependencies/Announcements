"
I represent condition which should be satisfied on given announcement to be delivered to subscription.
I am used to implement instance specific subscription on announcements. 

To create me send message #where to announcement class with condition block:

	Announcement where: [ :ann | ann param = #expected ]
"
Class {
	#name : #AnnouncementDeliveryCondition,
	#superclass : #Object,
	#instVars : [
		'announcementClass',
		'conditionBlock'
	],
	#category : #'Announcements-Core-GemStone'
}

{ #category : #'instance creation' }
AnnouncementDeliveryCondition class >> for: anAnnouncementClass where: aBlock [

	^self new
		announcementClass: anAnnouncementClass;
		conditionBlock: aBlock
]

{ #category : #accessing }
AnnouncementDeliveryCondition >> announcementClass [

	^ announcementClass
]

{ #category : #accessing }
AnnouncementDeliveryCondition >> announcementClass: anObject [

	announcementClass := anObject
]

{ #category : #accessing }
AnnouncementDeliveryCondition >> conditionBlock [

	^ conditionBlock
]

{ #category : #accessing }
AnnouncementDeliveryCondition >> conditionBlock: anObject [

	conditionBlock := anObject
]

{ #category : #testing }
AnnouncementDeliveryCondition >> handlesAnnouncement: anAnnouncement [

	^ (announcementClass handlesAnnouncement: anAnnouncement)
		and: [conditionBlock value: anAnnouncement ]
]
