"
Batter used in the playground field to move ball
"
Class {
	#name : 'BlBatterElement',
	#superclass : 'BlElement',
	#instVars : [
		'speed'
	],
	#category : 'BlBreakOut-Core',
	#package : 'BlBreakOut',
	#tag : 'Core'
}

{ #category : 'sizes' }
BlBatterElement >> enlarge [

	self requestedExtent <= self parent defaultBatterSize ifTrue: [
		self extent: self requestedExtent * (2 @ 1) ]
]

{ #category : 'feedback' }
BlBatterElement >> flash [
	"Make the receiver blink, as a visual feedback"

	self opacity: 0.3.
	self addAnimation: (BlOpacityAnimation new
			 opacity: 1;
			 duration: 200 milliSeconds)
]

{ #category : 'initialization' }
BlBatterElement >> initialize [

	super initialize.
	self
		geometry: (BlRoundedRectangleGeometry cornerRadius: 8);
		extent: 50 @ 10;
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

{ #category : 'sizes' }
BlBatterElement >> normalSize [

	self extent: self parent defaultBatterSize
]

{ #category : 'initialization' }
BlBatterElement >> positionAtStart [

	| position center bottom |
	position := parent extent.
	center := position x / 2.
	bottom := position y.
	self position: (center @ bottom - self extent y - 5)
]

{ #category : 'sizes' }
BlBatterElement >> shrink [

	self requestedExtent > (self parent defaultBatterSize / 2) ifTrue: [
		self extent: self requestedExtent * (0.5 @ 1) ]
]

{ #category : 'moves' }
BlBatterElement >> touchedBy: aBall [

	| d y x directionSign center |
	self flash.
	center := self position x + (self width / 2).
	d := (center - aBall position x) abs * 2 / self width.
	y := (d squared / 2 + 2) sqrt.
	x := d.
	
	directionSign := center - aBall position x > 0
		                 ifTrue: [ -1 @ 1 ]
		                 ifFalse: [ 1 @ 1 ].

	aBall direction: x @ y * directionSign.
	aBall bounceTopBottom
]

{ #category : 'moves' }
BlBatterElement >> xToMoveLeft [

	^ speed min: self position x - 0
]

{ #category : 'moves' }
BlBatterElement >> xToMoveRight [
	"Return the x so that the receiver can move to the right without existing the field"

	^ speed min:  parent extent x - (self position x + self extent x)
]
