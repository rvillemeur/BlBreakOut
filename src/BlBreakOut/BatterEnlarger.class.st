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
| batter |
super start: aField.
batter := aField batter.
batter enlarge.
batter right > aField right
ifTrue: [batter position: (aField right - batter extent x)@batter position y]
]
