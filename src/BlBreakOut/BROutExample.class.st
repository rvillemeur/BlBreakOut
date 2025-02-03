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

{ #category : 'examples' }
BROutExample class >> sampleButton [

	<sampleInstance>
	^ BROutButton new
		  label: 'Button Label Example';
		  action: [ self inform: 'clicked' ];
		  openInNewSpace
]

{ #category : 'examples' }
BROutExample class >> sampleLEDText [

	<sampleInstance>
	^ BROutLEDText new openInNewSpace 

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
	^ BlElement new
	background: (Color red alpha: 0.2);
	border: (BlBorder paint: Color darkGray width: 4);
	layout: BlFlowLayout horizontal; constraintsDo: [ :c | c horizontal fitContent. c vertical fitContent ];
	addChild: (BlTextElement text: ('Lifes' asRopedText fontSize: 50; yourself)); padding: (BlInsets all: 10);
	addChild: (BROutLEDText new textPadding: 5; label: '00'; margin: (BlInsets all: 10));
	addChild: (BlTextElement text: ('Scores' asRopedText fontSize: 50; yourself));
	addChild: (BROutLEDText new textPadding: 5; label: '000000';  margin: (BlInsets all: 10)); 
	addChild: (BROutButton new label: 'Active game'; action: [ self inform: 'clicked' ]; margin: (BlInsets all: 10)); 
	addChild: (BROutButton new label: 'Pause'; action: [ self inform: 'clicked' ]; margin: (BlInsets all: 10)); 
	addChild: (BROutButton new label: 'New Game'; action: [ self inform: 'clicked' ]; margin: (BlInsets all: 10)); 
	addChild: (BROutButton new label: 'Quit'; action: [ self inform: 'clicked' ]; margin: (BlInsets all: 10))
]

{ #category : 'see class side' }
BROutExample >> seeClassSide [ 
]
