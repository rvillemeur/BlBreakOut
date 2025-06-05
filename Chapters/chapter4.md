## Refining gameplay as a pretext to talk about Design

Until now the game play is a bit draft. In this chapter we add visual and audio 
feedback, and a new kind of bricks. This will also be the occasion to refine the 
design and change collaborations between classes.  So while this chapter seems 
at first not important, the changes introduced and discussions are important.  
We will also look again at the way inheritance helps to define new classes by 
extending existing ones. The chapter is a good complement of the chapter ??.

### Adding visual and Audio feedback

To add an audio and visual feedback we redefine the method *actionWhenBumped* as 
shown in the method 4.1. The method *flash* is defined on the class *Morph* and 
changes quickly the color of a morph to make it flashing. Then we create a sound 
and play it. Squeak offers a small library of predefined sounds.  Look in the 
class *SampledSound* class. You can find the names of the sounds available by 
executing the following expression *SampledSound soundNames*.

To add a feedback when the ball hits the batter, we modify the method moveBall 
(see method 4.2.  This solution is not really satisfactory because

Giving the field the responsibility to make a noise when the ball touches the 
batter is not good at all.  Indeed, it should be the responsibility of the 
batter to produce a visual or audio effect when it is touched.  We easily could 
imagine that we would like to have different kinds of batter producing different 
bouncing effect and noise. The field should not be worried about which kinds of 
batter it contains. It should let the batter decide.

Similarly different bricks may act in different way. Here the field again has 
the responsibility to make the ball bouncing. However, new kinds of bricks may 
simply destroy or capture the ball. That is why making the ball bouncing should 
be a responsibility of the brick itself. This way the field does not have to pay 
attention to which kind of brick the ball will bounce but just notify the brick 
that a ball is touching it.  A better designed solution to our breakout problem 
is shown by the method method 4.3

In general, you should define in the class the behavior related to the object 
and not let other object having this responsibility. This is a difficult 
exercise because you can have a solution that is not satisfactory form its 
design point of view but will still work perfectly. However, a well designed 
system will be easier to change and to understand.

#### Designer Hints

Often it is difficult to decide where put certain functionality. Even 
professional hesitate but they have some techniques to evaluate their decisions. 
Here are some. First try to identify which object has the responsibility to 
carry a behavior. Ask you the question whether it is natural for an object to be 
responsible of the behavior.

**Example.** Was it the responsibility of the field to make a noise when the 
ball was hitting the batter. Certainly not.

Second, imagine that an object with a slightly different behavior. By imagining 
a possible change, you will see that you may end up having to ask yourself what 
is the kind of object you have to perform certain operation. If you have such 
question this is really that your behavior is misplaced.

**Example.** If we introduce a special batter having the possibility of gluing 
balls. We want to make a special noise. If the field would have the 
responsibility of making the noise, it would have to know the kind of batter 
currently in the game. With the second design.  i.e., letting the batter 
controls the noise it makes. The field just notifies the batter that it has been 
hitted by the ball. The fact that the batter may be gluing or not is not its 
concern but the batter one.

We take the opportunity to make the brick having the responsibility of 
controlling the way the ball behaves when bouncing on it as shown by the figure 
4.1. Now the method *BrickMorph»actionWhenBumpedBy:aBall* has the responsibility 
to call the method *bounceTopBottom* or any other methods that changes the 
position and direction of the ball (See method 4.4). This was not the 
responsibility of the field to synchronized the effect of the brick getting 
touch and the move of the ball.

In a similar way now the method *touchedBy: aBall* is responsible for performing 
the visual effect when the batter is touched by the ball and to change the 
movement of the ball.

### Changing the bouncing

The way the ball is bouncing on the batter is quite boring because simply based 
on a reflection mechanism: if the ball arrives with a direction represented by 
*1@1* it went back with a direction of *1@ -1*. The definition of the method 
*BatterMorph»touchedBy: aBall* (shown in method 4.6) implements a different 
bouncing behavior: the closer to the center of the batter the ball bounces, the 
smaller is the bouncing angle relative to the vertical axe. Note that this 
behavior tries to avoid to speed up the ball. If you are not interested in 
understand how we found this formula skip the rest.


To explain you a bit the figure 4.3 illustrates the intuition of the solution.  
Imagine that the hypothenuse (AC) of a squared rectangle is the direction of the 
ball after bouncing. If we keep the distance CN constant and change the the 
distance AN the direction of AC will change. The figure 4.3 shows two cases one 
with AN having a big value and one with AN been small. If AN represents somehow 
the distance from the place where the ball bounced and the center of the batter 
we get the direction of the ball.

Now we do not want that the ball accelerates too much because the game would be 
impossible to play. Just computing the new direction by using the mathematical 
relations between A, C, and N is not sufficient. Previously the ball was moving 
from one pixel on x and one pixel on y so a distance of √ 2 pixels per move.  
Therefore to have a constant speed our new direction should move the ball with 
the same distance. So we fix the distance AC to be √ 2. The last problem we have 
is that d can be too big and will give rather flattened triangle. Therefore we 
decide to decide d by √ 2. The new direction is then *x = d*, and *y = p 2 + 
(d^2/2)* using the Pytagorus theorem that says that $$AC^2 = AC^2 +CN^2$$ .  
Finally the ball should bounce so we negate the sign of x and y. As using d as 
the difference between the batter center and the ball position, we apply some 
fine tuning to get the value of d proportional to the size of the batter. There 
are certainly more elegant way of doing this but this is not really imprtant and 
we let that for you.

Note that we need to know the current direction of the ball, so we define the 
method direction as shown in method 4.7.

### Resistant bricks

Having one single kind of brick is somehow boring. We propose you to add 
resistant bricks on which the ball should bounce several times before been 
destroyed.Introducing a new kind of brick will raise a lot of issues and show 
how object-oriented programming helps to solve them.  

In fact a resistant brick is a kind of brick, it should just remember how many 
times it has be bounced and only accepts to be destroyed when it has be bounced 
the right number of times.  Therefore we do not have to refine from scratch a 
new class for this new kind of brick but we can define the behavior of a 
resistant brick as a refinement of the one of *BrickMorph*.  

We define then the class *ResistantBrickMorph* as a subclass of the class 
*BrickMorph* as shown in class 4.1. This new class defines a new attribute named 
*resistanceNumber* that represents the resistance of the brick, i.e., the number 
of times the brick should be touched before breaking.

Once the class defined, we have to define how the created bricks will be 
initialized. Per default, we say that a resistantBrick is a more specialized 
version of brick, so we first ask a resistant brick to be initialized as if it 
was a brick using the expression *super initializeToStandAlone* then we initialize 
the resistant brick to have its specific properties. Here we changed its color 
and shape and initialize the resistance number so that the brick should touched 
three times before being destroyed.


Resistant bricks are not destroyed immediately after been touched by the ball.  
To implement such a behavior we specialize the method *actionWhenBumpedBy: 
aBall* which is invoked when the ball enter in contact with a brick as shown by 
the method 4.9. First we take into account the fact that the brick has been 
touched by calling a new method called *decreaseResistanceNumber* that simply 
decreasing the resistance number (see method 4.10). If the variable is 0, this 
means that the brick has been touched 3 times, we simply invoke the default 
behavior using the expression *super actionWhenBumpedBy: aBall*. Indeed we do 
not want to copy of the method *BrickMorph»actionWhenBumpedBy:* because we may 
change it in the future and we do not want to have to change it in several 
places. When the resistance number is not zero then we just make the ball 
bouncing.

To test wether everything works, we need just be able to add resistant bricks.  
We just propose for now to add a line of resistant bricks just to check whether 
what we did is working. In the chapter ?? we will implement a way to specify 
where and which kind of bricks are. Define the method *resistantBrickLine:*
(method 4.11) that creates a line of bricks at the row y.

As shown method 4.12 modify the method *initializeBricks* to invoke the method 
*resistantBrickLine:*.

Now if would be excellent to add a feedback when a resistant brick has been 
touched. To implement this we define the method *feedbackHitDecrease* as shown 
in method 4.13 and we should modify the method *actionWhenBumpedBy:* to invoke 
it. We let you do that.

### Avoiding repetition

The method *resistantBrickLine:* method ?? and the method *brickLine:* 3.4 only 
differ by the kind of bricks that are created. Having duplicate logic is always 
a problem because changing one will imply changing the other. This means that 
they is an occasion to refactor code.  For this purpose we define the method

Note that we passed classes as message arguments as any objects such as the 
point 10@100 or the number 100. In Pharo classes are just objects as any 
entities in the system

### Methods are the Unit of Specialization

In this section we will show you how breaking a big method into smaller ones 
allows one to have method part that can be easily specialized. The creation of a 
specific method avoids one to copy an entire method when we only want to 
specialize a part of it. When a brick or a resistant brick is destroyed, the 
*same* sound gives some audio feedback. To add more gameplay we would like that 
both kind of brick destruction is accompanied by a different sound. At first 
this is not obvious. Let us recap the situation. The method 
*BrickMorph»actionWhenBumpedBy: aBall* makes the brick flashing, plays a sound, 
makes the ball bouncing, and delete itself from the game

As shown in method 4.9, for a resistant brick, the method 
*ResistantBrickMorph»actionWhenBumpedBy: aBall* checks whether the brick should 
be destroyed or not as explained before.

**A First Wrong Approach.** The first natural idea that came is to add in this 
method the message to play sound as shown in the method 4.18. But this solution 
does not work because when the brick is destroyed two sounds are played: 
*’scratch’* the one of the BrickMorph and *’coyote’* the one of the 
ResistantBrickMorph.

Another wrong solution. The problem is that we cannot control the sound emitted 
in the *BrickMorph»actionWhenBumpedBy:* method. We could copy it entirely in the 
*ResistantBrick* method as shown in method 4.19. This solution only produces one 
sound. But the fact that a solution is working is often not enough. This 
solution can lead to lot of problems as soon as we decide to change the 
*actionWhenBumpedBy:* method of the class *BrickMorph*. Indeed we will have to 
repercut all the changes to this methods. Generalizing such a practice would 
lead to a system when we would spent all our time propagating changes between 
copied methods.

**The Solution.** In fact the problem is that we would like to be able to change 
only the sound emitted. We want to keep all the behavior of the method 
*BrickMorph»actionWhenBumpedBy: aBall* but be able to specify a different noise on 
the class *ResistantBrick.* The solution is quite simple in fact, we just have to 
extract the code emitting the sound from the method *actionWhenBumpedBy: aBall* as 
shown in method 4.21 and moving it to a new method called *soundFeedback* as in 
method 4.20.

You may wonder why this is solving our problem since right now we did not 
introduce anything new.  This is right that for the class *BrickMorph* we did 
not change anything. But we introduced the possibility for subclasses to 
specialize a part of the brick behavior. Now for the class *ResistantBrickMorph* 
we just have to define a different method *soundFeedback* as method 4.22 which 
when the method *actionWhenBumpedBy: aBall* will be invoked on a 
*resistantBrick* will be invoked instead of the method of 
*BrickMorph»soundFeedback*.

If we step back we can summarize that methods represent potential parts of a 
whole that can be changed by subclasses. This behavior is so important that the 
following Section will take the time to let you digest that. In fact we already 
explained in the chapterchapter ??. But this is worth that you read it again in 
the specific context of the BreakOut

### A Closer Look at Inheritance.

It is now the time to step back and take the time to really understand how the 
lookup of methods works and the interest of inheritance. These concepts are at 
the same time simple and complex. We suggest you to read the chapter chapter ??. 
Let us look step by step the way different messages are searched and executed.

#### 
