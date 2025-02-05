## A Ball and A Field

This chapter is the first one of the breakout we will be designing together. The idea is that we will
define step by step this breakout application. However, we will not do the best design first but simply build
first what is possible then evaluate what we made and refactor the code if necessary. Indeed object-oriented
design is about pros and cons and refinement. Moreover, an application usually has changing requirements
that naturally forces the code to change. We also believe that building a prototype, i.e., a first version of
a system is a good way to understand the problem and understand the trade-off that the design solution
should address. You will see that during the chapter the responsibilities may change and the interactions
between objects too.

First we start by building the ball and the game field.

```lifecode=BlBallElement
BlElement << #BlBallElement
	slots: { #speed . #direction . #animation };
	tag: 'Core';
	package: 'BlBreakOut'
```

The speed is the number of pixels that are added to the position of the
receiver. The direction is a point representing how the speed is taken into 
account for each dimension. Here 1@1 says that the receiver will move each
step 3 pixels in x and 3 pixels in y as the speed is 3

```lifecode=BlBallElement>>#initialize
initialize

	super initialize.
	self
		geometry: (BlCircleGeometry new matchExtent: 9 @ 9);
		size: 9 @ 9;
		background: Color yellow;
		border: (BlBorder paint: Color black width: 1).
	speed := 3.
	direction :=  -1 @  -1.
	animation := self animation.
```

```lifecode=BlBallElement>>#animation
animation

^ BlAnimation new beInfinite;
		        duration: 50 milliSeconds;
                addEventHandler: (BlEventHandler
			        on: BlAnimationLoopDoneEvent
			        do: [ :anEvent | parent moveBall ]).

```

```lifecode=BlBallElement>>#startAnimation
startAnimation
	animation := self animation.
	self addAnimation: animation
```

```lifecode=BlBallElement>>#stopAnimation
stopAnimation
	animation stop
```

With the inspector change the speed and the direction of the ball. Use 
stopAnimation and startAnimation if needed to stop the ball movement. 
Experiment to find how we can express that the ball is bouncing on a
vertical or horizontal surface (see method?? for the answer).

