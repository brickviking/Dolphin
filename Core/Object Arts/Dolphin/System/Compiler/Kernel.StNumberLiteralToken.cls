﻿"Filed out from Dolphin Smalltalk"!

Kernel.StLiteralToken subclass: #'Kernel.StNumberLiteralToken'
	instanceVariableNames: 'source'
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
Kernel.StNumberLiteralToken guid: (Core.GUID fromString: '{777f55ae-a939-4a73-9cc8-2cef3a91f41e}')!
Kernel.StNumberLiteralToken comment: ''!
!Kernel.StNumberLiteralToken categoriesForClass!Unclassified! !
!Kernel.StNumberLiteralToken methodsFor!

acceptVisitor: aTokenVisitor
	^aTokenVisitor visitNumberLiteralToken: self!

forgetNegative
	value := value negated.
	source := source copyFrom: 2.
	start := start + 1!

formatOn: aStream source: aString
	"For numbers, we attempt to retain the original source form as unless it is a plain integer
	it may have been deliberately expressed in a particular format by the user."

	source ifNil: [self value printOn: aStream] ifNotNil: [aStream nextPutAll: source]!

isNegative
	^self value negative!

isNumberLiteralToken
	^true!

printOn: aStream
	aStream
		space;
		nextPutAll: self class name;
		nextPut: $(.
	self formatOn: aStream source: nil.
	aStream nextPut: $)!

source
	"Answer the original source code for the number."

	^source!

source: aString 
	source := aString! !
!Kernel.StNumberLiteralToken categoriesForMethods!
acceptVisitor:!public!visitor! !
forgetNegative!helpers!private! !
formatOn:source:!printing!public! !
isNegative!public!testing! !
isNumberLiteralToken!public!testing! !
printOn:!public! !
source!accessing!public! !
source:!initializing!private! !
!

!Kernel.StNumberLiteralToken class methodsFor!

start: startInteger comments: aCollectionOrNil value: aString stop: stopInteger source: sourceString
	<primitive: 157>
	^self new
		start: startInteger;
		comments: aCollectionOrNil;
		value: aString;
		stop: stopInteger;
		source: sourceString;
		yourself! !
!Kernel.StNumberLiteralToken class categoriesForMethods!
start:comments:value:stop:source:!public! !
!

