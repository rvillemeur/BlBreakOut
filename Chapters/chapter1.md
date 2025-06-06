## A Ball and A Field

This chapter is the first one of the breakout we will be designing together. The 
idea is that we will define step by step this breakout application. However, we 
will not do the best design first but simply build first what is possible then 
evaluate what we made and refactor the code if necessary. Indeed object-oriented 
design is about pros and cons and refinement. Moreover, an application usually 
has changing requirements that naturally forces the code to change. We also 
believe that building a prototype, i.e., a first version of a system is a good 
way to understand the problem and understand the trade-off that the design 
solution should address. You will see that during the chapter the 
responsibilities may change and the interactions between objects too.

First we start by building the ball and the game field.


### ball

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

```st
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

### Breakout Field

In initialization


Now the ball belongs to the field and is detsroyed when the field is destroyed.  
When the field is moved (brown halo) the ball moves with it. When the ball is 
stop (ball stopStepping) and the field moved (black halo) the startStepping 
message is propagated to it. This is the field open in world that will open in 
world its constituents, hence we do not have to openInworld explicitly the ball 
as shown in the method 1.7. Once the addMorph: method is executed the ball can 
access the morph it belongs to via the owner message.

### Ball in the field

In Initialization

However we cannot call this method from within the BallMorph»initializeMethod 
because the addMorph: method is executed after the ball instance creation and in 
such a case the owner would be nil. So we let the responsibility to specify 
where the ball should be to the

**Keeping the Ball Inside.** To be able to force the ball to stay inside the 
field we have to determine its next position according to its speed and 
direction. This way we will be able to write some testing methods and ask the 
ball to bump so briefly presented by the method sketch 1.10.

From this sketch we see that we will have to compute the next position that the 
ball will occupy.

Then we need some methods to check whether the ball will exist the field.

This method can be shortened a bit as the same action has to be done for the 
left or right side. For the bottom side we will introduce the fact that the game 
is over in a following chapter.

Notice that this solution let the ball decide its own ,...and its coherent with 
oo however we will see soon that we want to minimize the number of collaborator 
so we will let the field controlling the ball.

### Optimizing a Bit and Design discussions

In a first reading you can skip this section that discusses several points of 
the implementation we proposed.  The solution we propose is one solution and 
others are possible which can be better. For example, the methods 
*isNextPosition...* always call *nextPosition* which is then multiply times 
computed.  To avoid such a situation we can call on in the method *step* the 
method *linearPosition* then pass an extra argument to the methods 
*isNextPosition* as in the method 1.23

**Caching the position.** Another solution is to change the method 
*nextPosition* so that it caches the computation. For this we would have to add 
an instance variable to class called for example, *cachednextPosition* , and 
changed the method *nextPosition* and the method *nextPosition* to invalidate 
the cache. This example illustrates that for a cache two questions are important 
when to store the information and when to invalidate it. Note also that the fact 
we use the method *nextPosition* we can add the cache without changing all the 
methods that use it.

Note that passing an extra parameter is a good solution when the method calling 
them is defined on the class *BallMorph* because the class can control the 
consistency between the current position and the next one. When the caller is 
another class as we will introduce in a future chapter, the class *BallMorph* 
loses a bit this control. Hence it is possible to write silly code as follow 
where a wrong point is passed as argument representing the next linear position.

