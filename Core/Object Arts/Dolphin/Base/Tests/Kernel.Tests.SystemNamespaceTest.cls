﻿"Filed out from Dolphin Smalltalk"!

Kernel.Tests.AbstractNamespaceTest subclass: #'Kernel.Tests.SystemNamespaceTest'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
Kernel.Tests.SystemNamespaceTest guid: (Core.GUID fromString: '{5a72a2ef-84cc-4954-a159-3ae6bc041f25}')!
Kernel.Tests.SystemNamespaceTest isNonInstantiable: true!
Kernel.Tests.SystemNamespaceTest comment: ''!
!Kernel.Tests.SystemNamespaceTest categoriesForClass!Unclassified! !
!Kernel.Tests.SystemNamespaceTest methodsFor!

canonicalSubject
	^self subject!

subject
	^self subclassResponsibility!

testAbsoluteName
	self assert: self subject absoluteName equals: 'Root.' , self subject unqualifiedName!

testAbsoluteNameOfIdentifier
	self subclassResponsibility!

testAllEnvironments
	self subclassResponsibility!

testBinding
	self assert: self subject binding identicalTo: (Root localBindingFor: self subject name)!

testBindingOrNil
	self assert: self subject bindingOrNil identicalTo: (Root localBindingFor: self subject name)!

testEnvironment
	self subclassResponsibility!

testFullName
	self assert: self subject fullName equals: self subject name!

testFullyQualifiedReference
	self assert: self subject fullyQualifiedReference
		equals: self subject name asQualifiedReference!

testIncludesKey
	self subclassResponsibility!

testShortName
	self assert: self subject shortName equals: self subject name! !
!Kernel.Tests.SystemNamespaceTest categoriesForMethods!
canonicalSubject!private! !
subject!constants!private! !
testAbsoluteName!public!unit tests! !
testAbsoluteNameOfIdentifier!public!unit tests! !
testAllEnvironments!public!unit tests! !
testBinding!public!unit tests! !
testBindingOrNil!public!unit tests! !
testEnvironment!public!unit tests! !
testFullName!public!unit tests! !
testFullyQualifiedReference!public!unit tests! !
testIncludesKey!public! !
testShortName!public!unit tests! !
!

