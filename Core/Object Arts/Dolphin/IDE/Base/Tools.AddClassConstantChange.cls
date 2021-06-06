﻿"Filed out from Dolphin Smalltalk 7"!

Refactory.Browser.RefactoryVariableChange subclass: #'Tools.AddClassConstantChange'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
Tools.AddClassConstantChange guid: (Core.GUID fromString: '{1971f618-b2fa-4d5a-bf1d-36b364eb34cc}')!
Tools.AddClassConstantChange comment: ''!
!Tools.AddClassConstantChange categoriesForClass!Refactory-Change Objects! !
!Tools.AddClassConstantChange methodsFor!

asUndoOperation
	^Tools.RemoveClassConstantChange remove: variable from: self changeClass!

changeStringFormat
	^'Add class constant named, <1s>, to <2s>'!

changeSymbol
	^#addClassConstant:!

variableName
	^variable key! !
!Tools.AddClassConstantChange categoriesFor: #asUndoOperation!converting!public! !
!Tools.AddClassConstantChange categoriesFor: #changeStringFormat!constants!printing!private! !
!Tools.AddClassConstantChange categoriesFor: #changeSymbol!constants!private! !
!Tools.AddClassConstantChange categoriesFor: #variableName!accessing!private! !
