﻿"Filed out from Dolphin Smalltalk"!

Refactory.Browser.Tests.RefactoringTest subclass: #'Refactory.Browser.Tests.RemoveClassVariableTest'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
Refactory.Browser.Tests.RemoveClassVariableTest guid: (Core.GUID fromString: '{0c64e4ad-979f-4e25-9c48-f1adeebc74b6}')!
Refactory.Browser.Tests.RemoveClassVariableTest comment: ''!
!Refactory.Browser.Tests.RemoveClassVariableTest categoriesForClass!Refactory-Testing! !
!Refactory.Browser.Tests.RemoveClassVariableTest methodsFor!

testNonExistantName
	self shouldFail: (RemoveClassVariableRefactoring variable: #RecursiveSelfRule1
				class: TransformationRuleTest)!

testReferencedVariable
	self shouldFail: (RemoveClassVariableRefactoring variable: #RecursiveSelfRule
				class: TransformationRuleTest)!

testRemoveClassVar
	| refactoring class |
	refactoring := RemoveClassVariableRefactoring variable: 'Foo1' class: LintRuleTest.
	class := refactoring model classNamed: #'Refactory.Browser.Tests.LintRuleTest'.
	self assert: (class definesClassVariable: 'Foo1').
	self executeRefactoring: refactoring.
	self deny: (class definesClassVariable: 'Foo1')! !
!Refactory.Browser.Tests.RemoveClassVariableTest categoriesForMethods!
testNonExistantName!failure tests!public! !
testReferencedVariable!failure tests!public! !
testRemoveClassVar!public!tests! !
!

