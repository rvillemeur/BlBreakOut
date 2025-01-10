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
	#category : 'BlBreakOut',
	#package : 'BlBreakOut'
}

{ #category : 'animation' }
BlBallElement >> animation [

	| anim |
	anim := BlAnimation new
		             beInfinite;
		             duration: 50 milliSeconds.

	anim addEventHandler: (BlEventHandler
			 on: BlAnimationLoopDoneEvent
			 do: [ :anEvent | parent moveBall ]).

	^ anim
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
BlBallElement >> isNextPosition: arg1 above: arg2 [

	| tmp1 |
	tmp1 := arg1 y.
	^ tmp1 - 4 < arg2 top
]

{ #category : 'testing' }
BlBallElement >> isNextPosition: arg1 below: arg2 [

	| tmp1 |
	tmp1 := arg1 y.
	^ tmp1 + 4 >= arg2 bottom
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

	| tmp1 tmp2 tmp3 |
	tmp1 := parent extent.
	tmp2 := tmp1 x / 2.
	tmp3 := tmp1 y - 15.
	self position: tmp2 - 15 @ tmp3 - 6
]

{ #category : 'animation' }
BlBallElement >> startAnimation [
	animation := self animation.
	self addAnimation: animation
]

{ #category : 'animation' }
BlBallElement >> stopAnimation [

	animation stop
]
