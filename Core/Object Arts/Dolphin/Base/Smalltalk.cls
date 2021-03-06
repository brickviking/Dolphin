﻿"Filed out from Dolphin Smalltalk"!

Kernel.Namespace subclass: #Smalltalk
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #(#{Core} #{Kernel} #{Graphics} #{UI} #{OS} #{External} #{Tools private})
	classInstanceVariableNames: 'events allRoots allClasses classesByGuid oldNames'
	classConstants: {}!
Smalltalk guid: (Core.GUID fromString: '{4c8d0eb7-6d0e-4467-aea6-e6f1107faf7d}')!
Smalltalk isNonInstantiable: true!
Smalltalk comment: '`Smalltalk` represents the distinguished namespace of the same name. Historically Smalltalk was a global variable holding an instance of the `SystemDictionary` class, although the `SystemDictionary` class no longer exists in Dolphin from 7.2 and Smalltalk is now a namespace class.

The primary purpose of the Smalltalk namespace is to support loading of old packages that pre-date namespace support. It can also be used to continue to work in a flat namespace if that is your preference. It imports all the namespaces that contain parts of the original Dolphin image, and aliases some specifc classes, so the effect is that almost all the classes are globally bindable.  This means that older packages can be loaded and should continue to function, however loose methods added to classes that have been moved to other namespaces may fail to compile due to former global names no longer being in scope. Such compilation failures can be easily corrected by qualifying global names as necessary in the loose methods.
'!
!Smalltalk categoriesForClass!Kernel-Objects! !
!Smalltalk class methodsFor!

allClasses
	"Answer a <sequencedReadableCollection> of all of the classes in the system, in breadth-first order.
	There is no particular ordering at a particular depth."

	allClasses isNil
		ifTrue: 
			[allClasses := Class allClasses
						isImmutable: true;
						yourself].
	^allClasses!

allClassesDo: aMonadicValuable
	"Evaluate the <monadicValuable> argument for each of the <Class>es that are values of bindings in the receiver, including aliases, and recursively in any of the nested namespaces."

	self allClasses do: aMonadicValuable!

allRoots
	"Answer a <sequencedReadableCollection> of all global root classes - ie. those that are subclasses of nil."

	allRoots isNil ifTrue: [allRoots := Class allRoots].
	^allRoots!

classAdded: class
	"Private - The new <Class>, class, has been added to the receiver.
	Clear down the all class cache and inform observers."

	self clearCachedClasses.
	^self trigger: #classAdded: with: class.
!

classesByGuid
	^classesByGuid ifNil: [
		classesByGuid := LookupTable new: self allClasses size.
		allClasses do: [:each | classesByGuid at: each guid put: each].
		classesByGuid]!

classRemoved: aClass
	"Private - The <Class> argument has been removed from the system.
	Clear down the class caches and inform observers."

	self clearCachedClasses.
	self trigger: #classRemoved: with: aClass!

classUpdated: aClass
	"Private - The <Class>, aClass, has been updated. 
	Clear down the class caches and inform observers."

	self clearCachedClasses.
	^self trigger: #classUpdated: with: aClass!

clearCachedClasses
	"Private - Clear down the class caches."

	oldNames := allRoots := allClasses := classesByGuid := nil!

declareVariable: aString
	"For historical reasons the names of variables in the system namespace are always Symbols. This isn't strictly necessary in most cases as in Dolphin Symbols and Strings for the same character sequence are equivalent, but they are not identical and so some code may be broken if we don't stick with Symbols."

	^super declareVariable: aString asSymbol!

developmentSystem
	"Answer the current instance of <SmalltalkSystem> if installed, otherwise a <DeafObject>."

	^#{Tools.SmalltalkSystem} valueOrNil
		ifNil: [DeafObject current]
		ifNotNil: [:devSys | devSys current]!

getEvents
	"Private - Answer the EventsCollection belonging to the receiver, or nil if the receiver
	has no events registered for it"

	^events!

oldNames
	"Answer an <abstractDictionary> mapping new namespaced classes to old pre-namespace Smalltalk class names."

	^oldNames
		ifNil: 
			[oldNames := IdentityDictionary new.
			self bindingsDo: 
					[:each |
					| value |
					value := each value.
					(value class isMeta and: [value environment ~~ self and: [each isDeprecated not]])
						ifTrue: [oldNames at: value put: each key]].
			oldNames]!

removeClass: aClass
	aClass environment removeLocalBindingFor: aClass unqualifiedName.
	aClass removeFromSuper.	"At this point it would be a good idea to make the class become: a special error reporting class"
	self classRemoved: aClass!

setEvents: anEventsCollectionOrNil
	"Private - Set the EventsCollection of the receiver to be anEventsCollectionOrNil.
	Answer the receiver."

	events := anEventsCollectionOrNil!

shortNameFor: aString in: aNamespace
	^(aNamespace isNil or: 
			[aNamespace == self or: 
					[(self fullBindingFor: aString)
						ifNil: [self imports anySatisfy: [:each | each value == aNamespace]]
						ifNotNil: [:binding | binding environment == aNamespace or: [binding environment == self]]]])
		ifTrue: [aString]
		ifFalse: [aNamespace fullNameFor: aString]!

staticVariableRemoved: aVariableBinding
	self
		clearCachedClasses;
		trigger: #variableRemoved: with: aVariableBinding! !
!Smalltalk class categoriesForMethods!
allClasses!accessing!public! !
allClassesDo:!binding!public! !
allRoots!accessing!public! !
classAdded:!event handling!private! !
classesByGuid!private! !
classRemoved:!private!removing! !
classUpdated:!event handling!private! !
clearCachedClasses!private! !
declareVariable:!public! !
developmentSystem!accessing!public! !
getEvents!events!private! !
oldNames!accessing!public! !
removeClass:!operations!public! !
setEvents:!events!private! !
shortNameFor:in:!helpers!private! !
staticVariableRemoved:!class hierarchy-mutating!class variables!private! !
!

