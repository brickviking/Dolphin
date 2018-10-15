"Filed out from Dolphin Smalltalk 7"!

TextDocument subclass: #XmlPad
	instanceVariableNames: 'viewOptions'
	classVariableNames: 'RememberPlacementMask'
	poolDictionaries: ''
	classInstanceVariableNames: ''!
XmlPad guid: (GUID fromString: '{0b798c7b-c80f-46ab-9dd4-d8832b78d33c}')!
XmlPad addClassConstant: 'RememberPlacementMask' value: 16r1!
XmlPad comment: '`XmlPad` is a simple XML text editor. It is intended to demonstrate the `DocumentShell` hierarchy of Dolphin''s application framework, the `ScintillaView` editor component, and the use of the MSXML. XmlPad also demonstrates how to use the registry to save and restore user preferences. 

```
XmlPad show
```'!
!XmlPad categoriesForClass!MVP-Presenters! !
!XmlPad methodsFor!

about
	"Pop up a little helpful info. about this sample program."

	self class about!

basicValidateXml
	(self parseXml: self getDocumentData validate: true) free!

booleanOptions
	^#(#('AutoCompleteEnabled' #isAutoCompleteEnabled #isAutoCompleteEnabled:))!

booleanViewOptions
	^#(#('IdentationGuides' #hasIndentationGuides #hasIndentationGuides:) #('FormattingMarks' #hasFormattingMarks #hasFormattingMarks:) #('WordWrap' #hasWordWrap #hasWordWrap:) #('LineNumbers' #hasLineNumbers #hasLineNumbers:) #('AutoCompleteSingle' #isAutoCompletionSingleMatchChosen #isAutoCompletionSingleMatchChosen:) #('AutoCompleteTruncate' #isAutoCompletionTruncating #isAutoCompletionTruncating:) #('Folding' #isFoldingEnabled #isFoldingEnabled:))!

canSave
	"Answer whether the document is in a valid state and can be saved. Here we check that the document consists of valid Xml."

	^
	[self basicValidateXml.
	true] on: DOMParseError
			do: 
				[:ex | 
				MessageBox 
					confirm: 'The XML contains one or more errors and is invalid. Are you sure that you would like to save it?'
					caption: ex tag displayString]!

hasFormattingMarks
	^self scintilla whitespaceVisibility ~~ #invisible!

hasFormattingMarks: aBoolean 
	^self scintilla whitespaceVisibility: (aBoolean ifTrue: [#visibleAlways] ifFalse: [#invisible])!

hasIndentationGuides
	^self scintilla hasIndentationGuides!

hasIndentationGuides: aBoolean 
	^self scintilla hasIndentationGuides: aBoolean!

hasLineNumbers
	^self scintilla hasLineNumbers!

hasLineNumbers: aBoolean 
	^self scintilla hasLineNumbers: aBoolean!

hasWordWrap
	^self scintilla wordWrap!

hasWordWrap: aBoolean 
	^self scintilla wordWrap: aBoolean!

initialize
	super initialize.
	viewOptions := 0.!

isAutoCompleteEnabled
	^false!

isAutoCompleteEnabled: aBoolean 
	"Currently ignored as auto-completion is not implemented yet"

	!

isAutoCompletionSingleMatchChosen
	^self scintilla isAutoCompletionSingleMatchChosen!

isAutoCompletionSingleMatchChosen: aBoolean 
	^self scintilla isAutoCompletionSingleMatchChosen: aBoolean!

isAutoCompletionTruncating
	^self scintilla isAutoCompletionTruncating!

isAutoCompletionTruncating: aBoolean 
	^self scintilla isAutoCompletionTruncating: aBoolean!

isFoldingEnabled
	^self scintilla isFoldingEnabled!

isFoldingEnabled: aBoolean 
	self scintilla isFoldingEnabled: aBoolean!

isRememberingPlacement
	^viewOptions allMask: RememberPlacementMask!

isRememberingPlacement: aBoolean 
	viewOptions := viewOptions mask: RememberPlacementMask set: aBoolean!

parseXml
	^self parseXml: self getDocumentData validate: false!

parseXml: aString validate: aBoolean 
	| dom |
	dom := IXMLDOMDocument new.
	"Preserve whitespace in case there are any mixed text/element nodes. This allows the
	formatter to preserve the text of these nodes exactly."
	dom
		preserveWhiteSpace: false;
		validateOnParse: aBoolean;
		resolveExternals: aBoolean.
	(dom loadXML: aString asString) 
		ifFalse: [dom parseErrorClass signal: 'Error in XML' with: dom parseError].
	^dom!

queryCommand: query
	"Private - Enters details about a potential command for the receiver into 
	the <CommandQuery>, query"

	| cmd |
	cmd := query commandSymbol.
	cmd == #viewToolbar
		ifTrue: 
			[query
				isEnabled: true;
				isChecked: self toolbar isWindowVisible.
			^true].
	cmd == #viewStatusBar
		ifTrue: 
			[query
				isEnabled: true;
				isChecked: self statusBar isWindowVisible.
			^true].
	^super queryCommand: query!

reformatXml
	| dom formatter reformatted |
	dom := [self parseXml] on: DOMParseError
				do: 
					[:ex | 
					statusModel value: ex tag.
					nil].
	dom ifNil: [^self].
	formatter := XmlFormatter new.
	reformatted := formatter format: dom.
	"
	DiffBrowser compare: originalText with: reformatted.
"
	"Replace the text using the Scintilla target feature (this is like an invisible selection).
	If we just set the text, then it would not be undoable."
	(self scintilla)
		targetAll;
		replaceTarget: reformatted!

restoreBooleanOptions: anArrayOfPairs 
	| values |
	values := self userSettingsKey subValues.
	anArrayOfPairs 
		do: [:each | values at: each first ifPresent: [:bool | self perform: each third with: bool asBoolean]]!

restoreTabWidth
	self userSettingsKey subValues at: 'TabWidth' ifPresent: [:width | self tabWidth: width]!

restoreTextStyles
	self userSettingsKey at: 'TextStyles'
		ifPresent: 
			[:key | 
			| styles |
			styles := Object fromRegKey: key.
			self scintilla textStyles: styles]!

restoreUserSettings
	self restoreViewOptions.
	self restoreBooleanOptions: self booleanOptions!

restoreViewOptions
	self restoreBooleanOptions: self booleanViewOptions.
	self restoreTextStyles.
	self restoreTabWidth!

saveBooleanOptions: anArrayOfPairs 
	| values |
	values := self userSettingsKey subValues.
	anArrayOfPairs do: [:each | values at: each first put: (self perform: each second) asParameter]!

saveFontSetting
	self userSettingsKey valueAt: 'Font' put: self view actualFont logFont!

saveOptions
	self saveViewOptions.
	self saveBooleanOptions: self booleanOptions!

saveTabWidth
	self userSettingsKey valueAt: 'TabWidth' put: self tabWidth!

saveTextStyles
	self scintilla textStyles asArray storeUnderRegKey: self userSettingsKey as: 'TextStyles'!

saveUserSettings
	"Private - Save the users configuration to the registry."

	self
		saveOptions;
		saveWindowPlacement!

saveViewOptions
	self userSettingsKey valueAt: 'SavePlacement' put: self isRememberingPlacement asParameter.
	self saveTabWidth.
	self saveBooleanOptions: self booleanViewOptions.
	self saveTextStyles!

saveWindowPlacement
	self isRememberingPlacement 
		ifTrue: 
			[| placement |
			placement := self view placement.
			placement showCmd: (self view isMaximized ifTrue: [SW_SHOWMAXIMIZED] ifFalse: [SW_SHOW]).
			self userSettingsKey valueAt: 'placement' put: placement]
		ifFalse: [self userSettingsKey removeSubValue: 'placement' ifAbsent: []]!

scintilla
	^documentPresenter view!

statusBar
	^self view viewNamed: 'statusbar'!

tabWidth
	^self scintilla tabWidth!

tabWidth: anInteger 
	self scintilla tabWidth: anInteger!

toolbar
	^self view viewNamed: 'toolbar'!

userSettingsKey
	"Private - Answer the <RegKey> under which user settings are stored for the RulesSetBrowser
	itself."

	^self class userSettingsKey!

validateXml
	statusModel value: (
			[self basicValidateXml.
			nil] on: DOMParseError do: [:ex | ex tag])!

viewStatusBar
	| statusBar |
	statusBar := self statusBar.
	statusBar isWindowVisible ifTrue: [statusBar hide] ifFalse: [statusBar show]!

viewToolbar
	| toolbar |
	toolbar := self toolbar.
	toolbar isWindowVisible ifTrue: [toolbar hide] ifFalse: [toolbar show]! !
!XmlPad categoriesFor: #about!commands!public! !
!XmlPad categoriesFor: #basicValidateXml!helpers!private! !
!XmlPad categoriesFor: #booleanOptions!helpers!private! !
!XmlPad categoriesFor: #booleanViewOptions!helpers!private! !
!XmlPad categoriesFor: #canSave!public!testing! !
!XmlPad categoriesFor: #hasFormattingMarks!public!testing! !
!XmlPad categoriesFor: #hasFormattingMarks:!accessing!public! !
!XmlPad categoriesFor: #hasIndentationGuides!public!testing! !
!XmlPad categoriesFor: #hasIndentationGuides:!accessing!public! !
!XmlPad categoriesFor: #hasLineNumbers!public!testing! !
!XmlPad categoriesFor: #hasLineNumbers:!accessing!public! !
!XmlPad categoriesFor: #hasWordWrap!public!testing! !
!XmlPad categoriesFor: #hasWordWrap:!accessing!public! !
!XmlPad categoriesFor: #initialize!initializing!public! !
!XmlPad categoriesFor: #isAutoCompleteEnabled!public! !
!XmlPad categoriesFor: #isAutoCompleteEnabled:!public! !
!XmlPad categoriesFor: #isAutoCompletionSingleMatchChosen!public!testing! !
!XmlPad categoriesFor: #isAutoCompletionSingleMatchChosen:!public! !
!XmlPad categoriesFor: #isAutoCompletionTruncating!public!testing! !
!XmlPad categoriesFor: #isAutoCompletionTruncating:!public! !
!XmlPad categoriesFor: #isFoldingEnabled!public!testing! !
!XmlPad categoriesFor: #isFoldingEnabled:!accessing!public! !
!XmlPad categoriesFor: #isRememberingPlacement!commands!public! !
!XmlPad categoriesFor: #isRememberingPlacement:!public!testing! !
!XmlPad categoriesFor: #parseXml!helpers!private! !
!XmlPad categoriesFor: #parseXml:validate:!helpers!private! !
!XmlPad categoriesFor: #queryCommand:!commands!private! !
!XmlPad categoriesFor: #reformatXml!commands!public! !
!XmlPad categoriesFor: #restoreBooleanOptions:!operations!private! !
!XmlPad categoriesFor: #restoreTabWidth!operations!private! !
!XmlPad categoriesFor: #restoreTextStyles!helpers!private! !
!XmlPad categoriesFor: #restoreUserSettings!helpers!private! !
!XmlPad categoriesFor: #restoreViewOptions!operations!private! !
!XmlPad categoriesFor: #saveBooleanOptions:!helpers!private! !
!XmlPad categoriesFor: #saveFontSetting!helpers!private! !
!XmlPad categoriesFor: #saveOptions!helpers!private! !
!XmlPad categoriesFor: #saveTabWidth!helpers!private! !
!XmlPad categoriesFor: #saveTextStyles!helpers!private! !
!XmlPad categoriesFor: #saveUserSettings!helpers!private! !
!XmlPad categoriesFor: #saveViewOptions!helpers!private! !
!XmlPad categoriesFor: #saveWindowPlacement!helpers!private! !
!XmlPad categoriesFor: #scintilla!accessing!private! !
!XmlPad categoriesFor: #statusBar!accessing!private! !
!XmlPad categoriesFor: #tabWidth!accessing!private! !
!XmlPad categoriesFor: #tabWidth:!accessing!private! !
!XmlPad categoriesFor: #toolbar!accessing!private! !
!XmlPad categoriesFor: #userSettingsKey!accessing!private! !
!XmlPad categoriesFor: #validateXml!commands!public! !
!XmlPad categoriesFor: #viewStatusBar!commands!private! !
!XmlPad categoriesFor: #viewToolbar!commands!private! !

!XmlPad class methodsFor!

about
	"Private - Pop up a little helpful info. about this sample program."

	(MessageBox new)
		caption: ('About Dolphin <1d>' expandMacrosWith: self);
		icon: self icon;
		text: (self aboutTemplate expandMacrosWith: VMLibrary default fullVersion);
		open!

aboutTemplate
	"Private - Answer the text to be used in the receiver's about box"

	^'XmlPad Sample<n><1s><n>
XmlPad is a simple text-based XML editor. It is intended to demonstrate the DocumentShell hierarchy 
of Dolphin''s application framework, the Scintilla view component, and the use of the MSXML. 
It is also useful for editing Xml!!<n>
DISCLAIMER: This software is freely provided purely as an educational sample and as such it
is provided "as is", WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.'!

defaultFileExtension
	"Answer a default extension that will be used for files saved from
	the receiver"

	^'xml'!

explicitDependencies
	AdvancedFindDialog
!

fileTypes
	"Answer an Array of file types that can be associated with this class of document."

	^#(#('XML Files (*.xml)' '*.xml') #('All Files (*.*)' '*.*'))!

icon
	"Answers an Icon that can be used to represent this class and which is displayed in the
	caption of the dialog box."

	^Icon fromId: 'XML.ICO'!

initialize
	"
	self initialize
	"

	self addClassConstant: 'RememberPlacementMask' value: 1!

installKeyName
	"Private - Answer the name of the base installation registry key."

	^'Software\Object Arts'!

resource_Default_view
	"Answer the literal data from which the 'Default view' resource can be reconstituted.
	DO NOT EDIT OR RECATEGORIZE THIS METHOD.

	If you wish to modify this resource evaluate:
	ViewComposer openOn: (ResourceIdentifier class: self selector: #resource_Default_view)
	"

	^#(#'!!STL' 4 788558 10 ##(Smalltalk.STBViewProxy) ##(Smalltalk.ShellView) 34 27 nil nil 8 #(13565952 65536) 416 nil 721158 ##(Smalltalk.SystemColor) 31 nil 549 nil nil nil 416 788230 ##(Smalltalk.BorderLayout) 1 1 410 ##(Smalltalk.Toolbar) 34 25 nil 416 34 2 8 1140853508 131137 528 nil 786694 ##(Smalltalk.ColorDefault) 8 4278190080 nil 519 nil 263174 ##(Smalltalk.Font) nil true 459014 ##(Smalltalk.LOGFONT) 8 #[243 255 255 255 0 0 0 0 0 0 0 0 0 0 0 0 144 1 0 0 0 0 0 0 3 2 1 34 65 114 105 97 108 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0] 328198 ##(Smalltalk.Point) 193 193 nil 528 608 8 1915204752 170 192 8 #() 170 192 34 22 48163 1246790 1 ##(Smalltalk.ToolbarSystemButton) 528 1 1180998 4 ##(Smalltalk.CommandDescription) #fileSave 8 'Save' 1 1 nil 48163 1 17 48165 834 528 1 866 #printDocument 8 'Print' 1 1 nil 48165 1 29 48167 834 528 1 866 #printPreview 8 'Print Preview' 1 1 nil 48167 1 19 48169 834 528 1 866 #find 8 'Find' 1 1 nil 48169 1 25 48171 834 528 1 866 #cutSelection 8 'Cut' 1 1 nil 48171 1 1 48173 834 528 1 866 #copySelection 8 'Copy' 1 1 nil 48173 1 3 48175 834 528 1 866 #pasteSelection 8 'Paste' 1 1 nil 48175 1 5 48177 834 528 1 866 #clearSelection 8 'Delete' 1 1 nil 48177 1 11 48179 834 528 1 866 #undo 8 'Undo' 1 1 nil 48179 1 7 48159 834 528 1 866 #fileNew 8 'New' 1 1 nil 48159 1 13 48161 834 528 1 866 #fileOpen 8 'Open' 1 1 nil 48161 1 15 34 14 1296 1344 848 1049158 1 ##(Smalltalk.ToolbarSeparator) 528 1 912 960 1410 528 11 1008 1410 528 1 1056 1104 1152 1200 1248 nil nil 1 nil 722 33 33 722 45 45 nil 656198 1 ##(Smalltalk.FlowLayout) 1 1 1 983302 ##(Smalltalk.MessageSequence) 138 144 34 2 721670 ##(Smalltalk.MessageSend) #createAt:extent: 34 2 722 1 1 722 2369 51 528 1602 #updateSizePosted 784 528 983302 ##(Smalltalk.WINDOWPLACEMENT) 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 0 0 0 0 160 4 0 0 25 0 0 0] 8 #() 722 193 193 nil 27 410 ##(Smalltalk.StatusBar) 34 18 nil 416 34 2 8 1140850948 1 1776 nil 608 nil 7 nil 642 nil true 674 8 #[243 255 255 255 0 0 0 0 0 0 0 0 0 0 0 0 144 1 0 0 0 0 0 0 3 2 1 34 65 114 105 97 108 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0] 722 193 193 nil 1776 nil 8 1914952576 170 192 34 2 853766 ##(Smalltalk.StatusBarItem) 1 -1 1776 nil 459270 ##(Smalltalk.Message) #displayString 8 #() 787814 3 ##(Smalltalk.BlockClosure) 0 nil 918822 ##(Smalltalk.CompiledMethod) 3 3 1952 #defaultGetImageBlock 462740483 8 #[31 105 226 0 159 106] #icon #imageIndex 2048 7 257 nil nil 8 'status' 34 1 1968 1115142 ##(Smalltalk.StatusBarNullItem) 513 1 1776 nil nil 1538 138 144 34 1 1602 #createAt:extent: 34 2 722 1 1491 722 2369 45 1776 1698 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 233 2 0 0 160 4 0 0 255 2 0 0] 8 #() 1760 nil 27 nil nil 410 ##(Smalltalk.ScintillaView) 34 50 nil 416 34 2 8 1174475012 262145 2336 721990 2 ##(Smalltalk.ValueHolder) nil false 1310726 ##(Smalltalk.EqualitySearchPolicy) nil 608 nil 23 nil nil nil 2336 nil 8 1421069929 852486 ##(Smalltalk.NullConverter) nil nil 9 nil 170 192 34 60 #normal 1182790 1 ##(Smalltalk.ScintillaTextStyle) 1 nil nil 1 nil nil nil nil #normal nil nil nil #unknownAttribute 2546 9 786694 ##(Smalltalk.IndexedColor) 33554445 nil 1 nil nil nil nil #unknownAttribute nil nil nil #attribute 2546 7 2608 nil 1 nil nil nil nil #attribute nil nil nil #sgmlSpecial 2546 55 196934 1 ##(Smalltalk.RGB) 33475687 2658 33546207 1 nil nil nil nil #sgmlSpecial nil nil nil #sgmlDoubleString 2546 49 2594 33554435 2658 33546207 1 nil nil nil nil #sgmlDoubleString nil nil nil #sgmlTag 2546 43 2594 33554441 2658 33546207 1 nil nil nil nil #sgmlTag nil nil nil #question 2546 37 2720 nil 1 nil nil nil nil #question nil nil nil #sgmlComment 2546 59 2658 65793 2658 33546207 1 nil nil nil nil #sgmlComment nil nil nil #sgmlSingleString 2546 51 2658 26419 2658 33546207 1 nil nil nil nil #sgmlSingleString nil nil nil #sgmlBlock 2546 63 2658 13369345 2658 29464985 1 nil nil nil nil #sgmlBlock nil nil nil #callTip 2546 77 2594 33554457 2594 33554471 1 nil nil nil nil #callTip nil nil nil #sgmlEntity 2546 57 2658 6710887 2658 33546207 1 nil nil nil nil #sgmlEntity nil nil nil #tag 2546 3 2768 nil 1 nil nil nil nil #tag nil nil nil #unknownTag 2546 5 2768 nil 1 nil nil nil nil #unknownTag nil nil nil #sgmlFirstParam 2546 47 2658 52225 2658 33546207 1 nil nil nil nil #sgmlFirstParam nil nil nil #identifierStart 2546 27 2594 33554443 nil 3 nil nil nil nil #identifierStart nil 1401 nil #doubleString 2546 13 2658 16646399 nil 1 nil nil nil nil #doubleString nil nil nil #indentGuide 2546 75 nil nil 1 nil nil nil nil #indentGuide nil nil nil #otherInsideTag 2546 17 3152 nil 1 nil nil nil nil #otherInsideTag nil nil nil #sgmlError 2546 53 2720 2658 13422079 1 nil nil nil nil #sgmlError nil nil nil #sgmlCommand 2546 45 2768 2658 33546207 3 nil nil nil nil #sgmlCommand nil 1401 nil #styleTagEnd 2546 23 2768 nil 1 nil nil nil nil #styleTagEnd nil nil nil #unquotedValue 2546 39 2658 12648641 nil 1 nil nil nil nil #unquotedValue nil nil nil #CDATA 2546 35 2720 2658 31580671 129 nil nil nil nil #CDATA nil nil nil #lineNumber 2546 67 nil nil 1 nil nil nil nil #lineNumber nil nil nil #singleString 2546 15 2658 16646399 nil 1 nil nil nil nil #singleString nil nil nil #entity 2546 21 3152 nil 1 nil nil nil nil #entity nil nil nil #identifierEnd 2546 25 3152 nil 3 nil nil nil nil #identifierEnd nil 1401 nil #number 2546 11 2658 16711169 nil 1 nil nil nil nil #number nil nil nil #comment 2546 19 2658 65793 nil 1 nil nil nil nil #comment nil nil nil 34 40 2560 3056 3072 2624 2576 3456 3168 3392 3216 3488 3424 3296 3440 3136 nil nil nil 3344 2800 3312 nil 2752 3264 3088 2704 2864 3232 2640 3008 2816 nil 2912 nil 3376 nil nil nil 3200 nil nil 1245510 1 ##(Smalltalk.NullScintillaStyler) #normal 170 192 34 14 #folderMidTail 1641542 1 ##(Smalltalk.ScintillaMarkerDefinition) 55 11 33554471 33554433 2336 #folderMidTail nil nil nil nil nil nil #folderTail 3602 57 11 33554471 33554433 2336 #folderTail nil nil nil nil nil nil #folderSub 3602 59 11 33554471 33554433 2336 #folderSub nil nil nil nil nil nil #folderOpenMid 3602 53 11 33554471 33554433 2336 #folderOpenMid nil nil nil nil nil nil #folderEnd 3602 51 11 33554471 33554433 2336 #folderEnd nil nil nil nil nil nil #folderOpen 3602 63 15 33554471 33554433 2336 #folderOpen nil nil nil nil nil nil #folder 3602 61 17 33554471 33554433 2336 #folder nil nil nil nil nil nil 138 ##(Smalltalk.IdentitySet) 784 nil 170 176 784 123903 nil nil nil nil 2594 33554447 nil nil 65 nil nil nil 8 '' 5 170 192 34 2 #container 2512 nil nil #plusMinus 33 130003 nil 170 192 34 6 8 'indicator2' 1510470 2 ##(Smalltalk.ScintillaIndicatorStyle) 5 2336 511 1 false nil nil nil nil nil nil nil 8 'indicator0' 3874 1 2336 65025 3 false nil nil nil nil nil nil nil 8 'indicator1' 3874 3 2336 33423361 5 false nil nil nil nil nil nil nil nil nil 170 192 34 6 #Notification 2546 1027 nil 2658 31185883 1 nil nil nil nil #Notification nil nil nil #Warning 2546 1029 2658 60239 2658 31326207 1 nil nil nil nil #Warning nil nil nil #Error 2546 1031 2658 335 2658 31317503 1 nil nil nil nil #Error nil nil nil nil 1538 138 144 34 9 1602 #createAt:extent: 34 2 722 1 51 722 2369 1441 2336 1602 #textLimit: 8 #(1073741823) 2336 1602 #modificationEventMask: 8 #(61951) 2336 1602 #caretPeriod: 8 #(530) 2336 1602 #wordWrap: 8 #(true) 2336 1602 #margins: 34 1 34 3 985158 2 ##(Smalltalk.ScintillaMargin) 1 2336 1 3 nil nil nil nil 4418 3 2336 33 nil nil 67108863 nil nil 4418 5 2336 33 nil 3 -67108863 nil nil 2336 1602 #canHScroll: 8 #(false) 2336 1602 #maxCompletionListHeight: 8 #(9) 2336 1602 #setLexerLanguage: 8 #(#xml) 2336 1698 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 25 0 0 0 160 4 0 0 233 2 0 0] 8 #() 1760 nil 29 170 192 34 6 1776 8 'statusbar' 528 8 'toolbar' 2336 8 'document' nil 461638 4 ##(Smalltalk.MenuBar) nil true 34 4 265030 4 ##(Smalltalk.Menu) nil true 34 10 984134 2 ##(Smalltalk.CommandMenuItem) 1 866 #fileNew 8 '&New' 9373 1 nil nil nil 4802 1 866 #fileOpen 8 '&Open...' 9375 1 nil nil nil 4802 1 866 #fileSave 8 '&Save' 8359 1 nil nil nil 4802 1 866 #fileSaveAs 8 'Save &As...' 1 1 nil nil nil 983366 1 ##(Smalltalk.DividerMenuItem) 4097 4802 1 866 #printDocument 8 '&Print...' 9377 1 nil nil nil 4802 1 866 #printPreview 8 'Print Pre&view' 1 1 nil nil nil 4802 1 866 #pageSetup 8 'Page Set&up...' 1 1 nil nil nil 5010 4097 4802 1 866 #exit 8 'E&xit' 1025 1 nil nil nil 8 '&File' nil 1 nil nil 48239 nil nil 4754 nil true 34 16 4802 1 866 #undo 8 '&Undo' 9397 1 nil nil nil 4802 1 866 #redo 8 '&Redo' 9395 1 nil nil nil 5010 4097 4802 1 866 #cutSelection 8 'Cu&t' 9393 1 nil nil nil 4802 1 866 #copySelection 8 '&Copy' 9351 1 nil nil nil 4802 1 866 #pasteClipboard 8 '&Paste' 9389 1 nil nil nil 4802 1 866 #pasteSpecial 8 'Paste &Special...' 1 1 nil nil nil 4802 1 866 #clearSelection 8 'Cle&ar' 1025 1 nil nil nil 4802 1 866 #selectAll 8 'Select All' 9347 1 nil nil nil 5010 4097 4802 1 866 #reformatXml 8 'Refor&mat' 1 1 nil nil nil 4802 1 866 #validateXml 8 '&Validate' 1 1 nil nil nil 5010 4097 4802 1 866 #find 8 '&Find...' 9357 1 nil nil nil 4802 1 866 #findNext 8 'Find &Next' 1253 1 nil nil nil 4802 1 866 #findReplace 8 'R&eplace...' 9361 1 nil nil nil 8 '&Edit' nil 1 nil nil 48267 nil nil 4754 nil true 34 7 4802 1 866 #viewToolbar 8 '&Toolbar' 1025 1 nil nil nil 4802 1 866 #viewStatusBar 8 '&Status Bar' 1025 1 nil nil nil 5010 4097 4802 1 866 #foldAll 8 '&Fold All' 1 1 nil nil nil 4802 1 866 #unfoldAll 8 '&Unfold All' 1 1 nil nil nil 5010 4097 4754 nil true 34 1 4802 1 866 #editStyles 8 'Text &Styles' 1 1 nil nil nil 8 '&Options' nil 134217729 nil nil 48279 nil nil 8 '&View' nil 1 nil nil 48281 nil nil 4754 nil true 34 3 4802 1 866 #help 8 '&Help Topics' 1025 1 nil nil nil 5010 4097 4802 1 866 #about 8 '&About' 1 1 nil nil nil 8 '&Help' nil 1 nil nil 48287 nil nil 8 '' nil 1 nil nil nil nil nil nil nil nil 1 nil nil nil nil 1 nil nil 1538 138 144 34 2 1602 #createAt:extent: 34 2 722 3839 21 722 2401 1653 416 1602 #updateMenuBar 784 416 1698 8 #[44 0 0 0 0 0 0 0 0 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 127 7 0 0 10 0 0 0 47 12 0 0 68 3 0 0] 34 3 528 2336 1776 1760 nil 27 )!

toolName
	^self name!

userSettingsKey
	"Private - Answer the <RegKey> under which user specific settings should be stored."

	^self userSettingsRootKey createKey: self toolName!

userSettingsRootKey
	^RegKey userRoot createKey: self installKeyName! !
!XmlPad class categoriesFor: #about!enquiries!private! !
!XmlPad class categoriesFor: #aboutTemplate!enquiries!private! !
!XmlPad class categoriesFor: #defaultFileExtension!constants!public! !
!XmlPad class categoriesFor: #explicitDependencies!must not strip!private! !
!XmlPad class categoriesFor: #fileTypes!constants!public! !
!XmlPad class categoriesFor: #icon!constants!public! !
!XmlPad class categoriesFor: #initialize!development!initializing!public! !
!XmlPad class categoriesFor: #installKeyName!accessing!public! !
!XmlPad class categoriesFor: #resource_Default_view!public!resources-views! !
!XmlPad class categoriesFor: #toolName!accessing!public! !
!XmlPad class categoriesFor: #userSettingsKey!accessing!public! !
!XmlPad class categoriesFor: #userSettingsRootKey!accessing!public! !

