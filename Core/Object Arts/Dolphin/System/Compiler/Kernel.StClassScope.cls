﻿"Filed out from Dolphin Smalltalk"!

Kernel.StSemanticScope subclass: #'Kernel.StClassScope'
	instanceVariableNames: 'methodClass environment instanceVariables selfVariable superVariable'
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
Kernel.StClassScope guid: (Core.GUID fromString: '{b221d07f-4ae8-400c-b48e-28b90fca0050}')!
Kernel.StClassScope comment: ''!
!Kernel.StClassScope categoriesForClass!Kernel-Objects! !
!Kernel.StClassScope methodsFor!

environment
	^environment!

environment: aNamespace
	environment := aNamespace!

lookupVariable: anStVariableNode
	"Lookup and return an <StVariable> describing the variable definition in this scope matching
	the variable reference specified by the <StVariableNode> argument."

	| identifier |
	identifier := anStVariableNode name.
	anStVariableNode isSpecialVariable ifTrue: [^anStVariableNode specialVariableInScope: self].
	instanceVariables isNil
		ifTrue: 
			[instanceVariables := LookupTable new: 5.
			methodClass allInstVarNames keysAndValuesDo: 
					[:i :v |
					instanceVariables at: v
						put: ((StInstanceVariable index: i name: v)
								scope: self;
								yourself)]].
	^(instanceVariables lookup: identifier)
		ifNil: 
			[(methodClass fullBindingFor: identifier environment: environment)
				ifNotNil: [:b | StStaticVariable scope: self binding: b]]!

methodClass
	^methodClass!

selfVariable
	^selfVariable
		ifNil: 
			[selfVariable := StSelfVariable new
						scope: self;
						yourself]!

setMethodClass: aClassDescription environment: aNamespace
	methodClass := aClassDescription.
	environment := aNamespace!

superVariable
	^superVariable
		ifNil: 
			[superVariable := StSuperVariable new
						scope: self;
						yourself]! !
!Kernel.StClassScope categoriesForMethods!
environment!public! !
environment:!accessing!public! !
lookupVariable:!operations!public! !
methodClass!accessing!public! !
selfVariable!operations!public! !
setMethodClass:environment:!accessing!initializing!private! !
superVariable!operations!public! !
!

!Kernel.StClassScope class methodsFor!

methodClass: aClassDescription environment: aNamespace
	^self new setMethodClass: aClassDescription environment: aNamespace! !
!Kernel.StClassScope class categoriesForMethods!
methodClass:environment:!instance creation!public! !
!

