Class {
	#name : 'BROutExample',
	#superclass : 'BlElement',
	#category : 'BlBreakOut-Example',
	#package : 'BlBreakOut-Example'
}

{ #category : 'examples' }
BROutExample class >> sampleButton [

	<sampleInstance>
	^ BROutButton new
		  label: 'Button LabelExample';
		  action: [ self inform: 'clicked' ];
		  openInNewSpace
]

{ #category : 'see class side' }
BROutExample >> seeClassSide [ 
]
