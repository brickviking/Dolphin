﻿"Filed out from Dolphin Smalltalk"!

Core.Tests.Utf8StringTest subclass: #'Core.Tests.SymbolTest'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
Core.Tests.SymbolTest guid: (Core.GUID fromString: '{da460501-580d-4216-8409-405ab77a12aa}')!
Core.Tests.SymbolTest comment: 'This is the unit test for the class Symbol. Unit tests are a good way to exercise the functionality of your system in a repeatable and automatic manner. They are therefore recommended if you plan to release anything. For more information, see: 
	- http://www.c2.com/cgi/wiki?UnitTest
	- http://minnow.cc.gatech.edu/squeak/1547
	- the sunit class category'!
!Core.Tests.SymbolTest categoriesForClass!Unclassified! !
!Core.Tests.SymbolTest methodsFor!

assimilateString: aString
	^aString asSymbol!

collectionClass
	^Symbol!

newCollection: aCollection
	^(self newCopy: aCollection) asSymbol!

newCopy: aCollection
	^String withAll: (self assimilateElements: aCollection)!

newEmptyCollection: anInteger
	^Symbol intern: (String new: anInteger)!

testArgumentCount
	self assert: #< argumentCount equals: 1.
	self assert: #<==> argumentCount equals: 1.
	self assert: #a: argumentCount equals: 1.
	self assert: #size argumentCount equals: 0.
	self assert: #_dup: argumentCount equals: 1.
	self assert: #a:b: argumentCount equals: 2.
	self assert: #a:r:g:b: argumentCount equals: 4.
	self assert: #ab:c:def: argumentCount equals: 3!

testAsString
	#('abc ' '£' '€' '🐬' '你好') do: 
			[:each |
			| symbol actual |
			symbol := each asSymbol.
			actual := symbol asString.
			self deny: actual identicalTo: symbol.
			self deny: actual isImmutable.
			self assert: actual equals: each]!

testAtPut
	| literal |
	literal := #abc.
	self should: [literal at: 0 put: $x] raise: BoundsError.
	1 to: literal size + 1
		do: [:each | self should: [literal at: each put: $x] raise: Processor constWriteSignal]!

testEncodeOnPut
	self should: [super testEncodeOnPut] raise: Error matching: [:ex | ex description = 'Symbol class should not implement #new:']!

testInstVarAtPut
	| literal |
	literal := #abc.
	self should: [literal instVarAt: 0 put: $x codePoint] raise: BoundsError.
	1 to: literal size + 1
		do: [:each | self should: [literal instVarAt: each put: $x codePoint] raise: Processor constWriteSignal]!

testKeywords
	self assert: #a keywords equals: #(#a).
	self assert: #a: keywords equals: #(#a:).
	self assert: #ab: keywords equals: #(#ab:).
	self assert: #a:b: keywords equals: #(#a: 'b:').
	self assert: #ab:c:def: keywords equals: #('ab:' 'c:' 'def:').
	self assert: #>= keywords equals: #(#>=).
	"These aren't strictly valid selectors so the tests are more to document the behaviour"
	self assert: #'a:b' keywords equals: #('a:b').	"Trailing : is expected"
	self assert: #':a::b:' keywords equals: #(':' #a: ':' 'b:').
	self assert: #':' keywords equals: #(':')!

testPrintLiteral
	self assert: #_ printString equals: '#_'.
	self assert: #'1' printString equals: '#''1'''.
	self assert: #'urn:foo' printString equals: '#''urn:foo'''.
	self assert: #urn:foo: printString equals: '#urn:foo:'.
	self assert: #':' printString equals: '#'':'''.
	self assert: #'::' printString equals: '#''::'''.
	self assert: #'u::' printString equals: '#''u::'''.
	self assert: #'u:u' printString equals: '#''u:u'''!

testPrintString
	"Test whether all non-literal symbols print correctly as quoted symbols"

	"Unquoted"

	(#('at:' 'a') union: VM specialSelectors) do: 
			[:each |
			| print sym |
			sym := each asSymbol.
			"Sanity check"
			self assert: (Scanner isSelector: sym).
			print := sym printString.
			self deny: (print includes: $')].
	"Quoted, e.g. integers, and symbols containing other syntactically relevant characters"
	#('' '1' 'A#' 'PL/M' '::' '!!STL' 'Object class' 'reply-to') do: 
			[:each |
			| print |
			"Sanity check"
			self deny: (Scanner isSelector: each).
			"Should print quoted"
			print := each asSymbol printString.
			self assert: (print second == $' and: [print last == $'])]!

testRefersToLiteral
	| method |
	method := self class >> testSelector.
	self assert: (#abc refersTo: #abc asLiteralOf: method).
	self deny: (#abc refersTo: 'abc' asLiteralOf: method).
	self deny: (#abc refersTo: #ab asLiteralOf: method)!

testReplaceFromToWithStartingAt
	self 
		should: [super testReplaceFromToWithStartingAt]
		raise: Error
		matching: [:ex | ex messageText = 'Symbol should not implement #replaceFrom:to:with:startingAt:']!

testReplaceIdentityWith
	self should: [super testReplaceIdentityWith] raise: Processor constWriteSignal!

testResize
	self should: [super testResize] raise: Processor constWriteSignal!

testSpecies
	self assert: self collectionClass empty species sameAs: Symbol!

testSymbolTable
	Symbol.Table do: [:each | self assert: (each isNil or: [each isWeak])]! !
!Core.Tests.SymbolTest categoriesForMethods!
assimilateString:!helpers!private! !
collectionClass!helpers!private! !
newCollection:!helpers!private! !
newCopy:!helpers!private! !
newEmptyCollection:!public! !
testArgumentCount!public!unit tests! !
testAsString!helpers!public! !
testAtPut!public!unit tests! !
testEncodeOnPut!public!unit tests! !
testInstVarAtPut!public!unit tests! !
testKeywords!public!unit tests! !
testPrintLiteral!public!unit tests! !
testPrintString!helpers!public! !
testRefersToLiteral!public!unit tests! !
testReplaceFromToWithStartingAt!public!unit tests! !
testReplaceIdentityWith!public!unit tests! !
testResize!public!unit tests! !
testSpecies!public!unit tests! !
testSymbolTable!public!unit tests! !
!

