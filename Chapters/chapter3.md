## Bricks

### Adding Bricks

**(Creating a bricks)**
`BrickMorph newStandAlone openInWorld`

### Bricks in the BreakOutField

The easiest way to have brick is to lay them down in line. In chapter ?? we will 
show you how to place bricks in a more flexible way. Right now we just want to 
have the possibility to create lines of bricks. The method *initializeBricks* 
call a certain number of times the method *brickLine: anInteger* where anInteger 
represents the number of the line (0 starting on the top of the field).

If we want to have 8 columns of bricks we create a brick, then computes its 
position which is its size multiplied by the row and column where it should be, 
and finally add the brick to the field using the *addBrick:* method that we have 
still to define.

Finally we have to define what means to add a brick in the field. The method 
*addBrick:* adds the brick as owned by the field using the addMorph message. After 
this message is executed the brick is contains in the field. Then it adds the 
bricks to the collection of brick the field have. Note that we could have only 
used the fact that the field is a morph and as such knows all the morph it 
contains, but this would have forced us to filter among the morphs to only get 
the bricks and not the ball or the batter.

### Avoiding Hardcoded Information

As you see the BreakOutField size is not adjusted to the number of bricks we 
draw per line. to fix this situation we will just change the size of the field 
to be related to the number of bricks. A possible solution would be to change 
the initialize to look as the method 3.6


Look at this method and the code we wrote until now and try to find what could 
be a problem. The problem is that we are hardcoding everywhere in the method 
body information such as the number of row and lines that the fields have, the 
size of the bricks...This is definitively not a good practice because if we 
decide to change one of these parameters, we will have to look everywhere and 
remember why we have a certain number in a given place and we may have hard time 
to fix possible bugs that will be popping up.  On this simple problem this may 
ont look as a problem but on a bigger system this will.

#### Making Explicit the Field Size

We propose you to fix these problems by defining a couple of methods that will 
return the different value we use for building the game. Once you will get done 
we suggest you to change the value to see how easy it is to change these 
parameters. First let us make explicit the size of the field in terms of brick 
numbers.  The method playFieldSize will return a point representing the number 
of columns and lines.

Note that in this method we do not go over the complete field area but let a 
space of 12 lines of bricks between the last row and the bottom of the game.


#### Making Explicit the Brick Size

The second hardcoded value that we want to make explicit is the size of a brick.  
In such a case changing it would have more impact because two classes are using 
it: the class *BrickMorph* and the class *BreakOutField*.

For the brick size, the story is a bit more difficult because the *BreakOut* 
uses it before any brick is created so we cannot send message to a brick and ask 
it size. One solution is to put the expressions `self bounds: (0@0 corner: 
aBrick size * self playFieldSize).`of the method 
*BreakOutField»initializeToStandAlone* after the brick initialization, to take 
any bricks contained in the brick collection, and to ask its size. We favor 
another solution because it will give us the opportunity to show how class 
themselves can be used. In fact in a similar manner that we send message to 
objects, we can send messages to classes.

So the first step is to change the method *BrickMorph»initializeToStandAlone* to 
invoke a new method called brickSize.

We could define the method *brickSize* as shown in method 3.12 but this would not 
solve our problem. Because for the method *BreakOutField»initializeToStandAlone* 
we need to know the brick size before any brick is created.

The solution is to first define a method called for example *defaultBrickSize* 
on the **class** *BrickMorph* itself as explained 4. In the method definition we 
will use the convention that we append **’ class’** to the class name to help 
you understanding that the method is defined on the class itself as shown in the 
method method 3.13.

Then we define an instance method with the name *brickSize* but on the instance 
side this time. This method just invokes the method *defaultBrickSize* by first 
getting the class of the receiver using the message class which returns the 
*class* of any object in the system. Then sending to the class the message 
*defaultBrickSize* and returning the returned value.

#### Designer Hints

We could have written the method *brickSize* as `ˆBrickMorph defaultBrickSize`, 
but this is really bad practice to hardocde class names into method since we may 
change the class name later and be forced to recompile all the methods having 
references to the class


Now we are ready to invoke the method *brickSize* from the methods of the class 
*BreakOutField*

Now we are done, we should be able to change the size of the bricks and of the 
play field only on single places (the methods *playFieldSize* and 
*defaultBrickSize* and automatically the game will be coherent.

### About the Instance/Class Buttons.

We open a parenthesis to explain an interesting but often not well-understood 
aspect of Smalltalk. In a similar way that we send message to objects we can 
send messages to classes.  This is what we have been doing since the really 
first script of this book. Indeed to get a new turtle we send the message *new* 
to the class Turtle. In a similar way that you learn how to define methods for 
messages send to objects, you can define methods for messages send to classes.

We can define methods and send them messages in exactly the same way that with 
any other objects.  To help you defining class methods (methods defined on 
classes) the browser has two buttons, instance and class. When you want to edit 
or see methods that will be executed when a message is sent to an instance you 
have to select the instance button. For example, the message *go: 100, color: 
Color yellow, turn: 90* that you sent to a turtle are methods that are executed 
on the instance.

The message *class* returns the class of the instance as shown in the script 3.3.  
Try to send this message to the results returned by various messages to see the 
different classes involved in Pharo.


When you want to see or define methods that will be executed when messages are 
sent to a *class itself*, you have to select the class button.

### Destroying Bricks

Finally we arrive at the essence of the game: the destruction of bricks.


First when the ball bounces on the batter we simply do not want to check 
anything else, so we add an explicit return *ˆself*. Then we check if the next 
position of the ball is located into one the bricks. The method 
*brickContainingOrNil:* returns nil when the ball will not touch a brick.  When 
the ball will be located inside a brick, the ball is asked to bounce then we ask 
the brick to react to the fact that the ball bounced on it. Note that this way 
of doing thing is only one solution because we could have ask the brick to be 
responsible of the ball bumping on it.

The minimal behavior that the brick should do when touched by a ball is to ask 
the field that owns it using the message owner to remove it from the lists of 
morph it contains using the message *removeBrick:*.
Then the brick destroyed itself using the message *delete* with is part of the 
basic behavior morphs have and is the opposite of *openInworld*.

### Lessons Learnt

* Factor constants
* Say things only once
* Class methods

