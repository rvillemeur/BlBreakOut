"
I'm a bonus to shrink the batter
"
Class {
	#name : 'BatterShrinker',
	#superclass : 'Bonus',
	#category : 'BlBreakOut-Core',
	#package : 'BlBreakOut',
	#tag : 'Core'
}

{ #category : 'computation' }
BatterShrinker class >> percentage [

	^ 0.05
]

{ #category : 'accessing' }
BatterShrinker >> end: aField [

	super end: aField.
	aField batter normalSize
]

{ #category : 'accessing' }
BatterShrinker >> start: aField [

	super start: aField.
	aField batter shrink
]
