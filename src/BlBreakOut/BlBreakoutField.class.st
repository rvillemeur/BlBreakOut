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

{ #category : 'examples' }
BlBreakoutField class >> BrickDescriptionExample [

	<sampleInstance>
	^ (BlBreakoutField new brickClassFromDescription: $S) new openInNewSpace 
]

{ #category : 'template' }
BlBreakoutField class >> generateEmptyTemplate [
	"Generate an empty level description template"

	| aStream |
	aStream := ReadWriteStream on: (String new: 100).
	self maximumRowNumber timesRepeat: [
		self maximumColumnNumber timesRepeat: [ aStream nextPut: $E ].
		aStream nextPut: Character cr ].
	^ aStream contents
]

{ #category : 'level' }
BlBreakoutField class >> level0 [
"S as normal Brick, E as empty slot, and X as resistant Brick"
	^ 'SSSSSSSS
EEEEEEEE
SSSSSSSS
EUEEEEUE
SSSSSSSS
EEEEEEEE
SSSSSSSS
EEEEEEEE
XXXXXXXX
EEEEEEEE
SSSSSSSS
EEEEEEEE
XXXXXXXX
'
]

{ #category : 'examples' }
BlBreakoutField class >> levelExample [

	<sampleInstance>
	^ self  generateEmptyTemplate
]

{ #category : 'default' }
BlBreakoutField class >> maximumColumnNumber [
	"Return the number of rows that the field has"

	^ self playFieldSize x
]

{ #category : 'default' }
BlBreakoutField class >> maximumRowNumber [
	"Return the maximum number of brick lines that the field can have"

	^ self playFieldSize y - 13
]

{ #category : 'default' }
BlBreakoutField class >> playFieldSize [
	"Return the size of the complete game area expressed in terms of brick rows and columns"

	^ 8 @ 26
]

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

{ #category : 'level handling' }
BlBreakoutField >> brickClassFromDescription: aCharacter [

	aCharacter = $S ifTrue: [ ^ BlBrickElement ].
	aCharacter = $X ifTrue: [ ^ BlResistantBrickElement ].
	aCharacter = $U ifTrue: [ ^ BlUndestroyableBrickElement ]
]

{ #category : 'positioning' }
BlBreakoutField >> brickContainingOrNil: aPoint [
	"Return the brick containing the point aPoint or nil if none of the bricks contains the point"

	^ bricks
		  detect: [ :each |  each bounds bounds containsPoint: aPoint ]
		  ifNone: [ nil ]
]

{ #category : 'level handling' }
BlBreakoutField >> brickDesccriptionAtColumn: aColumn row: aRow [
	"Return the character description been at the position given by aPoint"

	^ aColumn + (aRow - 1 * (self class maximumColumnNumber + 1))
]

{ #category : 'initialization' }
BlBreakoutField >> brickLine: y [

	self brickLine: y ofKind: BlBrickElement
]

{ #category : 'adding' }
BlBreakoutField >> brickLine: y ofKind: aBrickClass [

	| b |
	0 to: self playFieldSize x - 1 do: [ :i |
		b := aBrickClass new.
		b position: i @ y * b brickSize.
		self addBrick: b ]
]

{ #category : 'positioning' }
BlBreakoutField >> ifBallNotBouncedOnWall: aPoint [

	| fieldBounds |
	fieldBounds := Rectangle origin: 0 @ 0 corner: self extent.
	(ball isNextPosition: aPoint verticallyInside: fieldBounds) ifTrue: [
		ball bounceLeftRight.
		^ false ].
	nil.
	aPoint y > (batter position y + batter height) ifTrue: [
		self lostABall.
		^ false ].
	nil.
	(ball isNextPosition: aPoint above: fieldBounds) ifTrue: [
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
	self installLevel: self class level0.

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

]

{ #category : 'level handling' }
BlBreakoutField >> installLevel: aDescription [
	"Create all the bricks as specified by the description"

	| char brick |
	1 to: self class maximumRowNumber do: [ :row |
		1 to: self class maximumColumnNumber do: [ :column |
			char := aDescription at:
				        (self brickDesccriptionAtColumn: column row: row).
			char = $E ifFalse: [
				brick := (self brickClassFromDescription: char) new.
				self addBrick: brick.
				self placeBrick: brick atBrickCoordinate: column - 1 @ (row - 1) ] ] ]
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
		batter touchedBy: ball.
		^ self ].
	b := self brickContainingOrNil: nextPosition.
	b ifNotNil: [ b actionWhenBumpedBy: ball ].

	ball moveToNextPosition
]

{ #category : 'bricks' }
BlBreakoutField >> placeBrick: aBrick atBrickCoordinate: aPoint [
	"Place the given brick at the given position taking into account the default size of bricks"

	| brickSize |
	brickSize := BlBrickElement defaultBrickSize.
	aBrick extent: brickSize.
	aBrick position: aPoint * brickSize + self position
]

{ #category : 'default' }
BlBreakoutField >> playFieldSize [
	"Return the size of the complete game area expressed in terms of brick rows and columns"

	^  self class playFieldSize

]

{ #category : 'removing' }
BlBreakoutField >> removeBrick: aBrickElement [
	"Remove the brick element from the collections of bricks"

	^ bricks remove: aBrickElement
]

{ #category : 'initialization' }
BlBreakoutField >> resistantBrickLine: y [

	self brickLine: y ofKind: BlResistantBrickElement
]
