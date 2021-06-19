﻿"Filed out from Dolphin Smalltalk 7"!

OS.UserLibrary subclass: #'UI.Tests.FakeUserLibrary'
	instanceVariableNames: 'user32 getForegroundWindowBlock getActiveWindowBlock getCursorPosBlock'
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
UI.Tests.FakeUserLibrary guid: (GUID fromString: '{bbf4bdc3-fddb-4f49-8884-67abd17b5abf}')!
UI.Tests.FakeUserLibrary comment: ''!
!UI.Tests.FakeUserLibrary categoriesForClass!External-Libraries-Win32! !
!UI.Tests.FakeUserLibrary methodsFor!

close
	user32
		ifNotNil: 
			[:original |
			handle := user32 := nil.
			UserLibrary setDefault: original]!

free
	self close!

getActiveWindow
	^getActiveWindowBlock ifNotNil: [getActiveWindowBlock value] ifNil: [super getActiveWindow]!

getActiveWindowBlock: aNiladicValuable
	getActiveWindowBlock := aNiladicValuable!

getCursorPos: aPOINT
	^getCursorPosBlock ifNotNil: [getCursorPosBlock value: aPOINT] ifNil: [super getCursorPos: aPOINT]!

getCursorPosBlock: aMonadicValuable
	getCursorPosBlock := aMonadicValuable!

getForegroundWindow
	"Answer the handle of the window with which the user is currently working.
		HWND GetForegroundWindow(VOID)"

	^getForegroundWindowBlock
		ifNotNil: [getForegroundWindowBlock value]
		ifNil: [super getForegroundWindow]!

getForegroundWindowBlock: aNiladicValuable
	getForegroundWindowBlock := aNiladicValuable!

initializeForDesktopActive
	getForegroundWindowBlock := [self findWindow: 'Progman' lpWindowName: nil].
	getActiveWindowBlock := []!

open
	user32 := UserLibrary default.
	handle := user32 handle.
	self beFinalizable.
	UserLibrary setDefault: self! !
!UI.Tests.FakeUserLibrary categoriesFor: #close!public!realizing/unrealizing! !
!UI.Tests.FakeUserLibrary categoriesFor: #free!finalizing!public!realizing/unrealizing! !
!UI.Tests.FakeUserLibrary categoriesFor: #getActiveWindow!public!win32 functions-keyboard input! !
!UI.Tests.FakeUserLibrary categoriesFor: #getActiveWindowBlock:!initializing!private! !
!UI.Tests.FakeUserLibrary categoriesFor: #getCursorPos:!public!win32 functions-cursor! !
!UI.Tests.FakeUserLibrary categoriesFor: #getCursorPosBlock:!initializing!private! !
!UI.Tests.FakeUserLibrary categoriesFor: #getForegroundWindow!public!win32 functions-keyboard input! !
!UI.Tests.FakeUserLibrary categoriesFor: #getForegroundWindowBlock:!initializing!private! !
!UI.Tests.FakeUserLibrary categoriesFor: #initializeForDesktopActive!initializing!public! !
!UI.Tests.FakeUserLibrary categoriesFor: #open!private!realizing/unrealizing! !
