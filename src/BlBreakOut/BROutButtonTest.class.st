Class {
	#name : 'BROutButtonTest',
	#superclass : 'TestCase',
	#category : 'BlBreakOut-Tests',
	#package : 'BlBreakOut',
	#tag : 'Tests'
}

{ #category : 'tests' }
BROutButtonTest >> testBROutButtonClick [

	| element count |
	count := 0.

	element := BROutExample sampleStandaloneButton action: [
		           count := count + 1 ].

	BlSpace simulateClickOn: element.
	
	self assert: element label text asString equals: 'example'.
	self assert: count equals: 1
]
