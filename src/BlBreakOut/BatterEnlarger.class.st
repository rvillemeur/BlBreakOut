"
I'm a bonus to enlarge the batter
"
Class {
	#name : 'BatterEnlarger',
	#superclass : 'Bonus',
	#category : 'BlBreakOut-Core',
	#package : 'BlBreakOut',
	#tag : 'Core'
}

{ #category : 'accessing' }
BatterEnlarger >> end: aField [

	super end: aField.
	aField batter normalSize
]

{ #category : 'accessing' }
BatterEnlarger >> start: aField [

	| batter width |
	super start: aField.
	batter := aField batter.
	batter enlarge.
	width := batter requestedExtent x.
	batter position x + width > aField width ifTrue: [
		batter position: aField width - width @ batter position y ]
]
