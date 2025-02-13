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
		'bricks',
		'brickDescriptions',
		'score',
		'paused',
		'lifes',
		'level',
		'levels',
		'moveLeftShortcut',
		'moveRightShortcut',
		'destroyableBrickNumber'
	],
	#category : 'BlBreakOut-Core',
	#package : 'BlBreakOut',
	#tag : 'Core'
}

{ #category : 'examples' }
BlBreakoutField class >> BrickDescriptionExample [

	<sampleInstance>
	^ (BlBreakoutField new brickClassFromDescription: $S) new openInNewSpace 
]

{ #category : 'as yet unclassified' }
BlBreakoutField class >> gatherAllDefinedLevels [

	| sortedSelector |
	sortedSelector := (self class selectors select: [ :each |
		                   'level*' match: each asString ])
		                  asSortedCollection.
	^ sortedSelector collect: [ :levelSel | self perform: levelSel ]
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

{ #category : 'as yet unclassified' }
BlBreakoutField class >> level1 [

	^ 'SSSSSSSS
SXXXXXXX
SEEEEEEE
SEEEEEEE
SSSSSSSS
SXXXXXXX
SEEEEEEE
SEEEEEEE
SESEESSS
SESEESES
SESEESES
SESEESES
SESSESSS
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

{ #category : 'bricks' }
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

	^ brickDescriptions at: aCharacter
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

{ #category : 'bricks' }
BlBreakoutField >> brickLine: y [

	self brickLine: y ofKind: BlBrickElement
]

{ #category : 'bricks' }
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

	aPoint y > (batter position y + batter height) ifTrue: [
		self lostABall.
		^ false ].

	(ball isNextPosition: aPoint above: fieldBounds) ifTrue: [
		ball bounceTopBottom.
		^ false ].

	^ true
]

{ #category : 'scoring' }
BlBreakoutField >> increaseScoreBy: aNumber [

	score := score + aNumber.
	self dispatchEvent: ScoreChanged new.
]

{ #category : 'initialization' }
BlBreakoutField >> initialize [

	super initialize.
	self initializeFieldProperties.
	self initializeKeyboardShortcuts.
	self initializeBallElement.
	self initializeBatterElement.
	self setBallAndBatterPositionAtStart.
	self initializeBricks.
	self installLevels.
	self initializeGame
]

{ #category : 'initialization' }
BlBreakoutField >> initializeBallElement [

	self ball: BlBallElement new
]

{ #category : 'initialization' }
BlBreakoutField >> initializeBatterElement [

	self batter: BlBatterElement new
]

{ #category : 'initialization' }
BlBreakoutField >> initializeBricks [

	bricks := OrderedCollection new.
	brickDescriptions := Dictionary new.
	BlBrickElement withAllSubclasses do: [ :aClass |
		brickDescriptions at: aClass descriptionCharacter put: aClass ]
]

{ #category : 'initialization' }
BlBreakoutField >> initializeFieldProperties [

	self
		geometry: BlRectangleGeometry new;
		size: BlBrickElement defaultBrickSize * self playFieldSize;
		background: (Color red alpha: 0.5);
		border: (BlBorder paint: Color black width: 1).
		

]

{ #category : 'initialization' }
BlBreakoutField >> initializeGame [

	score := 0.
	lifes := 4.
	level := 1.
	self dispatchEvent: LifeChanged new.
	self installCurrentLevel.
	self pauseGame
]

{ #category : 'initialization' }
BlBreakoutField >> initializeKeyboardShortcuts [

	moveLeftShortcut := BlShortcutWithAction new
		                    combination: BlKeyCombination builder n build;
		                    action: [ :anEvent :aShortcut | batter moveLeft ].
	moveRightShortcut := BlShortcutWithAction new
		                     combination: BlKeyCombination builder m build;
		                     action: [ :anEvent :aShortcut |
			                     batter moveRight ].

	self addShortcut: (BlShortcutWithAction new
			 combination: BlKeyCombination builder space build;
			 action: [ :anEvent :aShortcut |
				 anEvent consumed: true.
				 self managePauseGame: anEvent ]).

	"necessary, otherwise, keyboard shortcut are not taken into account"
	self requestFocus
]

{ #category : 'level handling' }
BlBreakoutField >> installCurrentLevel [

	self installLevel: (levels at: level).
	destroyableBrickNumber := bricks inject: 0 into: [:sum :each |
		                          sum + (each class isDestroyable
			                                  ifTrue: [ 1 ]
			                                  ifFalse: [ 0 ]) ]
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

{ #category : 'initialization' }
BlBreakoutField >> installLevels [

	levels := self class gatherAllDefinedLevels
]

{ #category : 'level handling' }
BlBreakoutField >> installNextLevel [

	self pauseGame.
	level := self isLastLevel
		         ifTrue: [ 1 ]
		         ifFalse: [ level + 1 ].
	bricks do: [:each | each delete].
	self installCurrentLevel.
	self resetBallAndBatterPositionAtStart
]

{ #category : 'testing' }
BlBreakoutField >> isLastLevel [
	"Return whether the current level is the last one defined"

	^ levels size = level
]

{ #category : 'testing' }
BlBreakoutField >> isLevelTerminated [

	^ destroyableBrickNumber isZero
]

{ #category : 'game logic' }
BlBreakoutField >> isPaused [

	^ paused
]

{ #category : 'accessing' }
BlBreakoutField >> lifes [

	^ lifes
]

{ #category : 'game logic' }
BlBreakoutField >> lostABall [
	lifes isZero ifTrue: [
		self inform: 'You die'.
		self pauseGame.
		^ self ].
	lifes := lifes - 1.
	self dispatchEvent: LifeChanged new.
	self pauseGame.
	self resetBallAndBatterPositionAtStart.
	
]

{ #category : 'game logic' }
BlBreakoutField >> managePauseGame: anEvent [

	self isPaused
		ifTrue: [
			self addShortcut: moveLeftShortcut.
			self addShortcut: moveRightShortcut.
			anEvent currentTarget restartPausedGame ]
		ifFalse: [
			self removeShortcut: moveLeftShortcut.
			self removeShortcut: moveRightShortcut.
			anEvent currentTarget pauseGame ]
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
	self isLevelTerminated ifTrue: [ self installNextLevel ].

	ball moveToNextPosition
]

{ #category : 'game logic' }
BlBreakoutField >> newGame [

	self setBallAndBatterPositionAtStart.
	self initializeBricks.
	self installLevel: self class level0.
	self initializeGame
]

{ #category : 'game logic' }
BlBreakoutField >> pauseGame [

	paused := true.
	ball stopAnimation
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

	bricks remove: aBrickElement.
	destroyableBrickNumber := destroyableBrickNumber - 1
]

{ #category : 'initialization' }
BlBreakoutField >> resetBallAndBatterPositionAtStart [
	"the size is not available to children until rendered at least once."

	ball positionAtStart.
	batter positionAtStart
]

{ #category : 'bricks' }
BlBreakoutField >> resistantBrickLine: y [

	self brickLine: y ofKind: BlResistantBrickElement
]

{ #category : 'game logic' }
BlBreakoutField >> restartPausedGame [

	paused := false.
	ball startAnimation
]

{ #category : 'accessing' }
BlBreakoutField >> score [

	^ score
]

{ #category : 'initialization' }
BlBreakoutField >> setBallAndBatterPositionAtStart [
	"the size is not available to children until rendered at least once."

	self addEventHandlerOn: BlElementExtentChangedEvent do: [ :evt |
		self resetBallAndBatterPositionAtStart ]
]
