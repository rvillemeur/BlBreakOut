Class {
	#name : 'BROutExample',
	#superclass : 'BlElement',
	#category : 'BlBreakOut-Example',
	#package : 'BlBreakOut',
	#tag : 'Example'
}

{ #category : 'instance creation' }
BROutExample class >> newFieldGame [

	<sampleInstance>
	^ BlBreakoutField new openInNewSpace
]

{ #category : 'instance creation' }
BROutExample class >> newGame [

	<sampleInstance>
	|board field score|
	field := BlBreakoutField new.

	board := BlElement new
	layout: BlFlowLayout vertical; constraintsDo: [ :c | c horizontal exact: 568 . c vertical fitContent ].
	
	score := self scoreBar.
	
	board 
	addChild: field;
	addChild: score.
	^board  openInNewSpace.
]

{ #category : 'examples' }
BROutExample class >> sampleButton [

	<sampleInstance>
	^BlElement new 		constraintsDo: [ :c |
			c horizontal exact: 150.
			c vertical exact: 50 ]; 
			background: (Color blue alpha: 0.2); addChild: (BROutButton new
		  label: 'Button Label Example';
		  action: [ self inform: 'clicked' ])";
		  openInNewSpace"
]

{ #category : 'examples' }
BROutExample class >> sampleLEDText [

	<sampleInstance>
	^ BlElement new
		  constraintsDo: [ :c |
			  c horizontal exact: 150.
			  c vertical exact: 50 ];
		  background: (Color blue alpha: 0.2);
		  addChild: BROutLEDText new
]

{ #category : 'examples' }
BROutExample class >> sampleLEDTextWithScore [

	<sampleInstance>
	^ BROutLEDText new textPadding:5; label: '2345'; openInNewSpace 

]

{ #category : 'examples' }
BROutExample class >> sampleStandaloneButton [

	<sampleInstance>
	^ BROutButton new
		  label: 'example'
]

{ #category : 'examples' }
BROutExample class >> scoreBar [

	<sampleInstance>
	|insets|
	insets := (BlInsets top: 10 left: 5 bottom: 10 right: 5).
	
	^ BlElement new
	background: (Color red alpha: 0.2);
	border: (BlBorder paint: Color darkGray width: 4);
	layout: BlFlowLayout horizontal; constraintsDo: [ :c | c horizontal matchParent. c vertical exact: 50 ];
	addChild: (BROutLabel new label: 'Lifes';  margin: insets);
	addChild: (BROutLEDText new textPadding: 2; label: '00'; margin: insets);
	addChild: (BROutLabel new label: 'Scores';  margin: insets);
	addChild: (BROutLEDText new textPadding: 5; label: '000000';  margin:insets); 
	addChild: (BROutButton new label: 'Active game'; action: [ self inform: 'clicked' ]; margin: insets); 
	addChild: (BROutButton new label: 'Pause'; action: [ self inform: 'clicked' ]; margin: insets); 
	addChild: (BROutButton new label: 'New Game'; action: [ self inform: 'clicked' ]; margin: insets); 
	addChild: (BROutButton new label: 'Quit'; action: [ self inform: 'clicked' ]; margin: insets)
]

{ #category : 'see class side' }
BROutExample >> seeClassSide [ 
]
