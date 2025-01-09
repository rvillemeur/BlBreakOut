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
		'direction'
	],
	#category : 'BlBreakOut',
	#package : 'BlBreakOut'
}

{ #category : 'animation' }
BlBallElement >> animation [

	| animation |
	animation := BlAnimation new
		             beInfinite;
		             duration: 50 milliSeconds.

	animation addEventHandler: (BlEventHandler
			 on: BlAnimationLoopDoneEvent
			 do: [ :anEvent | parent moveBall ]).

	^ animation
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
	direction := -1 @ -1
]

{ #category : 'testing' }
BlBallElement >> isNextPosition: aPoint above: aRectangle [
	"Return true whether the next position is above the rectangle"

	| yOfNextPosition |
	yOfNextPosition := aPoint y.
	^ yOfNextPosition - 4 < aRectangle top
]

{ #category : 'testing' }
BlBallElement >> isNextPosition: aPoint below: aRectangle [
	"Return true whether the next position is below the rectangle"
	| yOfNextPosition |
	yOfNextPosition := aPoint y.
	
	^ yOfNextPosition + 4 >= aRectangle bottom
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

	| position center bottom |
	position := parent extent.
	center := position x / 2.
	bottom := position y - 15.
	self position: center - 15 @ bottom - 6
]

{ #category : 'animation' }
BlBallElement >> startAnimation [

	self addAnimation: self animation
]
