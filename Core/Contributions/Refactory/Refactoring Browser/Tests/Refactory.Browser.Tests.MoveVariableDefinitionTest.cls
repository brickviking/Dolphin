﻿"Filed out from Dolphin Smalltalk"!

Refactory.Browser.Tests.RefactoringTest subclass: #'Refactory.Browser.Tests.MoveVariableDefinitionTest'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
Refactory.Browser.Tests.MoveVariableDefinitionTest guid: (Core.GUID fromString: '{dc2344f4-f0f3-4fc5-af74-d852d5d036ae}')!
Refactory.Browser.Tests.MoveVariableDefinitionTest comment: ''!
!Refactory.Browser.Tests.MoveVariableDefinitionTest categoriesForClass!Refactory-Testing! !
!Refactory.Browser.Tests.MoveVariableDefinitionTest methodsFor!

testMoveDefinition
	| refactoring |
	refactoring := MoveVariableDefinitionRefactoring
				bindTight: (self convertInterval: (19 to: 22)
						for: (RefactoryTestDataApp sourceCodeAt: #moveDefinition))
				in: RefactoryTestDataApp
				selector: #moveDefinition.
	self executeRefactoring: refactoring.
	self assert: ((refactoring model classNamed: #'Refactory.Browser.Tests.RefactoryTestDataApp')
				parseTreeFor: #moveDefinition)
		equals: (RBParser
				parseMethod: 'moveDefinition
								^(self collect: 
										[:each | 
										| temp |
										temp := each printString.
										temp , temp]) 
									select: 
										[:each | 
										| temp |
										temp := each size.
										temp odd]')!

testMoveDefinitionIntoBlockThatIsAReceiverOfACascadedMessage
	| refactoring |
	refactoring := MoveVariableDefinitionRefactoring
				bindTight: (self convertInterval: (48 to: 58)
						for: (RefactoryTestDataApp sourceCodeAt: #referencesConditionFor:))
				in: RefactoryTestDataApp
				selector: #referencesConditionFor:.
	self executeRefactoring: refactoring.
	self assert: ((refactoring model classNamed: #'Refactory.Browser.Tests.RefactoryTestDataApp')
				parseTreeFor: #referencesConditionFor:)
		equals: (RBParser
				parseMethod: 'referencesConditionFor: aClass 
								| environment  |
								^(RBCondition withBlock: 
										[| association |association := Smalltalk associationAt: aClass name
													ifAbsent: [self refactoringError: ''Could not find class''].
										environment := (self environment referencesTo: association) 
													| (self environment referencesTo: aClass name).
										environment isEmpty])
									errorMacro: aClass , '' is referenced.<n>Browse references?'';
									errorBlock: [environment openEditor];
									yourself')!

testNoMoveDefinition
	self shouldFail: (MoveVariableDefinitionRefactoring
				bindTight: (self convertInterval: (21 to: 24)
						for: (RefactoryTestDataApp sourceCodeAt: #moveDefinition))
				in: RefactoryTestDataApp
				selector: #noMoveDefinition)!

testNonExistantName
	| aRefactoring |
	self
		shouldFail: (MoveVariableDefinitionRefactoring
					bindTight: (1 to: 10)
					in: LintRuleTest
					selector: #name1);
		shouldFail: (MoveVariableDefinitionRefactoring
					bindTight: (self convertInterval: (44 to: 54) for: (LintRuleTest sourceCodeAt: #displayName))
					in: LintRuleTest
					selector: #displayName).
	"This isn't a test of a non-existant name, but of a move that is already as tightly bound as possible"
	aRefactoring := MoveVariableDefinitionRefactoring
				bindTight: (self convertInterval: (16 to: 25) for: (LintRuleTest sourceCodeAt: #displayName))
				in: LintRuleTest
				selector: #displayName.
	self proceedThroughWarning: 
			[self should: [self executeRefactoring: aRefactoring] raise: Refactoring abortSignal]! !
!Refactory.Browser.Tests.MoveVariableDefinitionTest categoriesForMethods!
testMoveDefinition!public!tests! !
testMoveDefinitionIntoBlockThatIsAReceiverOfACascadedMessage!public!tests! !
testNoMoveDefinition!public!tests! !
testNonExistantName!public!tests! !
!

