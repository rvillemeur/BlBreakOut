Class {
	#name : 'BlBreakoutFieldTest',
	#superclass : 'TestCase',
	#category : 'BlBreakOut-Core',
	#package : 'BlBreakOut',
	#tag : 'Core'
}

{ #category : 'as yet unclassified' }
BlBreakoutFieldTest >> testbrickDesccriptionAtColumnRow [

	| b |
	b := BlBreakoutField new.
	self assert: (b brickDesccriptionAtColumn: 1 row: 1) equals: 1.
	self assert: (b brickDesccriptionAtColumn: 2 row: 1) equals: 2.
	self assert: (b brickDesccriptionAtColumn: 1 row: 2) equals: 10.
	self assert: (b brickDesccriptionAtColumn: 1 row: 3) equals: 19.
	self assert: (b brickDesccriptionAtColumn: 8 row: 2) equals: 17.
	self
		assert:
		(BlBreakoutField level0 at: (b brickDesccriptionAtColumn: 8 row: 3))
		equals: $S
]
