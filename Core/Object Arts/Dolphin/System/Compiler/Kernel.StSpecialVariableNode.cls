﻿"Filed out from Dolphin Smalltalk"!

Kernel.StAbstractVariableNode subclass: #'Kernel.StSpecialVariableNode'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
Kernel.StSpecialVariableNode guid: (Core.GUID fromString: '{e1481f19-627f-4ee4-9c94-e58a0d603fe6}')!
Kernel.StSpecialVariableNode isNonInstantiable: true!
Kernel.StSpecialVariableNode comment: 'StSpecialVariableNode is an abstract parse tree node with subclasses to represent each of the special variables ''self'', ''super'' or ''thisContext''. All are constants.
'!
!Kernel.StSpecialVariableNode categoriesForClass!System-Compiler! !
!Kernel.StSpecialVariableNode methodsFor!

acceptVisitor: aProgramNodeVisitor
	^aProgramNodeVisitor visitSpecialVariableNode: self!

isConstantNode
	"Answer whether the receiver describes a constant that cannot be assigned to. All special
	variables are constants."

	^true!

isSpecialVariable
	"Answer whether the variable described by the receiver is one of the special (aka pseudo) variables 'self', 'super' or 'thisContext'."

	^true!

specialVariableInScope: anStSemanticScope
	^self subclassResponsibility! !
!Kernel.StSpecialVariableNode categoriesForMethods!
acceptVisitor:!public!visitor! !
isConstantNode!public!testing! !
isSpecialVariable!public!testing! !
specialVariableInScope:!double dispatch!public! !
!

!Kernel.StSpecialVariableNode class methodsFor!

start: anInteger
	^(self new)
		setStart: anInteger;
		yourself! !
!Kernel.StSpecialVariableNode class categoriesForMethods!
start:!public! !
!

