"
Initial test:

```smalltalk
BlBallElement new openInNewSpace
```
"
Class {
	#name : 'BlBallElement',
	#superclass : 'BlElement',
	#instVars : [
		'speed',
		'direction',
		'animation'
	],
	#category : 'BlBreakOut-Core',
	#package : 'BlBreakOut',
	#tag : 'Core'
}

{ #category : 'animation' }
BlBallElement >> animation [

	^ [
	  [ true ] whileTrue: [
		  parent moveBall.
		  (1 / 40) seconds asDelay wait ] ] forkAt: Processor lowestPriority
]

{ #category : 'positioning' }
BlBallElement >> bounceLeftRight [
	"Make the ball bouncing on an vertical surface by changing its direction"

	direction := direction * (-1 @ 1).
	self moveToNextPosition
]

{ #category : 'positioning' }
BlBallElement >> bounceTopBottom [
	"Make the ball bouncing on an horizontal surface by changing its direction"

	direction := direction * (1 @ -1).
	self moveToNextPosition
]

{ #category : 'accessing' }
BlBallElement >> direction [

	^ direction
]

{ #category : 'accessing' }
BlBallElement >> direction: aPoint [

	direction := aPoint
]

{ #category : 'initialization' }
BlBallElement >> initialize [

	super initialize.
	self
		geometry: (BlCircleGeometry new matchExtent: 9 @ 9);
		size: 9 @ 9;
		background: Color yellow;
		border: (BlBorder paint: Color black width: 1).
	speed := 3.
	direction :=  -1 @  -1.
	animation := self animation.
]

{ #category : 'testing' }
BlBallElement >> isNextPosition: aPoint above: aRectangle [

	^ aPoint y - 4 < aRectangle top
]

{ #category : 'testing' }
BlBallElement >> isNextPosition: aPoint below: aRectangle [

	^ aPoint y + 4 >= aRectangle bottom
]

{ #category : 'testing' }
BlBallElement >> isNextPosition: aPoint verticallyInside: aRectangle [
	"Return true whether the next position is to the right of the rectangle"

	| xOfNextPosition |
	xOfNextPosition := aPoint x.
	^ xOfNextPosition + 4 > aRectangle right or: [
		  xOfNextPosition - 4 < aRectangle left ]
]

{ #category : 'positioning' }
BlBallElement >> moveToNextPosition [
	"Move the receiver to the next position according to its direction and speed"

	self position: self nextPosition
]

{ #category : 'positioning' }
BlBallElement >> nextPosition [
	"Return the next position that the receiver would occupy when he does not bump into something"

	^ self position + (speed * direction)
]

{ #category : 'initialization' }
BlBallElement >> positionAtStart [

	| extent x y |
	extent := parent extent.
	x := extent x / 2.
	y := extent y - 15.
	self position: x - 15 @ y - 6
]

{ #category : 'animation' }
BlBallElement >> startAnimation [

	animation := self animation.

]

{ #category : 'animation' }
BlBallElement >> stopAnimation [

	animation terminate
]
