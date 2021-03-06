﻿"Filed out from Dolphin Smalltalk"!

UI.Tests.PresenterTest subclass: #'UI.Tests.LinkButtonTest'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
UI.Tests.LinkButtonTest guid: (Core.GUID fromString: '{2af000e8-54bd-40b6-8dc6-d0014babc42c}')!
UI.Tests.LinkButtonTest comment: ''!
!UI.Tests.LinkButtonTest categoriesForClass!Unclassified! !
!UI.Tests.LinkButtonTest methodsFor!

classToTest
	^LinkButton!

testClickLinkFiresCommand
	| text |
	presenter text: 'Test'.
	self assert: presenter commandDescription description equals: 'Test'.
	"This command will cause the shell to be hidden when fired"
	presenter command: #hide.
	self assert: presenter isWindowVisible.
	self leftClickAt: 10 @ 10.
	self assert: presenter isWindowVisible not.
	presenter topView show.
	"Now try clicking over an area of the text that is not part of the link"
	text := 'Click <a>here</a> to hide me'.
	presenter text: text.
	self assert: presenter commandDescription description equals: 'Click here to hide me'.
	SessionManager inputState pumpMessages.
	self assert: presenter isWindowVisible.
	self leftClickAt: 10 @ 10.
	self assert: presenter isWindowVisible!

testGetSetText
	presenter text: 'Test'.
	"SysLink control seems to have a bug, and returns the length of the text plus the null
	terminator in response to WM_GETTEXTLENGTH (the null is supposed to be excluded)"
	self assert: presenter text equals: '<a>Test</a>'!

testQueryCommandEnablement
	presenter text: 'Test'.
	self assert: presenter commandDescription description equals: 'Test'.
	"This command will cause the shell to be hidden when fired"
	presenter command: #test.
	self assert: presenter isWindowVisible.
	presenter validateUserInterface.
	self assert: presenter isEnabled not.
	presenter command: #hide.
	presenter
		invalidateUserInterface;
		validateUserInterface.
	self assert: presenter isEnabled! !
!UI.Tests.LinkButtonTest categoriesForMethods!
classToTest!helpers!private! !
testClickLinkFiresCommand!public!unit tests! !
testGetSetText!public!unit tests! !
testQueryCommandEnablement!public!unit tests! !
!

