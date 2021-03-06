﻿"Filed out from Dolphin Smalltalk"!

UI.Dialog subclass: #'Tools.ConvertToSiblingDialog'
	instanceVariableNames: 'classNamePresenter namespacePresenter subclassesPresenter statusModel'
	classVariableNames: ''
	imports: #(#{Refactory.Browser private})
	classInstanceVariableNames: ''
	classConstants: {}!
Tools.ConvertToSiblingDialog guid: (Core.GUID fromString: '{2e1173da-ad55-42da-beb3-e8d674480103}')!
Tools.ConvertToSiblingDialog comment: ''!
!Tools.ConvertToSiblingDialog categoriesForClass!MVP-Presenters!MVP-Resources-Dialogs! !
!Tools.ConvertToSiblingDialog methodsFor!

chooseNamespace
	| choice namespaces |
	namespaces := ClassHierarchyModel withRoots: (Namespace subclasses copyWithout: SharedPool).
	choice := namespacePresenter model.
	(ChooseClassDialog
		on: choice
		choices: namespaces
		caption: 'Select Namespace…')
		showModal!

createComponents
	"Create the presenters contained by the receiver"

	super createComponents.
	classNamePresenter := self add: TextPresenter new name: 'newClassName'.
	namespacePresenter := self add: TextPresenter new name: 'namespace'.
	subclassesPresenter := self add: ListPresenter new name: 'subclasses'.
	statusModel := ValueHolder new!

createSchematicWiring
	super createSchematicWiring.
	subclassesPresenter 
		when: #selectionChanged
		send: #onSelectionChanged
		to: self!

isValid
	| error |
	[self model checkPreconditions] on: RefactoringError
		do: 
			[:ex | 
			error := ex.
			ex return: nil].
	statusModel value: error.
	^error isNil!

model: aChildrenToSiblingsRefactoring 
	"Set the model associated with the receiver."

	| aspectBuffer |
	super model: aChildrenToSiblingsRefactoring.
	aspectBuffer := self model.
	classNamePresenter model: (aspectBuffer aspectValue: #unqualifiedClassName).
	namespacePresenter model: (aspectBuffer aspectValue: #environment).
	subclassesPresenter model: (ListModel on: aspectBuffer subclasses)!

onSelectionChanged
	self model subclasses: subclassesPresenter selections.
	^self invalidateUserInterface!

onViewOpened
	super onViewOpened.
	(self view viewNamed: 'status' ifNone: []) ifNotNil: [:item | item model: statusModel].
	subclassesPresenter view selectAll!

queryCommand: aCommandQuery 
	"Private - Enters details about a potential command for the receiver into 
	the <CommandQuery>."

	aCommandQuery commandSymbol == #ok 
		ifTrue: 
			[classNamePresenter value.
			aCommandQuery isEnabled: self isValid.
			^true].
	^super queryCommand: aCommandQuery! !
!Tools.ConvertToSiblingDialog categoriesForMethods!
chooseNamespace!commands!private! !
createComponents!initializing!public! !
createSchematicWiring!initializing!public! !
isValid!private!testing! !
model:!accessing!public! !
onSelectionChanged!public! !
onViewOpened!event handling!public! !
queryCommand:!commands!private! !
!

!Tools.ConvertToSiblingDialog class methodsFor!

defaultModel
	^ChildrenToSiblingsRefactoring new!

resource_Default_view
	"Answer the literal data from which the 'Default view' resource can be reconstituted.
	DO NOT EDIT OR RECATEGORIZE THIS METHOD.

	If you wish to modify this resource evaluate:
	Tools.ViewComposer openOn: (UI.ResourceIdentifier class: self selector: #resource_Default_view)
	"

	^#(#'!!STL' 4 985166 10 ##(UI.STBViewProxy) ##(UI.DialogView) 34 30 nil nil 8 #(12845056 65536) 416 nil 1245702 ##(Graphics.ThemeColor) #dialog nil 167 nil 852998 ##(Graphics.Font) nil true 721158 ##(OS.LOGFONTW) 8 #[244 255 255 255 0 0 0 0 0 0 0 0 0 0 0 0 144 1 0 0 0 0 0 0 3 2 1 34 83 0 101 0 103 0 111 0 101 0 32 0 85 0 73 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0] 918022 ##(Graphics.Point) 193 193 nil 416 984838 ##(UI.BorderLayout) 1 1 410 ##(UI.ContainerView) 34 15 nil 416 34 2 8 1140850688 131073 640 nil nil nil 7 nil nil nil 640 1048838 ##(UI.FramingLayout) 170 176 34 12 410 ##(UI.PushButton) 34 20 nil 640 34 2 8 1140924416 1 768 nil 917510 ##(Graphics.Color) #default nil 7 nil nil nil 768 nil 8 1879847040 1377606 4 ##(UI.CommandDescription) #chooseNamespace 8 '…' 1 1 nil nil false nil nil nil 1310982 ##(Core.MessageSequence) 34 3 1049350 ##(Core.MessageSend) #createAt:extent: 34 2 578 649 61 578 41 41 768 978 #isEnabled: 8 #(false) 768 978 #text: 34 1 8 '…' 768 1179910 ##(OS.WINDOWPLACEMENT) 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 68 1 0 0 30 0 0 0 88 1 0 0 50 0 0 0] 8 #() 578 193 193 nil 29 1378374 2 ##(UI.FramingConstraints) 1377286 ##(UI.FramingCalculation) #fixedPreviousRight 15 1250 #fixedViewLeft 41 1250 #fixedPreviousTop 1 1250 #fixedViewTop 41 410 ##(UI.TextEdit) 34 16 nil 640 34 2 8 1140850816 262145 1328 nil 848 nil 7 nil nil nil 1328 nil 8 1879842560 1049094 ##(UI.NullConverter) nil nil 7 930 34 2 978 #createAt:extent: 34 2 578 245 61 578 391 41 1328 978 #setMarginWidths: 34 1 8 #(3 3) 1328 1138 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 122 0 0 0 30 0 0 0 61 1 0 0 50 0 0 0] 8 #() 1200 nil 27 1218 1264 1 1250 #fixedParentRight -53 1296 -1 1312 41 410 ##(UI.StaticText) 34 16 nil 640 34 2 8 1140850944 1 1664 nil nil nil 7 nil nil nil 1664 nil 8 1879886752 1410 nil nil nil 930 34 2 978 #createAt:extent: 34 2 578 5 3 578 241 41 1664 978 #text: 34 1 8 'New superclass &name:' 1664 1138 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 2 0 0 0 1 0 0 0 122 0 0 0 21 0 0 0] 8 #() 1200 nil 27 1218 1250 #fixedParentLeft 5 1280 241 1250 #fixedParentTop 3 1312 41 410 ##(UI.StaticRectangle) 34 14 nil 640 34 2 8 1140850960 1 2000 nil nil nil 7 nil nil nil 2000 nil 8 1879886752 930 34 1 978 #createAt:extent: 34 2 578 1 119 578 689 5 2000 1138 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 59 0 0 0 88 1 0 0 61 0 0 0] 8 #() 1200 nil 27 1218 1968 1 1648 1 1250 #fixedViewBottom -3 1250 #fixedParentBottom -7 410 ##(UI.StaticText) 34 16 nil 640 34 2 8 1140850944 1 2272 nil nil nil 7 nil nil nil 2272 nil 8 1879886752 1410 nil nil nil 930 34 2 978 #createAt:extent: 34 2 578 5 63 578 241 41 2272 978 #text: 34 1 8 '&Namespace:' 2272 1138 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 2 0 0 0 31 0 0 0 122 0 0 0 51 0 0 0] 8 #() 1200 nil 27 1218 1968 5 1280 241 1250 #fixedPreviousBottom 21 1312 41 410 ##(UI.TextEdit) 34 16 nil 640 34 2 8 1140916352 1025 2592 nil 848 nil 7 nil nil nil 2592 nil 8 1879842560 1410 nil nil 5 930 34 2 978 #createAt:extent: 34 2 578 245 -1 578 391 45 2592 978 #setMarginWidths: 34 1 8 #(3 3) 2592 1138 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 122 0 0 0 255 255 255 255 61 1 0 0 21 0 0 0] 8 #() 1200 nil 27 1218 1264 1 1648 -53 1296 -3 1312 45 170 192 34 6 768 8 'chooseNamespace' 1328 8 'namespace' 2592 8 'newClassName' nil 930 34 1 978 #createAt:extent: 34 2 578 21 17 578 689 131 640 1138 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 10 0 0 0 8 0 0 0 98 1 0 0 73 0 0 0] 34 6 1664 2592 2272 1328 768 2000 1200 nil 27 410 ##(UI.ReferenceView) 34 14 nil 416 34 2 8 1140850688 131073 3120 nil nil nil 7 nil nil nil 3120 1376838 1 ##(UI.ResourceIdentifier) ##(UI.Presenter) #resource_OK_Cancel_button_block nil 930 34 1 978 #createAt:extent: 34 2 578 21 433 578 689 61 3120 1138 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 10 0 0 0 216 0 0 0 98 1 0 0 246 0 0 0] 8 #() 1200 nil 27 nil nil 410 ##(UI.ContainerView) 34 15 nil 416 34 2 8 1140850688 131073 3360 nil nil nil 7 nil nil nil 3360 610 1 11 410 ##(UI.StaticText) 34 16 nil 3360 34 2 8 1140850944 65 3440 918598 2 ##(UI.ValueHolder) nil false 1769478 ##(Kernel.EqualitySearchPolicy) nil nil nil 519 nil nil nil 3440 848 8 1879886752 1410 nil nil nil 930 34 2 978 #createAt:extent: 34 2 578 1 1 578 689 31 3440 978 #text: 34 1 8 'Choose subclasses to be promoted to siblings:' 3440 1138 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 0 0 0 0 88 1 0 0 15 0 0 0] 8 #() 1200 nil 27 410 ##(UI.StatusBar) 34 21 nil 3360 34 2 8 1409288204 1 3792 nil nil nil 7 nil nil nil 3792 nil 8 1879377936 170 192 34 2 1050438 1 ##(UI.StatusBarItem) 8193 -1 3792 nil 786950 ##(Core.Message) #displayString 8 #() 3938 #iconImageIndex 8 #() nil 8 'status' nil nil nil 34 1 3920 1311814 1 ##(UI.StatusBarNullItem) 8705 1 3792 nil nil 930 34 1 978 #createAt:extent: 34 2 578 1 237 578 689 41 3792 1138 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 118 0 0 0 88 1 0 0 138 0 0 0] 8 #() 1200 nil 29 nil nil 410 ##(UI.ListView) 34 45 nil 3360 34 2 8 1140970059 1025 4224 787270 2 ##(UI.ListModel) 138 144 3344 nil 1769478 ##(Kernel.IdentitySearchPolicy) 848 nil 7 461638 4 ##(UI.Menu) nil true 34 4 1180742 2 ##(UI.CommandMenuItem) 1 882 #moveFirst 8 'Move to &First' 1 1 nil nil nil 4418 1 882 #moveUp 8 'Move to &Previous' 1 1 nil nil nil 4418 1 882 #moveDown 8 'Move to &Next' 1 1 nil nil nil 4418 1 882 #moveLast 8 'Move to &Last' 1 1 nil nil nil 8 '' nil 1 nil nil nil nil nil nil nil 4224 nil 8 1879798960 ##(UI.BasicListAbstract) ##(UI.IconicListAbstract) 1639750 1 ##(Graphics.IconImageManager) nil nil nil nil nil nil 138 144 34 1 1117254 5 ##(UI.ListViewColumn) 8 '' 689 #left ##(UI.BasicListAbstract) 3938 #<= 8 #() nil nil 4224 nil 3 nil nil #list 8 #() nil 133121 nil 1 nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil 930 34 2 978 #createAt:extent: 34 2 578 1 41 578 689 187 4224 978 #contextMenu: 34 1 4384 4224 1138 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 20 0 0 0 88 1 0 0 113 0 0 0] 8 #() 1200 nil 35 170 192 34 4 4224 8 'subclasses' 3792 8 'statusbar' 1180166 ##(Graphics.Rectangle) 578 1 1 578 1 11 930 34 1 978 #createAt:extent: 34 2 578 21 147 578 689 287 3360 1138 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 10 0 0 0 73 0 0 0 98 1 0 0 216 0 0 0] 34 3 3440 4224 3792 1200 nil 27 170 192 3344 5058 578 21 17 578 21 21 nil nil nil nil 10081 nil nil nil 578 601 441 1 nil nil 918278 ##(Core.Semaphore) nil nil 1 false 8 2001958528 930 34 2 978 #createAt:extent: 34 2 578 12287 21 578 761 591 416 978 #text: 34 1 8 'Convert to Sibling…' 416 1138 8 #[44 0 0 0 0 0 0 0 0 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 23 0 0 10 0 0 0 123 25 0 0 49 1 0 0] 34 3 640 3360 3120 1200 nil 27 )! !
!Tools.ConvertToSiblingDialog class categoriesForMethods!
defaultModel!models!public! !
resource_Default_view!public!resources-views! !
!

