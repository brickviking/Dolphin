﻿"Filed out from Dolphin Smalltalk"!

UI.Tests.AbstractShellViewTest subclass: #'UI.Tests.DialogViewTest'
	instanceVariableNames: 'owner shell2'
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
UI.Tests.DialogViewTest guid: (Core.GUID fromString: '{a8b91e26-354f-4420-9358-156da6d19c83}')!
UI.Tests.DialogViewTest comment: ''!
!UI.Tests.DialogViewTest categoriesForClass!Unclassified! !
!UI.Tests.DialogViewTest methodsFor!

createShell: aRectangle text: aString
	| shell |
	shell := ShellView new.
	shells addLast: shell.
	^shell
		create;
		rectangle: aRectangle;
		text: aString;
		show;
		yourself!

createSubjectDialog: aBoolean
	| dialog |
	dialog := DialogView new.
	dialog
		isInitiallyCentered: aBoolean;
		create;
		extent: self dialogExtent.
	^dialog!

createTestShells: aDisplayMonitor
	"If there is more than one monitor, put the dialog owner on a monitor other than the primary monitor (regression test for #1116)"

	owner := self
				createShell: ((100 @ 50 extent: 640 @ 480) translatedBy: aDisplayMonitor workArea origin)
				text: self printString , ' owner'.
	"Create a 2nd shell to take activation from the owner. We do this because normally dialogs are opened modal to the active window."
	shell2 := self
				createShell: ((50 @ 25 extent: 320 @ 240) translatedBy: DisplayMonitor primary workArea origin)
				text: self printString , ' shell2'!

dialogExtent
	^250 @ 350!

evaluateInModalDialog: aBlock owner: ownerView centered: aBoolean
	| dialog |
	dialog := self createSubjectDialog: aBoolean.
	
	[
	[[dialog isOpen not or: [dialog isModal]] whileFalse: [2 milliseconds wait].
	aBlock value: dialog]
			ensure: [dialog isModal: false]]
			fork.
	"Use an in-proc loop so the test doesn't cause a new main proc to be spawned. It also allows us to easily terminate the dialog just be setting the isModal flag"
	dialog isInProc: true.
	dialog showModalTo: ownerView.
	self deny: dialog isOpen!

testCenteringInOwner
	"Test that a modal dialog is centered in its owner."

	| actualCenter secondary dialogMonitor expectedCenter |
	"Create a 2nd shell to take activation from the owner. We do this because normally dialogs are opened modal to the active window."
	secondary := self getSecondaryMonitorIfAvailable.
	self createTestShells: secondary.
	expectedCenter := owner mapPointToScreen: owner clientRectangle center.
	self
		evaluateInModalDialog: 
			[:dialog |
			actualCenter := dialog mapPointToScreen: dialog clientRectangle center.
			dialogMonitor := dialog displayMonitor]
		owner: owner
		centered: true.
	self assert: dialogMonitor equals: secondary.
	"We expect the client area of the dialog to be centred over the client area of the owner. There might be some rounding error causing the centers to be offset by at most 1"
	self assert: (actualCenter - expectedCenter) abs <= 1.
	"Lose activation and reposition the cursor to the secondary monitor"
	cursorPos := secondary workArea center.
	self setUpFakeUserLibrary.
	self assertIsNil: View active.
	self
		evaluateInModalDialog: 
			[:dialog |
			actualCenter := dialog mapPointToScreen: dialog clientRectangle center.
			dialogMonitor := dialog displayMonitor]
		owner: nil
		centered: true.
	self assert: dialogMonitor equals: secondary!

testCenteringInOwnerModeless
	"Test that a modeless dialog which is initially centred is displayed centred on the client area of its owner."

	| secondary dialog |
	secondary := self getSecondaryMonitorIfAvailable.
	self createTestShells: secondary.
	dialog := self createSubjectDialog: true.
	dialog showModeless: owner.
	self assert: dialog displayMonitor equals: secondary.
	self
		assert: ((dialog mapPointToScreen: dialog clientRectangle center)
				- (owner mapPointToScreen: owner clientRectangle center)) abs
				<= 1.
	dialog destroy!

testInplaceNotRepositioned
	| desktopMonitors position dialog leftMonitor ownerRect |
	desktopMonitors := DisplayMonitor desktopMonitors.
	leftMonitor := desktopMonitors first.
	"This test requires multiple monitors arranged in a typical horizontal configuration. It could be made to work in a vertical configuration, but there much value."
	self skipUnless: 
			[desktopMonitors size > 1
				and: [(desktopMonitors at: 2) workArea origin >= leftMonitor workArea topRight]].
	"We need a view that is mainly on the left-most monitor, and partially on the next"
	ownerRect := (leftMonitor workArea corner x - 400) @ 100 extent: 640 @ 480.
	owner := self createShell: ownerRect text: self printString , ' owner'.
	self assert: owner displayMonitor equals: leftMonitor.
	dialog := DialogView new
				isInitiallyCentered: false;
				create;
				yourself.
	"Position the dialog on the 2nd monitor, but still over the owner view, before we show it"
	dialog rectangle: (ownerRect corner - self dialogExtent + 50 extent: self dialogExtent).
	self deny: dialog displayMonitor equals: leftMonitor.
	position := dialog position.
	"Show the dialog - it shouldn't get moved"
	dialog showModeless: owner.
	self deny: dialog displayMonitor equals: leftMonitor.
	self assert: dialog position equals: position.
	dialog destroy!

testNearOwnerModal
	"Test that a modal dialog that is not initially centred is at least shown on the same display as its owner."

	| secondary dialogMonitor |
	secondary := self getSecondaryMonitorIfAvailable.
	self createTestShells: secondary.
	self
		evaluateInModalDialog: [:dialog | dialogMonitor := dialog displayMonitor]
		owner: owner
		centered: false.
	self assert: dialogMonitor equals: secondary.
	"Lose activation and reposition the cursor to the secondary monitor"
	cursorPos := secondary workArea center.
	self setUpFakeUserLibrary.
	self assertIsNil: View active.
	self
		evaluateInModalDialog: [:dialog | dialogMonitor := dialog displayMonitor]
		owner: nil
		centered: false.
	self assert: dialogMonitor equals: secondary!

testNearOwnerModeless
	"Test that a modeless dialog which is not initially centred is at least displayed on the same monitor as its owner"

	| secondary position dialog |
	secondary := self getSecondaryMonitorIfAvailable.
	self createTestShells: secondary.
	dialog := self createSubjectDialog: false.
	self assert: dialog displayMonitor equals: DisplayMonitor primary.
	position := dialog position.
	dialog showModeless: owner.
	self assert: dialog displayMonitor equals: secondary.
	"We should maintain the same position relative to the display origin"
	self assert: dialog position - dialog displayMonitor origin equals: position.
	dialog destroy!

testRemainsOnScreen
	"Test that an initially centred dialog is positioned so that it is fully visible, even if this means not being completely centred in the owner."

	| rect workArea captureRect |
	owner := ShellView new.
	owner show.
	workArea := SystemMetrics current virtualScreenRectangle.
	"Position the (small) owner top-left so the dialog needs to be bumped back to the origin"
	owner rectangle: (Rectangle origin: workArea origin + (25 @ 25) extent: 75 @ 50).
	captureRect := [:dialog | rect := dialog rectangle].
	self
		evaluateInModalDialog: captureRect
		owner: owner
		centered: true.
	"Note that there may be areas of the virtual screen that are not visible on any monitor, either because the monitors are deliberately staggered, or are of different sizes"
	self assert: rect origin equals: (self workAreaNearest: workArea topLeft) topLeft.
	"Now bottom-left"
	owner rectangle: (Rectangle origin: workArea bottomLeft + (25 @ -100) extent: 75 @ 50).
	self
		evaluateInModalDialog: captureRect
		owner: owner
		centered: true.
	self assert: rect origin
		equals: (self workAreaNearest: workArea bottomLeft) bottomLeft - (0 @ self dialogExtent y).
	"Now bottom-right"
	owner rectangle: (Rectangle origin: workArea bottomRight + (-75 @ -100) extent: 75 @ 50).
	self
		evaluateInModalDialog: captureRect
		owner: owner
		centered: true.
	self assert: rect origin
		equals: (self workAreaNearest: workArea bottomRight) bottomRight - self dialogExtent.
	"Now top-right"
	owner rectangle: (Rectangle origin: workArea topRight + (-75 @ 25) extent: 75 @ 50).
	self
		evaluateInModalDialog: captureRect
		owner: owner
		centered: true.
	self assert: rect origin
		equals: (self workAreaNearest: workArea topRight) topRight - (self dialogExtent x @ 0)! !
!UI.Tests.DialogViewTest categoriesForMethods!
createShell:text:!private! !
createSubjectDialog:!helpers!private! !
createTestShells:!helpers!private! !
dialogExtent!constants!private! !
evaluateInModalDialog:owner:centered:!helpers!private! !
testCenteringInOwner!public!unit tests! !
testCenteringInOwnerModeless!public!unit tests! !
testInplaceNotRepositioned!public!unit tests! !
testNearOwnerModal!public!unit tests! !
testNearOwnerModeless!public!unit tests! !
testRemainsOnScreen!public!unit tests! !
!

