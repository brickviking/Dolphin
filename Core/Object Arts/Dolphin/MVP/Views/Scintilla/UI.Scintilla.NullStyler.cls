﻿"Filed out from Dolphin Smalltalk"!

UI.Scintilla.Styler subclass: #'UI.Scintilla.NullStyler'
	instanceVariableNames: 'normalStyleName'
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
UI.Scintilla.NullStyler guid: (Core.GUID fromString: '{930680af-646b-4660-a349-1f5e5a8e0fec}')!
UI.Scintilla.NullStyler comment: '`NullStyler` is a Scintilla `Styler` that leaves text in plain unformatted form, i.e. all text assumes the configured ''normal'' style, which is usually the style named #normal.

This styler is useful either when one wants to use Scintilla with plain text, or to temporarily disable styling.

## Instance Variables:
  normalStyleName		`Symbol`'!
!UI.Scintilla.NullStyler categoriesForClass!Kernel-Objects! !
!UI.Scintilla.NullStyler methodsFor!

initialize
	normalStyleName := #normal!

normalStyleName
	^normalStyleName!

normalStyleName: anObject
	normalStyleName := anObject ifNotNil: [anObject asSymbol]!

onStyleNeeded: aScintillaView from: startInteger to: stopInteger 
	"Callback from Scintilla requesting that the specified range of text be coloured.
	In this case we just set to the default style, regardless."

	aScintillaView applyStyle: self normalStyleName toNext: stopInteger - startInteger + 1! !
!UI.Scintilla.NullStyler categoriesForMethods!
initialize!initializing!public! !
normalStyleName!accessing!public! !
normalStyleName:!accessing!public! !
onStyleNeeded:from:to:!event handling!public! !
!

!UI.Scintilla.NullStyler class methodsFor!

stbConvertFrom: anSTBVersion 
	^[:instVars | self new]!

stbVersion
	^1! !
!UI.Scintilla.NullStyler class categoriesForMethods!
stbConvertFrom:!binary filing!public! !
stbVersion!binary filing!public! !
!

