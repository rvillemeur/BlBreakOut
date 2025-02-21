"
Base class to add bonuses to the game
"
Class {
	#name : 'Bonus',
	#superclass : 'Object',
	#instVars : [
		'duration',
		'timeLeft'
	],
	#category : 'BlBreakOut-Core',
	#package : 'BlBreakOut',
	#tag : 'Core'
}

{ #category : 'computation' }
Bonus class >> percentage [

	^ 0.2
]

{ #category : 'accessing' }
Bonus >> end: aField [

	aField bonusTerminated: self
]

{ #category : 'initialization' }
Bonus >> initialize [
	"initialize is not defined on Object so we do not do a super initialize"

	duration := 10
]

{ #category : 'as yet unclassified' }
Bonus >> oneStep: aField [

	timeLeft := timeLeft - 1.
	timeLeft isZero ifTrue: [ self end: aField ]
]

{ #category : 'accessing' }
Bonus >> start: aField [

	timeLeft := duration
]
