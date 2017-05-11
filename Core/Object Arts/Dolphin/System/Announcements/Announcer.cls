"Filed out from Dolphin Smalltalk 7"!

Object subclass: #Announcer
	instanceVariableNames: 'registry'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
Announcer guid: (GUID fromString: '{1c9ed26a-0ea9-497c-af74-175569414ae7}')!
Announcer comment: 'The code is based on the announcements as described by Vassili Bykov in <http://www.cincomsmalltalk.com/userblogs/vbykov/blogView?searchCategory=Announcements%20Framework>. The implementation uses a threadsafe subscription registry, in the sense that registering, unregistering, and announcing from an announcer at the same time in different threads should never cause failures.
!Announcer categoriesForClass!Announcements-Core! !
!Announcer methodsFor!

announce: anAnnouncement

basicSubscribe: subscription

hasSubscriber: anObject

initialize

numberOfSubscriptions

on: anAnnouncementClass do: aValuable

on: anAnnouncementClass send: aSelector to: anObject

removeSubscription: subscription

replace: subscription with: newOne

subscribe: anAnnouncementClass do: aValuable 

subscribe: anAnnouncementClass send: aSelector to: anObject

subscriptions

unsubscribe: anObject

weak

when: anAnnouncementClass do: aValuable

when: anAnnouncementClass do: aValuable for: aSubscriber

when: anAnnouncementClass send: aSelector to: anObject
!Announcer categoriesFor: #announce:!announce!public! !
!Announcer categoriesFor: #basicSubscribe:!private! !
!Announcer categoriesFor: #hasSubscriber:!*RPackage/core!public! !
!Announcer categoriesFor: #initialize!initialization!public! !
!Announcer categoriesFor: #numberOfSubscriptions!public!statistics! !
!Announcer categoriesFor: #on:do:!public! !
!Announcer categoriesFor: #on:send:to:!public! !
!Announcer categoriesFor: #removeSubscription:!public!subscription! !
!Announcer categoriesFor: #replace:with:!private! !
!Announcer categoriesFor: #subscribe:do:!public!subscription! !
!Announcer categoriesFor: #subscribe:send:to:!public!subscription! !
!Announcer categoriesFor: #subscriptions!*RPackage/core!public! !
!Announcer categoriesFor: #unsubscribe:!public!subscription! !
!Announcer categoriesFor: #weak!public!weak! !
!Announcer categoriesFor: #when:do:!convenience!public! !
!Announcer categoriesFor: #when:do:for:!convenience!public! !
!Announcer categoriesFor: #when:send:to:!convenience!public! !

!Announcer class methodsFor!

new	
	^super new initialize! !
!Announcer class categoriesFor: #new!public! !
