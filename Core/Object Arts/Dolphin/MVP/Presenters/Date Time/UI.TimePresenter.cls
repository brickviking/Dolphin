﻿"Filed out from Dolphin Smalltalk"!

UI.ValuePresenter subclass: #'UI.TimePresenter'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
UI.TimePresenter guid: (Core.GUID fromString: '{87b4c6d3-026e-11d3-9fd7-00a0cc3e4a32}')!
UI.TimePresenter comment: 'TimePresenter is a <valuePresenter> that displays a <valueModel> onto <Time> value. A TimePresenter can be connected to any <valueView> capable of displaying <Time> values. When the ''Dolphin DateTimePicker Control'' package is installed this will be a <DateTimePicker>, but alternative views may be chosen with the installation of an appropriate <typeConverter>.'!
!UI.TimePresenter categoriesForClass!MVP-Presenters!MVP-Resources-Time fields! !
!UI.TimePresenter class methodsFor!

defaultView
	^'Picker view'!

icon
	"Answers an Icon that can be used to represent this class"

	^##(self) defaultIcon!

resource_Default_view
	"Answer the literal data from which the 'Default view' resource can be reconstituted.
	DO NOT EDIT OR RECATEGORIZE THIS METHOD.

	If you wish to modify this resource evaluate:
	Tools.ViewComposer openOn: (ResourceIdentifier class: self selector: #resource_Default_view)
	"

	^#(#'!!STL' 4 985166 10 ##(UI.STBViewProxy) ##(UI.TextEdit) 34 16 nil nil 34 2 8 1140916224 1025 416 nil 917510 ##(Graphics.Color) #default nil 7 nil nil nil 416 nil 8 1920675248 853062 1 ##(UI.TimeToText) nil nil 1049350 ##(OS.WindowsLocale) 852998 ##(OS.NUMBERFMTW) 8 #[2 0 0 0 1 0 0 0 3 0 0 0 232 149 214 5 200 149 214 5 1 0 0 0] 8 '.' nil 8 ',' 4115 170 192 34 26 8225 3 85 8 'Monday' 37 3 95 8 'Saturday' 31 8 ',' 89 8 'Wednesday' 35 5 93 8 'Friday' 29 8 '.' 87 8 'Tuesday' 97 8 'Sunday' 33 8 '3;0' 91 8 'Thursday' nil 1 1310982 ##(Core.MessageSequence) 138 144 34 1 1049350 ##(Core.MessageSend) #createAt:extent: 34 2 655878 ##(Graphics.Point) 6143 21 978 261 39 416 1179910 ##(OS.WINDOWPLACEMENT) 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 11 0 0 10 0 0 0 129 12 0 0 29 0 0 0] 8 #() 978 193 193 nil 27)! !
!UI.TimePresenter class categoriesForMethods!
defaultView!constants!public!views! !
icon!constants!public! !
resource_Default_view!public!resources-views! !
!

