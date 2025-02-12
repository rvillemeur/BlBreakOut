Class {
	#name : 'BlBreakOut',
	#superclass : 'BlElement',
	#instVars : [
		'field',
		'scoreDisplay',
		'lifeDisplay',
		'color'
	],
	#category : 'BlBreakOut-Core',
	#package : 'BlBreakOut',
	#tag : 'Core'
}

{ #category : 'shapes' }
BlBreakOut >> createBar [

	|insets|
	insets := (BlInsets top: 10 left: 5 bottom: 10 right: 5).
	lifeDisplay := (BROutLEDText new textPadding: 2; label: '00'; margin: insets).
	scoreDisplay := (BROutLEDText new textPadding: 5; label: '000000';  margin:insets).
	
	^ BlElement new
	background: color;
	border: (BlBorder paint: Color darkGray width: 4);
	layout: BlFlowLayout horizontal; constraintsDo: [ :c | c horizontal matchParent. c vertical exact: 50 ];
	addChild: (BROutLabel new label: 'Lifes';  margin: insets);
	addChild: lifeDisplay;
	addChild: (BROutLabel new label: 'Scores';  margin: insets);
	addChild: scoreDisplay;
	addChild: (BROutButton new label: 'Active game'; action: [ field restartPausedGame ]; margin: insets); 
	addChild: (BROutButton new label: 'Pause'; action: [ field pauseGame ]; margin: insets); 
	addChild: (BROutButton new label: 'New Game'; action: [ field newGame ]; margin: insets); 
	addChild: (BROutButton new label: 'Quit'; action: [ self space close ]; margin: insets)
]

{ #category : 'initialization' }
BlBreakOut >> initialize [
	"BreakOut newStandAlone openInNewSpace"

	super initialize.
	self initializeBreakOutProperties.
	self initializeField.
	self addChild: field.
	self addChild: self createBar.
	self updateLifes
]

{ #category : 'initialization' }
BlBreakOut >> initializeBreakOutProperties [

	color := Color red alpha: 0.3.
	self
		layout: BlFlowLayout vertical;
		constraintsDo: [ :c |
			c horizontal exact: 568.
			c vertical fitContent ].

	self addEventHandlerOn: BlElementExtentChangedEvent do: [ :evt |
		self space
			"resize space according to game extent"
			extent: evt target extent;
			title: 'Breakout game';
			"center space instead of default top left opening."
			enqueueTask: (BlTaskAction new
					 action: [ self space center ];
					 yourself) ]
]

{ #category : 'initialization' }
BlBreakOut >> initializeField [

	field := BlBreakoutField new.
	field addEventHandlerOn: LifeChanged do: [ self updateLifes ].
	field addEventHandlerOn: ScoreChanged do: [ self updateScore ].

]

{ #category : 'as yet unclassified' }
BlBreakOut >> updateLifes [
	"change the value represented by the ledMorph"

	lifeDisplay label: field lifes asRopedText
]

{ #category : 'as yet unclassified' }
BlBreakOut >> updateScore [
	"change the value represented by the ledMorph"

	scoreDisplay label: field score asRopedText
]
