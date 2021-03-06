﻿"Filed out from Dolphin Smalltalk"!

Core.Object subclass: #BasicImageStripper
	instanceVariableNames: 'events'
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
BasicImageStripper guid: (Core.GUID fromString: '{51ce4971-61e8-431f-9823-437cf7293e8a}')!
BasicImageStripper isNonInstantiable: true!
BasicImageStripper comment: 'Base image stripping methods. These can safely be encrypted during release.'!
!BasicImageStripper categoriesForClass!MVP-Models! !
!BasicImageStripper methodsFor!

actualRequiredPackages
	"Private - Answer the <collection> of <Package>s to be included in the deployed application."

	^self systemPackageManager packages!

allMethodsInClasses: classes do: operation
	"Private - Evaluate the <monadicValuable>, operation, for each and every method
	in the <collection> of <Class>es, classes."

	classes do: 
			[:eachClass |
			eachClass methodDictionary do: operation.
			eachClass class methodDictionary do: operation]!

allReferencedClasses
	^Class allClasses!

basicDeleteClass: aClass
	"Private - Remove the specified class from the system. Note that we do not use the ClassBuilder for this purpose."

	| subs |
	[aClass uninitializeBeforeRemove] on: Error
		do: 
			[:x |
			self
				logElement: 'Error'
				attributes: {'class' -> x class fullName}
				value: 'Error uninitializing ' , aClass fullName , ': ' , x description].
	aClass classPool associationsDo: [:var | var environment: nil].
	aClass basicClassPool: nil.
	subs := aClass subclasses.
	subs notEmpty
		ifTrue: 
			[Notification signal: (String writeStream
						print: aClass;
						nextPutAll: ' has ';
						display: subs size;
						nextPutAll: ' subclasses';
						contents)].
	self detachClass: aClass!

basicDeleteMethod: aCompiledMethod
	self logMethod: aCompiledMethod.
	aCompiledMethod methodClass methodDictionary removeKey: aCompiledMethod selector
		ifAbsent: 
			["Could be in a weakly held development class which has evaporated"
			]!

collectGarbage: iterations
	"Private - Perform a few GC's to clear away old stuff.
	Note that we explicitly clear down the finalization queue each time."

	| memMan |
	Smalltalk clearCachedClasses.
	BindingReference flushBindings.
	memMan := MemoryManager current.
	iterations timesRepeat: 
			[memMan
				collectGarbage;
				administerLastRites]!

compileExternalStructures
	^false!

compileExternalStructuresNow: aCollection
	"Private - Fully compile all ExternalStructure subclasses so that the template definitions and
	the AttributeDescriptor subclasses may be removed. In order to do this we forcibly and
	fully compile all the ExternalStructure accessor methods before removing the templates. If we
	do not, the templates will be required when #doesNotUnderstand: handles an accessor
	message for a field that is not normally compiled."

	self notify: 'Fully compiling ExternalStructures'.
	self startElement: 'CompileExternalStructures' attributes: #().
	self systemPackageManager noEventsDo: 
			[aCollection do: [:each | each fullyCompileDefinition].
			"Lazy template definition is not required (or possible), so stub it out"
			External.Structure class compile: 'ensureDefined'.
			aCollection do: [:each | each removeTemplate].
			"ExternalStructure DNU processing is no longer needed since fully compiled"
			self removeSelectors: #(#getFieldNames #canUnderstand:) of: External.Structure class.
			self removeSelectors: #(#doesNotUnderstand:) of: External.Structure].
	"Field meta-data classes are no longer required"
	self deleteFieldClasses.
	self endElement: true.
	self finishedWithAll: #(#deleteFieldClasses)!

defineExternalStructures: aCollection
	"Private - Ensure that all external structures are fully defined to avoid any recompilation that might
	otherwise be triggered in a run-time image should the size be lazily determined."

	self notify: 'Building all ExternalStructure templates'.
	self
		logElement: 'DefineExternalStructures'
		attributes: #()
		value: nil.
	self systemPackageManager noEventsDo: [aCollection do: [:each | each byteSize]]!

deleteClass: aClass
	"Private - Removes aClass from the image. Answer the number of classes that
	were actually removed (subclasses may be removed too)."

	(aClass environment localBindingFor: aClass unqualifiedName) ifNil: [^0].
	^self uncheckedDeleteClass: aClass!

deleteClasses: aCollection reason: aString
	| count |
	aCollection isEmpty ifTrue: [^0].
	count := 0.
	self startElement: 'StripClasses' attributes: {'reason' -> aString}.
	aCollection do: [:each | count := count + (self deleteClass: each)].
	self endElement: count > 0.
	^count!

deleteFieldClasses
	self assert: [self systemPackageManager isProcessingEvents].
	self startElement: 'StripClasses' attributes: {'reason' -> 'structure field descriptors'}.
	#{Smalltalk.ExternalField} undeclare.
	#(#{External.Field} #{External.ArrayFieldLength})
		do: [:each | self uncheckedDeleteClass: each value].
	self endElement: true!

deleteMethod: aCompiledMethod
	self basicDeleteMethod: aCompiledMethod.
	Object flushMethodCache!

deleteMethods: aCollection
	aCollection asArray sort do: [:each | self basicDeleteMethod: each].
	Object flushMethodCache!

deleteMethodSoft: aCompiledMethod
	^false!

deleteResource: aResourceIdentifier
	self
		logElement: 'RemoveResource'
		attributes: {'owningClass' -> aResourceIdentifier owningClass fullName}
		value: aResourceIdentifier name.
	ResourceIdentifier removeResource: aResourceIdentifier!

deleteResources: aCollection reason: aString
	aCollection isEmpty ifTrue: [^0].
	self startElement: 'StripResources' attributes: {'reason' -> aString}.
	aCollection do: [:each | self deleteResource: each].
	self endElement: true.
	^aCollection size!

deploymentContext
	^DeafObject.Current!

destroyAndRemoveProgress
	"Private - Destroy the progress view and remove its class if possible."

	self
		logElement: 'CloseProgressDialog'
		attributes: #()
		value: nil.
	
	[self destroyNotifier.
	SessionManager inputState
		pumpMessages;
		processDeferredActions.
	SessionManager current isConsoleApplication ifTrue: [self removeGuiForConsoleApplication].

	"Ensure RichText converter is not hanging around unecessarily"
	#{UI.RichText} ifDefined: [:rt | rt uninitialize].
	SessionManager inputState purgeDeadWindows]
			on: Error
			do: 
				[:e |
				self deploymentContext logStrippingError: e.
				VM crashDump: e description].
	self collectGarbage: 3.
	self finishedWithAll: #(#destroyNotifier #progressDialogClass #removeGuiForConsoleApplication)!

destroyNotifier
	self deploymentContext destroyNotifier!

detachClass: aClass
	Smalltalk removeClass: aClass.
	aClass environment: nil!

developmentResources
	"Answer a <collection> of <ResourceIdentifier>s representing any development system resources that
	are not owned directly by development classes."

	^#()!

emptyMethodDictionariesOfStubbornClasses
	"Answer whether the method dictionaries of classes that refuse to uninstall with their
	owning package should be emptied. Although this is somewhat of a risky option, it does
	help one to track down the root of stripping problems since it helps to remove the knock
	on effects of the original source of the problem."

	^false.!

emptySystemDictionary
	"Private - Remove all non-class globals from the SystemDictionary.
	This should only be performed if the application does not intend
	to look up objects dynamically by name in Smalltalk.

	Note that we cannot remove classes from Smalltalk since these
	ARE looked up by name by the STBFiler mechanism, though we
	do remove global aliases for classes as their is a separate mechanism
	in place to ensure STB can still locate the appropriate class for these."

	| globals |
	self startElement: 'EmptySystemDictionary' attributes: #().
	globals := OrderedCollection new.
	Root allBindingsDo: 
			[:each |
			(each isClassVariable not and: [each value class isMeta not or: [each value name ~~ each key]])
				ifTrue: [globals add: each]].
	globals do: 
			[:each |
			self
				logElement: 'Global'
				attributes: #()
				value: each key.
			each environment basicRemoveBinding: each].
	self collectGarbage: 3.
	self endElement: true!

endElement: aBoolean
	self deploymentContext endElement: aBoolean!

endTag
	self deploymentContext endTag!

externalStructureClasses
	^External.Structure withAllSubclasses!

finishedWithAll: aCollectionOfSymbols
	"Private - The receiver has finished with its method identified by the selectors in the <collection> argument, so they can be stripped. We do this by removing them up the inheritance chain, but stopping at BasicImageStripper."

	aCollectionOfSymbols do: 
			[:each |
			| current removed |
			current := self class.
			removed := false.
			[current name == #Object] whileFalse: 
					[(current methodDictionary removeKey: each ifAbsent: []) ifNotNil: [removed := true].
					current := current superclass].
			removed ifFalse: [self notify: self class name , ' hierarchy does not define ' , each printString]].
	Object flushMethodCache!

foldDuplicateBytecodes
	"Private - Eliminate duplicate byte code arrays"

	| byteCodes total |
	self stripDuplicateBytecodes ifFalse: [^self].
	self notify: 'Folding duplicate byte codes'.
	total := 0.
	byteCodes := Set new.
	self allMethodsInClasses: Class allClasses
		do: 
			[:each |
			each isPacked
				ifFalse: 
					[| bytes |
					total := total + 1.
					bytes := each byteCodes.
					byteCodes add: bytes.
					each setByteCodes: (byteCodes find: bytes)]].
	self
		logFold: 'FoldBytecodes'
		folded: total - byteCodes size
		total: total!

foldDuplicateLiterals
	| a |
	self stripDuplicateStrings ifFalse: [^self].
	self notify: 'Folding duplicate strings'.
	a := Class foldLiterals at: #strings.
	self
		logFold: 'FoldStrings'
		folded: a first - a second
		total: a first!

logComment: aString
	self deploymentContext logComment: aString!

logElement: aString attributes: aCollection value: anObject
	self deploymentContext logElement: aString attributes: aCollection value: anObject!

logFold: aString folded: count total: total
	self
		startElement: aString attributes: #();
		logElement: 'Total'
			attributes: #()
			value: total;
		logElement: 'Folded'
			attributes: #()
			value: count;
		endElement: true!

logMethod: aCompiledMethod
	self
		logElement: 'Method'
		attributes: {'methodClass' -> aCompiledMethod methodClass fullName}
		value: aCompiledMethod selector!

messagesSentByClasses: aCollectionOfClasses
	| sent |
	sent := (Set new: aCollectionOfClasses size * 10)
				addAll: self speciallySentMessages;
				yourself.	"presize for an average of 10 unique sends per class"
	self allMethodsInClasses: aCollectionOfClasses
		do: 
			[:eachMethod |
			| selector |
			selector := eachMethod selector.
			eachMethod allSymbolLiteralsDo: 
					[:eachSymbol |
					"Note that self references are now excluded to prevent this particular form of
					 circular reference preventing a method from being stripped"
					eachSymbol == selector ifFalse: [sent add: eachSymbol]]].

	"Add all messages that can be triggered by events"
	_EventsRegister do: [:each | each do: [:mseq | mseq messages do: [:ms | sent add: ms selector]]].
	^sent!

notify: aStringMessage
	self deploymentContext notify: aStringMessage!

notRequiredClasses
	"Answer an <collection> of Classes that are known to be not required and that
	should be forcibly dropped during an image strip. Can be overridden by subclasses 
	to alter the stripping strategy"

	^Set new!

notRequiredMethodCategories
	"Answer an IdentitySet of MethodCategorys whose methods are known to be not required
	and should be forcibly dropped during an image strip. Can be overridden by subclasses to 
	alter the stripping strategy"

	^#()

!

onNotification: aNotification
	self notify: aNotification description!

prepareExternalStructures
	"Private - Fully compile all ExternalStructure subclasses if required. They must already
	have fully defined templates."

	| structs defineFields |
	structs := self externalStructureClasses.
	self defineExternalStructures: structs.
	self startElement: 'PrepareExternalStructures' attributes: #().
	self compileExternalStructures ifTrue: [self compileExternalStructuresNow: structs].
	"Having defined all the templates, we can now remove the methods used to define them"
	structs do: 
			[:each |
			"Access the byteSize to ensure set (important if not compiling external structures)"
			each byteSize].
	"Remove the structure template definition and compiling mechanisms"
	#('compiling' 'template definition') do: 
			[:each |
			self
				removeMethods: (each asMethodCategory methodsInBehavior: External.Structure class)
				reason: 'structure definition: ' , each
				force: true].
	"Remove all Structure defineFields methods"
	defineFields := IdentitySet new.
	structs do: [:each | defineFields add: (each class compiledMethodAt: #defineFields ifAbsent: [])].
	self
		removeMethods: defineFields
		reason: 'structure definition: defineFields'
		force: true.
	self endElement: true.
	self
		finishedWithAll: #(#compileExternalStructures #compileExternalStructuresNow: #defineExternalStructures: #prepareExternalStructures #externalStructureClasses)!

preStripTidy
	"Private - Remove any methods of ImageStripper that are no longer required to ensure these don't impact the calculated package pre-reqs when they are determined"

	self
		finishedWithAll: #(#initialize #notRequiredMethodCategories #stbSaveOn:)!

purgeStubbornClass: aClass
	"Private - Remove what we can of a stubborn class that refuses to uninstall for some reason."

	!

removeCategoryManagement
	"Private - Remove categories information"

	self notify: 'Removing code categories'.
	self
		logElement: 'RemoveCategoryManagement'
		attributes: #()
		value: nil.
	Behavior allSubinstances do: 
			[:each |
			each methodsCatalogue: nil.
			each isMeta
				ifFalse: 
					[each
						classCategories: #();
						sourceDescriptor: nil]].

	"Uninitialize the category management system (don't remove it - it will be removed if unused, depending on stripping options)."
	#(#{Core.Category} #{Core.ClassCategory} #{Core.MethodCategory})
		do: [:each | each ifDefined: [:c | c uninitialize]]!

removeClassBuilder: anArray
	"Private - Remove the ClassBuilder if so configured."

	!

removeClassMetaInfo
	"Private - Remove all (presumably) redundant class info"

	self stripClassInfo
		ifTrue: 
			[| keepInstVars |
			self startElement: 'RemoveClassMetaInfo' attributes: #().
			keepInstVars := self retainInstVarNames.
			Class allClassesDo: 
					[:each |
					| classPool newPool |
					"We used to empty the class pool entirely here, but it is certainly not safe to do that for Namespace classes.
					We now remove all the class vars and clear the environment back pointer."
					classPool := each classPool.
					newPool := classPool class new.
					classPool
						associationsDo: [:var | var isClassVariable ifTrue: [var environment: nil] ifFalse: [newPool add: var]].
					each basicClassPool: newPool.

					"We can't nil out the imports in general, as these are required to resolve BindingReferences that are not fully qualified."

					"each imports: #()."

					"If retaining inst vars, they are collapsed into a string for compactness"
					each instanceVariableString: (keepInstVars ifTrue: [each instanceVariableString])].
			self endTag]!

removeClassUninstallation: aCollection
	"Private - Removal of classes has finished. If the image doesn't have the ClassBuilder in it, 
	remove any uninitializers as they will not be needed."

	self startElement: 'StripClassRemoval' attributes: #().
	(Kernel localBindingFor: 'ClassBuilder')
		ifNil: 
			[self deleteMethods: aCollection.
			"Remove any remaining class uninitialize methods that may be miscategorized"
			Class
				allClassesDo: [:each | self removeSelectors: #('uninitialize' 'uninitializeBeforeRemove') of: each class]]
		ifNotNil: [Notification signal: 'ClassBuilder still present, no action taken'].
	self endElement: true.
	self
		finishedWithAll: #(#addClassesReferencedByClass:to: #addClassesReferencedByMethod:to: #allReferencedClasses #basicDeleteClass: #classesReferencedByMethod: #classReferencesToIgnore #emptyMethodDictionariesOfStubbornClasses #notRequiredClasses #purgeStubbornClass: #deleteClass: #deleteClasses:reason: #removeSelectors:of: #rootClasses #removeClassUninstallation: #stripRedundantClasses #uncheckedDeleteClass:).
	self collectGarbage: 3!

removeDevelopmentInfo
	"Private - Remove development structures, etc."

	self startElement: 'StripDevelopmentInfo' attributes: #().
	self removeCategoryManagement.
	self removeProtocolManagement.
	#{SmalltalkSystem} ifDefined: [:smsys | smsys reset].
	Class allSubinstances do: 
			[:b |
			b removePropertyAt: #changeIndex ifAbsent: [].
			"Remove all source references (may be LargeIntegers)"
			b methodDictionary do: [:m | m sourceDescriptor: nil].
			b class methodDictionary do: [:m | m sourceDescriptor: nil]].
	self collectGarbage: 3.
	self endElement: true.
	self finishedWithAll: #(#removeCategoryManagement #removeProtocolManagement)!

removeDevelopmentResources
	"Private - Remove development classes resources. We can't actually remove the classes themselves yet since some are required by the remainder of the stripping process. 
	By removing the resources we give the class/method strip that follows the best chance of isolating redundant items."

	self deleteResources: self developmentResources reason: 'development'.
	self finishedWithAll: #(#developmentResources)!

removeDevelopmentSystemResidue
	"Private - Remove all the development stuff that we can."

	"First Remove development classes resources. We can't actually remove the
	classes themselves yet since some are required by the remainder of the 
	stripping process. By removing the resources we give the  class/method strip
	that follows the best chance of isolating redundant items"

	self removeDevelopmentResources.

	"Before attempting to remove any classes, clear away any development instances and refs"
	self removeDevelopmentInfo.
	self removePackageManagement.
	self removeNotRequiredClasses.
	self
		finishedWithAll: #(#removeDevelopmentResources #removeDevelopmentInfo #removePackageManagement #removeNotRequiredClasses)!

removeGuiForConsoleApplication
	"Private - A console application is being deployed, so uninitialize parts of the GUI system
	that will allow the entire View hierarchy, etc, to be removed."

	self startElement: 'StripConsoleApplication' attributes: #().
	#(#{Kernel.ImageRelativeFileLocator} #{Kernel.InstallRelativeFileLocator})
		do: [:each | each ifDefined: [:class | class uninitialize]].
	#{UI.View} isDefined ifFalse: [VM unregisterObject: #wndProc:message:wParam:lParam:cookie:].
	self collectGarbage: 3.
	self endElement: true!

removeMethods: aCollection reason: aString force: aBoolean
	"Private - Removes the <collection> of <CompiledMethod>s, methods, from the image."

	| toRemove |
	toRemove := aBoolean
				ifTrue: [aCollection]
				ifFalse: [aCollection reject: [:each | self shouldPreserveMethod: each]].
	toRemove isEmpty ifTrue: [^0].
	self startElement: 'StripMethods' attributes: {'reason' -> aString}.
	self deleteMethods: toRemove.
	self endElement: true.
	^toRemove size!

removeNotRequiredClasses
	"Private - Strip the classes that are explicitly listed as not being required,
	but only if the 'strip redundant classes' option was selected."

	self deleteClasses: self notRequiredClasses reason: 'not required'!

removeNotRequiredMethods
	"Private - Strip the methods that must be removed due to membership of one of
	the special 'must strip' categories. Note that we collect all first before removing
	any to avoid any problems caused by the categories being out of date with
	respect to the actual selectors in the class."

	"This method must be run BEFORE package pre-requisites are calculated in order to
	be sure that all methods causing undesirable dependencies are removed first."

	| notRequired |
	self notify: 'Removing methods that are not required or which must be stripped'.
	self startElement: 'ForcedStripMethods' attributes: #().
	notRequired := self notRequiredMethodCategories
				collect: [:category | {category. category asMethodCategory methods}].
	self stripClassInitializers
		ifTrue: 
			[| initializers mustkeep |
			initializers := Set new.
			mustkeep := 'must not strip' asMethodCategory.
			Class allClasses do: 
					[:each |
					(each class compiledMethodAt: #initialize ifAbsent: [])
						ifNotNil: [:method | (mustkeep includesMethod: method) ifFalse: [initializers add: method]]].
			notRequired add: {'class initializers'. initializers}].
	notRequired do: 
			[:pair |
			| methods |
			methods := pair at: 2.
			methods size > 0
				ifTrue: 
					["We don't go through #removeMethods:notifying:, since we want the packages to be updated to reflect the lost methods so that when their pre-requisites are recalculated the removed methods do not affect the result."
					self startElement: 'StripMethods' attributes: {'reason' -> (pair at: 1)}.
					(methods asSortedCollection: 
							[:a :b |
							a methodClass name < b methodClass name
								or: [a methodClass == b methodClass and: [a selector < b selector]]])
						do: 
							[:each |
							self logMethod: each.
							each methodClass removeSelector: each selector ifAbsent: []].
					self endElement: true.
					self]].
	self endElement: true.
	self preStripTidy!

removePackageManagement
	"Private - Remove packages structure."

	| methods |
	self startElement: 'StripPackageManagement' attributes: #().
	self systemPackageManager class reset.
	"Note that we must leave the #owningPackage definition in ClassDescription for potential runtime STB use"
	methods := Set new.
	#(#{PoolDictionary} #{ResourceIdentifier} #{CompiledMethod})
		do: [:each | each ifDefined: [:class | methods add: (class compiledMethodAt: #owningPackage ifAbsent: [])]].
	self
		removeMethods: methods
		reason: 'package management'
		force: true.
	self finishedWithAll: #(#systemPackageManager).
	self endElement: true!

removeProtocolManagement
	"Private - Remove protocol information. Note that only the MethodProtocol objects
	themselves are removed, not the list of protocol names stored in each
	class."

	self
		logElement: 'RemoveMethodProtocols'
		attributes: #()
		value: nil.
	#{Kernel.MethodProtocol} ifDefined: [:p | p initializeProtocols]!

removeRedundantClassesAndResources: stripResources
	"Private - Removes redundant classes from the current image. A redundant class is one
	that has no current instances in the image and is not referenced by any of the root classes
	of the receiver. Answer the number of classes that were actually removed."

	| referencedClasses count msg |
	self stripRedundantClasses ifFalse: [^0].
	count := 0.

	"Find classes that are redundant"
	msg := 'Removing redundant classes'.
	stripResources ifTrue: [msg := msg , ' and resources'].
	self notify: msg , '…'.
	self collectGarbage: 3.
	referencedClasses := self allReferencedClasses.
	stripResources ifTrue: [count := count + (self removeRedundantResources: referencedClasses)].
	^count
		+ (self deleteClasses: (Class allClasses difference: referencedClasses) reason: 'unreferenced')!

removeRedundantMethods
	"Private - Removes redundant methods from the pseudo image.
	Answers the count of methods stripped"

	^0!

removeRedundantMethodsOnceFrom: aCollectionOfClasses
	"Private - Removes redundant methods from the pseudo image.
	Answers the count of methods stripped"

	| redundantMessages redundantMethods sent implemented |
	self stripRedundantMethods ifFalse: [^0].
	self notify: 'Removing redundant methods…'.
	self collectGarbage: 1.
	sent := self messagesSentByClasses: aCollectionOfClasses.
	implemented := Set new: aCollectionOfClasses size * 12.
	self allMethodsInClasses: aCollectionOfClasses do: [:each | implemented add: each selector].
	redundantMessages := implemented difference: sent.
	redundantMessages isEmpty ifTrue: [^0].
	redundantMethods := OrderedCollection new.
	self allMethodsInClasses: aCollectionOfClasses
		do: [:each | (redundantMessages includes: each selector) ifTrue: [redundantMethods addLast: each]].
	^self
		removeMethods: redundantMethods
		reason: 'unsent'
		force: false!

removeRedundantObjects: stripResources id: anInteger
	"Cycle around removing redundant classes and methods until all remaining
	classes and methods appear to be required to complete the deployed image."

	
	[| continue |
	self startElement: 'StripCycle' attributes: {'id' -> anInteger}.
	continue := (self
				removeRedundantClassesAndResources: (stripResources and: [self shouldRemoveResources]))
					+ self removeRedundantMethods > 0.
	self endElement: continue.
	continue]
			whileTrue!

removeRedundantPackages
	"Private - Strips the unwanted packages from the image."

	| redundantPackages required pacman |
	[required := self verifyRequiredPackages] on: Warning
		do: 
			[:warning |
			warning resume: (User32
						messageBox: nil
						lpText: warning description
						lpCaption: SessionManager current applicationName
						uType: ##(OS.MessageBoxConstants.MB_OK | OS.MessageBoxConstants.MB_TASKMODAL
								| OS.MessageBoxConstants.MB_SETFOREGROUND))].
	self stripRedundantPackages ifFalse: [^required].
	pacman := self systemPackageManager.
	redundantPackages := pacman packages asSet difference: required.
	"Turn off events to prevent repeated tracing of pre-reqs as each of the redundant packages
	 is uninstalled."
	pacman beNotProcessingEvents.
	"We don't want to uninstall the DevelopmentSessionManager until it has been replaced by the run-time session manager"
	pacman addClass: SessionManager current class to: nil.
	self startElement: 'RedundantPackages' attributes: #().
	(redundantPackages asSortedCollection: [:a :b | a name < b name]) do: 
			[:each |
			self
				logElement: 'Package'
				attributes: #()
				value: each].
	self endElement: true.
	self notify: 'Removing unwanted packages'.
	self startElement: 'StripPackages' attributes: #().
	[redundantPackages do: 
			[:each |
			pacman uninstall: each.
			self collectGarbage: 2]]
		on: ClassBuilder invalidRemoveError
		do: 
			[:e |
			self onNotification: e.
			self purgeStubbornClass: e tag.
			e resume: true].	"Remove classes regardless"
	self endElement: true.
	pacman beProcessingEvents.
	^required!

removeRedundantResources: referencedClasses
	^0
	!

removeSelectors: aCollectionOfSelectors of: aBehavior
	| methods |
	methods := Set new.
	aCollectionOfSelectors do: 
			[:each |
			(aBehavior compiledMethodAt: each asSymbol ifAbsent: []) ifNotNil: [:method | methods add: method]].
	self
		removeMethods: methods
		reason: 'explicit'
		force: true!

retainInstVarNames
	"Answer whether the stripping process should preserve instance variable names.
	Normally these are not required unless certain reflective messages are used."

	^true!

rootClasses
	^#()!

shouldPreserveMethod: aCompiledMethod
	^true!

shouldRemoveResources
	^self stripRedundantResources!

shrinkEventsOf: anObject
	anObject setEvents: (anObject getEvents ifNotNil: [:subs | subs shrink asMinimumRepresentation])!

shrinkEventsRegister
	_EventsRegister keys do: [:each | self shrinkEventsOf: each].
	self shrinkEventsOf: SessionManager current!

speciallySentMessages
	"Private - A number of messages can be sent without  appearing in the literal
	frame of any method. Answer a Set of these selectors here."

	^Set withAll: (VM registry select: [:each | each class == Symbol])!

startElement: aString attributes: aCollectionOfAttributes
	self deploymentContext startElement: aString attributes: aCollectionOfAttributes!

stbSaveOn: anSTBOutFiler
	"Output the receiver to anSTBOutFiler. We must ensure that the local events collection
	is NOT saved to the filer"

	anSTBOutFiler override: events with: nil.
	super stbSaveOn: anSTBOutFiler.!

stripClassBuilder
	^false!

stripClassInfo
	"Answer true if the stripping process will remove class information such as instance variable names, pools names and comments"

	^false!

stripClassInitializers
	"Answer whether class-side initialize methods should be removed. By convention these are assumed to be used to initialize classes only as they are loaded, and therefore should not be required in a deployed application."

	^self stripRedundantMethods!

stripDuplicateBytecodes
	"Answer true if the stripping process will fold instances of duplicate byte code arrays 
	into one common instance"

	^false!

stripDuplicateStrings
	"Answer true if the stripping process will fold instances of duplicate strings
	into one common instance"

	^false!

stripRedundantClasses
	"Answer true if the receiver will attempt to remove redundant classes not
	required in the deployed application."

	^false!

stripRedundantMethods
	"Answer true if the receiver will attempt to remove methods that will not be
	referenced in the deployed application."

	^false!

stripRedundantPackages
	"Answer true if the receiver will attempt to remove redundant packages not
	referenced from a root package during its stripping process."

	^false!

stripRedundantResources
	"Answer true if the receiver will attempt to remove resources that are not required in the
	deployed application."

	^false!

systemPackageManager
	"Private - Answer the package manager to be used by the receiver.
	N.B. All references to PackageManager must be through this accessor
	to prevent the PackageManager and Package classes remaining in the
	deployed image."

	^(#{Kernel.Package} valueOrNil ?? DeafObject current) manager!

uncheckedDeleteClass: aClass
	| removed |
	removed := aClass allSubclasses inject: 0 into: [:sum :each | sum + (self deleteClass: each)].	"First remove subclasses"
	"Remove any nested classes"
	aClass bindingsDo: 
			[:each |
			| value |
			(each isClassVariable not and: 
					[value := each value.
					value class isMeta and: [value environment == aClass]])
				ifTrue: [removed := removed + (self deleteClass: value)]].
	self
		logElement: 'RemoveClass'
		attributes: #()
		value: aClass fullName.
	^
	[self basicDeleteClass: aClass.
	aClass clearGuid.
	removed + 1] on: Error
			do: 
				[:ex |
				self deploymentContext logStrippingError: ex.
				aClass primAllInstances do: [:each | Notification signal: each printString].
				self purgeStubbornClass: aClass.
				removed]!

verifyRequiredPackages
	"Private - Answer the <collection> of <Package>s to be included in the deployed application, verifying that they are deployable."

	| packages |
	packages := self actualRequiredPackages.
	packages do: [:each | each okToSaveOrDeploy].
	^packages! !
!BasicImageStripper categoriesForMethods!
actualRequiredPackages!private! !
allMethodsInClasses:do:!helpers!private! !
allReferencedClasses!operations!private! !
basicDeleteClass:!helpers!private! !
basicDeleteMethod:!private!removing! !
collectGarbage:!operations!private! !
compileExternalStructures!public!testing! !
compileExternalStructuresNow:!operations!private! !
defineExternalStructures:!operations!private! !
deleteClass:!helpers!private! !
deleteClasses:reason:!operations!private! !
deleteFieldClasses!operations!private! !
deleteMethod:!private!removing! !
deleteMethods:!private!removing! !
deleteMethodSoft:!private!removing! !
deleteResource:!operations!private! !
deleteResources:reason:!operations!private! !
deploymentContext!accessing!private! !
destroyAndRemoveProgress!operations!private! !
destroyNotifier!operations!private! !
detachClass:!helpers!private! !
developmentResources!accessing!public! !
emptyMethodDictionariesOfStubbornClasses!public!testing! !
emptySystemDictionary!operations!private! !
endElement:!logging!private! !
endTag!logging!private! !
externalStructureClasses!accessing!private! !
finishedWithAll:!operations!private! !
foldDuplicateBytecodes!operations!private! !
foldDuplicateLiterals!operations!private! !
logComment:!logging!private! !
logElement:attributes:value:!logging!private! !
logFold:folded:total:!operations!private! !
logMethod:!operations!private! !
messagesSentByClasses:!helpers!private! !
notify:!logging!private! !
notRequiredClasses!configuration!public! !
notRequiredMethodCategories!configuration!public! !
onNotification:!event handling!private! !
prepareExternalStructures!operations!private! !
preStripTidy!operations!private! !
purgeStubbornClass:!operations!private! !
removeCategoryManagement!operations!private! !
removeClassBuilder:!operations!private! !
removeClassMetaInfo!operations!private! !
removeClassUninstallation:!operations!private! !
removeDevelopmentInfo!operations!private! !
removeDevelopmentResources!operations!private! !
removeDevelopmentSystemResidue!operations!private! !
removeGuiForConsoleApplication!operations!private! !
removeMethods:reason:force:!private!removing! !
removeNotRequiredClasses!operations!private! !
removeNotRequiredMethods!operations!private! !
removePackageManagement!operations!private! !
removeProtocolManagement!operations!private! !
removeRedundantClassesAndResources:!operations!private! !
removeRedundantMethods!operations!private! !
removeRedundantMethodsOnceFrom:!operations!private! !
removeRedundantObjects:id:!operations!private! !
removeRedundantPackages!operations!private! !
removeRedundantResources:!operations!private! !
removeSelectors:of:!operations!private! !
retainInstVarNames!public!testing! !
rootClasses!accessing!private! !
shouldPreserveMethod:!private!removing! !
shouldRemoveResources!private!testing! !
shrinkEventsOf:!operations!private! !
shrinkEventsRegister!helpers!private! !
speciallySentMessages!configuration!private! !
startElement:attributes:!logging!private! !
stbSaveOn:!binary filing!public! !
stripClassBuilder!public!testing! !
stripClassInfo!public!testing! !
stripClassInitializers!public!testing! !
stripDuplicateBytecodes!public!testing! !
stripDuplicateStrings!public!testing! !
stripRedundantClasses!public!testing! !
stripRedundantMethods!public!testing! !
stripRedundantPackages!public!testing! !
stripRedundantResources!public!testing! !
systemPackageManager!accessing!private! !
uncheckedDeleteClass:!helpers!private! !
verifyRequiredPackages!accessing!private! !
!

BasicImageStripper methodProtocol: #model attributes: #(#readOnly) selectors: #()!

!BasicImageStripper class methodsFor!

new
	^super new initialize!

stbConvertFrom: anSTBClassFormat
	"Private - Convert from previous version resource. 
	Version Changes:
		1: Added 'events' instance variable to Model."

	^
	[:data |
	| answer instVars |
	instVars := anSTBClassFormat version < 1
				ifTrue: 
					[| c |
					c := data size + 1.
					(Array new: c)
						replaceFrom: 2
							to: c
							with: data
							startingAt: 1;
						yourself]
				ifFalse: [data].
	answer := self basicNew.
	1 to: instVars size do: [:i | answer instVarAt: i put: (instVars at: i)].
	answer]!

stbVersion
	"Answer the current binary filer version number for instances of the receiver."

	^1! !
!BasicImageStripper class categoriesForMethods!
new!development!instance creation!public! !
stbConvertFrom:!binary filing!development!private! !
stbVersion!binary filing!development!public! !
!

