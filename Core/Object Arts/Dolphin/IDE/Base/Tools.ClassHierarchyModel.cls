﻿"Filed out from Dolphin Smalltalk"!

UI.VirtualTreeModel subclass: #'Tools.ClassHierarchyModel'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
Tools.ClassHierarchyModel guid: (Core.GUID fromString: '{87b4c673-026e-11d3-9fd7-00a0cc3e4a32}')!
Tools.ClassHierarchyModel comment: 'ClassHierarchyModel implements a <treeModel> representing the hierarchy (or a subset of it) of <Class>es in the system.'!
!Tools.ClassHierarchyModel categoriesForClass!MVP-Models! !
!Tools.ClassHierarchyModel methodsFor!

approxSize
	"Private - Answer the approximate size of the receiver.
	Implementation Note: This does not have to be accurate, but it should be fast
	(i.e. don't calculate it by counting the receiver's elements)."

	^500!

defaultGetChildrenBlock
	^[:aClass | aClass subclasses asSortedCollection]!

defaultGetParentBlock
	^[:aClass | aClass superclass]!

defaultHasChildrenBlock
	^[:aClass | aClass subclasses anySatisfy: filter]!

observeEnvironment
	Smalltalk
		when: #classAdded:
			send: #onClassAdded:
			to: self;
		when: #classUpdated:
			send: #onClassUpdated:
			to: self;
		when: #classRemoved:
			send: #onClassRemoved:
			to: self!

onClassAdded: aClass
	self add: aClass asChildOf: aClass superclass!

onClassRemoved: aClass
	self remove: aClass
!

onClassUpdated: aClass
	"Note that we only trigger #item:movedToParent: events if the updated class
	is a <Class>, not if it is a <Metaclass>."

	aClass isMeta ifFalse: [self move: aClass asChildOf: aClass superclass].
	self refresh: aClass ifAbsent: []!

setRoots: aCollection 
	"Private - Initialize the receiver with the roots in aCollection"

	super setRoots: aCollection.
	self observeEnvironment! !
!Tools.ClassHierarchyModel categoriesForMethods!
approxSize!accessing!private! !
defaultGetChildrenBlock!initializing!private! !
defaultGetParentBlock!initializing!private! !
defaultHasChildrenBlock!constants!private! !
observeEnvironment!initializing!private! !
onClassAdded:!event handling!public! !
onClassRemoved:!event handling!public! !
onClassUpdated:!event handling!public! !
setRoots:!initializing!private! !
!

!Tools.ClassHierarchyModel class methodsFor!

withAllClasses
	"Answer an instance of the receiver on the entire class hiearchy"

	^self withRoots: Smalltalk allRoots! !
!Tools.ClassHierarchyModel class categoriesForMethods!
withAllClasses!instance creation!public! !
!

