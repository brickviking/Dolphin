﻿"Filed out from Dolphin Smalltalk"!

Graphics.Gdiplus.Tests.InitializerTests subclass: #'Graphics.Gdiplus.Tests.BitmapFromIconInitializerTest'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
Graphics.Gdiplus.Tests.BitmapFromIconInitializerTest guid: (Core.GUID fromString: '{bf0526be-e212-4666-8678-2c66a571d808}')!
Graphics.Gdiplus.Tests.BitmapFromIconInitializerTest comment: ''!
!Graphics.Gdiplus.Tests.BitmapFromIconInitializerTest categoriesForClass!Unclassified! !
!Graphics.Gdiplus.Tests.BitmapFromIconInitializerTest methodsFor!

gdipCreateBitmapFromHICON: hicon bitmap: bitmap 
	constructorArgs := Processor activeProcess topFrame arguments.
	^Ok!

setUp
	super setUp.
	model := BitmapFromIconInitializer new library: self!

testCreateHandle
	| icon |
	icon := Bitmap icon.
	model icon: icon.
	model createHandle.
	self assert: constructorArgs size equals: 2.
	self assert: constructorArgs first identicalTo: icon basicHandle.
	self assertLastArgIsHandle!

testCreateHandleRealizesIcon
	| icon |
	icon := Icon fromId: 43 in: Shell32.
	model icon: icon.
	self assertIsNil: icon basicHandle.
	model createHandle.
	self denyIsNil: icon basicHandle! !
!Graphics.Gdiplus.Tests.BitmapFromIconInitializerTest categoriesForMethods!
gdipCreateBitmapFromHICON:bitmap:!accessing!public! !
setUp!public!setup! !
testCreateHandle!public!unit tests! !
testCreateHandleRealizesIcon!public!unit tests! !
!

