Class {
	#name : 'BlBatterElement',
	#superclass : 'BlElement',
	#instVars : [
		'speed'
	],
	#category : 'BlBreakOut',
	#package : 'BlBreakOut'
}

{ #category : 'initialization' }
BlBatterElement >> initialize [

	super initialize.
	self
		geometry: (BlRoundedRectangleGeometry cornerRadius: 8);
		size: 50 @ 10;
		background: (Color blue alpha: 0.6);
		border: (BlBorder paint:  (Color blue alpha: 0.8) width: 1).
	speed := 15
]

{ #category : 'moves' }
BlBatterElement >> moveLeft [

	self position: self position - (self xToMoveLeft @0)
]

{ #category : 'moves' }
BlBatterElement >> moveRight [

	self position: self position + (self xToMoveRight @ 0)
]

{ #category : 'initialization' }
BlBatterElement >> positionAtStart [

	| position center bottom |
	position := parent extent.
	center := position x / 2.
	bottom := position y.
	self position: (center @ bottom - self extent y - 5)
]

{ #category : 'moves' }
BlBatterElement >> xToMoveLeft [
^ speed min: (self position x - 0)

]

{ #category : 'moves' }
BlBatterElement >> xToMoveRight [
	"Return the x so that the receiver can move to the right without existing the field"

	^ speed min:  parent extent x - (self position x + self extent x)
]
