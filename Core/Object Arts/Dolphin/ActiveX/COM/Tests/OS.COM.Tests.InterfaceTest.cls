﻿"Filed out from Dolphin Smalltalk"!

Core.Tests.DolphinTest subclass: #'OS.COM.Tests.InterfaceTest'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
OS.COM.Tests.InterfaceTest guid: (Core.GUID fromString: '{3cbd4156-925e-437d-b6b6-e862481e60c6}')!
OS.COM.Tests.InterfaceTest comment: ''!
!OS.COM.Tests.InterfaceTest categoriesForClass!Unclassified! !
!OS.COM.Tests.InterfaceTest methodsFor!

testAllRegistered
	| missing different iids registered |
	missing := OrderedCollection new.
	different := OrderedCollection new.
	iids := Set new.
	IUnknown withAllSubclasses do: 
			[:each |
			| iid |
			iid := each iid.
			(Interface classForIID: each iid ifNone: [])
				ifNil: [missing add: each]
				ifNotNil: 
					[:found |
					iids add: iid.
					found == each ifFalse: [different add: each]]].
	self assert: different asArray equals: #().
	self assert: (missing allSatisfy: [:each | each isNonInstantiable]).
	"Check that only IUnknown and subclasses are registered, and only registered undo one IID"
	registered := Interface.InterfaceClasses copy.
	registered removeAllKeys: iids.
	"The collection will not be empty if any interface class has duplicate registrations, although IDispatch can have multiple registrations for dispinterfaces"
	self assert: (registered associations reject: [:each | each value name == #IDispatch]) asArray equals: #()!

testGetObject
	| factory font |
	self should: [IUnknown getObject: 'bad'] raise: HRESULTError.
	"clsid monikers are quite interesting, as they allow one to bind to the class. Here for the OLE Font object"
	factory := IClassFactory getObject: 'clsid:' , '{0be35203-8f91-11ce-9de3-00aa004bb851}'.
	font := factory createInstance: nil iid: (IID fromString: '{bef6e002-a874-101a-8bba-00aa00300cab}').
	font name! !
!OS.COM.Tests.InterfaceTest categoriesForMethods!
testAllRegistered!public!unit tests! !
testGetObject!public!unit tests! !
!

