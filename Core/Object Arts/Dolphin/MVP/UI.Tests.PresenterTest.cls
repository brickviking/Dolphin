﻿"Filed out from Dolphin Smalltalk"!

Core.Tests.DolphinTest subclass: #'UI.Tests.PresenterTest'
	instanceVariableNames: 'presenter'
	classVariableNames: ''
	imports: #(#{OS.Win32Constants})
	classInstanceVariableNames: ''
	classConstants: {}!
UI.Tests.PresenterTest guid: (Core.GUID fromString: '{80e6f4ef-64d4-40f6-857c-5b74578eb87b}')!
UI.Tests.PresenterTest isNonInstantiable: true!
UI.Tests.PresenterTest comment: ''!
!UI.Tests.PresenterTest categoriesForClass!Unclassified! !
!UI.Tests.PresenterTest methodsFor!

classToTest
	^self subclassResponsibility!

initializePresenter
	self classToTest ifNotNil: [:subjectClass | presenter := subjectClass show]!

leftClickAt: aPoint 
	"Fire a left-click at the specified client coordinate of the tested presenter."

	"Implementation Note: Use the correct method of sending input (i.e. the SendInput API). This
	actually moves the mouse as if the user were generating the input, but note that the
	coordinates have to be mapped into normalised screen coordinates in the range 0..65535.
	Frankly it is a lot easier just to send a couple of messages, but I wanted to try this out
	as an experiment for future reference. Unforunately I can't get it to work except when
	evaluating the expression from the debugger. This suggests there is some timing related
	issue."

	| lParam |
	self waitForInputIdle.
	lParam := aPoint x << 16 | aPoint y.
	presenter view 
		sendMessage: WM_LBUTTONDOWN
		wParam: MK_LBUTTON
		lParam: lParam.
	presenter view 
		sendMessage: WM_LBUTTONUP
		wParam: 0
		lParam: lParam.
	^self.
!

setUp
	self initializePresenter!

tearDown
	presenter isNil
		ifFalse: 
			[| shell |
			shell := presenter topShell.
			shell = View desktop ifTrue: [presenter destroy] ifFalse: [shell close].
			presenter := nil]!

waitForInputIdle
	SessionManager inputState pumpMessages! !
!UI.Tests.PresenterTest categoriesForMethods!
classToTest!helpers!private! !
initializePresenter!public!Running! !
leftClickAt:!private!unit tests! !
setUp!public!Running! !
tearDown!public!Running! !
waitForInputIdle!private!unit tests! !
!

