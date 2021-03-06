﻿"Filed out from Dolphin Smalltalk"!

Refactory.Browser.RefactoryClassChange subclass: #'Refactory.Browser.AddMethodChange'
	instanceVariableNames: 'source selector protocols'
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
Refactory.Browser.AddMethodChange guid: (Core.GUID fromString: '{67095785-de4e-4bb9-ae66-cb2d970c8a5f}')!
Refactory.Browser.AddMethodChange isNonInstantiable: true!
Refactory.Browser.AddMethodChange comment: ''!
!Refactory.Browser.AddMethodChange categoriesForClass!Refactory-Change Objects! !
!Refactory.Browser.AddMethodChange methodsFor!

= anAddMethodChange 
	super = anAddMethodChange ifFalse: [^false].
	^self parseTree = anAddMethodChange parseTree!

asUndoOperation
	^(self changeClass includesSelector: self selector)
		ifTrue: 
			[| oldProtocol |
			#rbFix.	"Extract protocol lookup to #currentProtocols"
			oldProtocol := self currentProtocols.
			oldProtocol isNil ifTrue: [oldProtocol := #accessing].
			#rbFix.	"Use 'self class' instead of hard ref to AddMethodChange"
			^self class
				compile: (self methodSourceFor: self selector)
				in: self changeClass
				classified: oldProtocol]
		ifFalse: [RemoveMethodChange remove: selector from: self changeClass]!

changeForClass: aSymbol selector: aSelector 
	^(self selector = aSelector and: [classReference asString = aSymbol])
		ifTrue: [self]
		ifFalse: [nil]!

changeForMetaclass: aSymbol selector: aSelector 
	^(self isMeta and: [self selector = aSelector and: [classReference instance asString = aSymbol]])
		ifTrue: [self]
		ifFalse: [nil]!

changeString
	^self displayClassName , '>>#' , self selector!

class: aClass protocol: aProtocol source: aString 
	self changeClass: aClass.
	self protocols: aProtocol.
	source := aString!

class: aClass source: aString 
	self changeClass: aClass.
	source := aString.
	#rbFix. "Extract lookup of current protocols to a method so can override"
	self protocols: self currentProtocols!

controller
	^nil!

currentProtocols
	#rbFix.	"Private - Extracted from #class:source:"
	^BrowserEnvironment new whichProtocolIncludes: self selector in: self changeClass!

hash
	^self parseTree hash!

parseTree
	^RBParser parseMethod: source onError: [:str :pos | ^nil]!

primitiveExecute
	^self subclassResponsibility!

printOn: aStream 
	aStream
		nextPut: $!!;
		nextPutAll: self displayClassName;
		nextPutAll: ' methodsFor: ';
		print: self protocol displayString;
		nextPut: $!!;
		cr;
		cr;
		nextPutAll: source;
		nextPutAll: '!! !!'!

protocol
	^self protocols notEmpty ifTrue: [self protocols first]!

protocols
	^protocols!

protocols: aCollection
	protocols := aCollection isString ifTrue: [{aCollection}] ifFalse: [aCollection asArray].
	protocols isNil ifTrue: [protocols := #(#accessing)]!

selector
	selector isNil 
		ifTrue: 
			[selector := RBParser parseMethodPattern: source.
			selector isNil ifTrue: [selector := #unknown]].
	^selector! !
!Refactory.Browser.AddMethodChange categoriesForMethods!
=!comparing!public! !
asUndoOperation!converting!public! !
changeForClass:selector:!accessing!public! !
changeForMetaclass:selector:!accessing!public! !
changeString!printing!public! !
class:protocol:source:!initialize/release!public! !
class:source:!initialize/release!public! !
controller!accessing!private! !
currentProtocols!helpers!private! !
hash!comparing!public! !
parseTree!helpers!private! !
primitiveExecute!operations!private! !
printOn:!printing!public! !
protocol!accessing!public! !
protocols!accessing!public! !
protocols:!initialize/release!public! !
selector!accessing!public! !
!

!Refactory.Browser.AddMethodChange class methodsFor!

compile: aString in: aClass 
	^self new class: aClass source: aString!

compile: aString in: aBehavior classified: aProtocol 
	^self new 
		class: aBehavior
		protocol: aProtocol
		source: aString! !
!Refactory.Browser.AddMethodChange class categoriesForMethods!
compile:in:!instance creation!public! !
compile:in:classified:!instance creation!public! !
!

