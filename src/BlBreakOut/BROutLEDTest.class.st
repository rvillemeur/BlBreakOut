Class {
	#name : 'BROutLEDTest',
	#superclass : 'TestCase',
	#category : 'BlBreakOut-Test',
	#package : 'BlBreakOut',
	#tag : 'Test'
}

{ #category : 'tests' }
BROutLEDTest >> testBROutButtonClick [

	| element count |
	count := 0.

	element := BROutLEDText new.
	self assert: element label text asString equals: '1234567890'.
	element textPadding: 5;label: '500'.
	self assert: element label text asString equals: '00500'.
	element textPadding: 10;label: '6543'.
	self assert: element label text asString equals: '0000006543'.
	
]
