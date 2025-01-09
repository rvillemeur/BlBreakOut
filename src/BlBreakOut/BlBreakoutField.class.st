"
Example

```smalltalk
BlBreakoutField new openInNewSpace
```
"
Class {
	#name : 'BlBreakoutField',
	#superclass : 'BlElement',
	#instVars : [
		'ball',
		'batter',
		'bricks'
	],
	#category : 'BlBreakOut',
	#package : 'BlBreakOut'
}

{ #category : 'adding' }
BlBreakoutField >> addBrick: aBrickElement [

	self addChild: aBrickElement.
	bricks add: aBrickElement
]

{ #category : 'accessing' }
BlBreakoutField >> ball: aBallElement [

	ball := aBallElement.
	self addChild: aBallElement
]

{ #category : 'accessing' }
BlBreakoutField >> batter: aBatterElement [
	"Add the batter as contained by the receiver"

	batter := aBatterElement.
	self addChild: aBatterElement
]

{ #category : 'positioning' }
BlBreakoutField >> brickContainingOrNil: aPoint [
	"Return the brick containing the point aPoint or nil if none of the bricks contains the point"

	^ bricks
		  detect: [ :each |  each bounds bounds containsPoint: aPoint ]
		  ifNone: [ nil ]
]

{ #category : 'initialization' }
BlBreakoutField >> brickLine: y [
	"Add a line of brick at the y row"

	| b |
	0 to: self playFieldSize x - 1 do: [ :i |
		b := BlBrickElement new.
		b position: i @ y * b brickSize.
		self addBrick: b ]
]

{ #category : 'positioning' }
BlBreakoutField >> ifBallNotBouncedOnWall: arg1 [

	| tmp1 |
	tmp1 := Rectangle origin: 0 @ 0 corner: self extent.
	(ball isNextPosition: arg1 verticallyInside: tmp1) ifTrue: [
		ball bounceLeftRight.
		^ false ].
	nil.
	arg1 y > batter position y ifTrue: [
		self lostABall.
		^ false ].
	nil.
	(ball isNextPosition: arg1 above: tmp1) ifTrue: [
		ball bounceTopBottom.
		^ false ].
	nil.
	^ true
]

{ #category : 'initialization' }
BlBreakoutField >> initialize [

	super initialize.
	self
		geometry: BlRectangleGeometry new;
		size: BlBrickElement defaultBrickSize * self playFieldSize;
		background: (Color red alpha: 0.5);
		border: (BlBorder paint: Color black width: 1).
	self ball: BlBallElement new.
	self batter: BlBatterElement new.
	self initializeBricks.

	self addShortcut: (BlShortcutWithAction new
			 combination: BlKeyCombination builder n build;
			 action: [ :anEvent :aShortcut | batter moveLeft ]).
	self addShortcut: (BlShortcutWithAction new
			 combination: BlKeyCombination builder m build;
			 action: [ :anEvent :aShortcut | batter moveRight ]).

	"necessary, otherwise, keyboard shortcut are not taken into account"
	self requestFocus.
	"the size is not available to children until rendered at least once."
	self addEventHandlerOn: BlElementExtentChangedEvent do: [ :evt |
		ball positionAtStart.
		batter positionAtStart.
		ball startAnimation ]
]

{ #category : 'initialization' }
BlBreakoutField >> initializeBricks [

	bricks := OrderedCollection new.
	0 to: self playFieldSize y - 12 do: [ :y | self brickLine: y ]
]

{ #category : 'positioning' }
BlBreakoutField >> lostABall [

	self inform: 'You die'
]

{ #category : 'positioning' }
BlBreakoutField >> moveBall [

	| nextPosition b |
	nextPosition := ball nextPosition.
	(self ifBallNotBouncedOnWall: nextPosition) ifFalse: [ ^ self ].
	(batter bounds bounds containsPoint: nextPosition) ifTrue: [
		ball bounceTopBottom.
		^ self ].
	b := self brickContainingOrNil: nextPosition.
	b ifNotNil: [
		ball bounceTopBottom.
		b actionWhenBumped ].

	ball moveToNextPosition
]

{ #category : 'initialization' }
BlBreakoutField >> playFieldSize [
	"Return the size of the complete game area expressed in terms of brick rows and columns"

	^ 8 @ 26
]

{ #category : 'removing' }
BlBreakoutField >> removeBrick: aBrickElement [
	"Remove the brick element from the collections of bricks"

	^ bricks remove: aBrickElement
]
