## A batter in the field

### Batter


### Batter in the field

Redefine

**Controlling the batter**.


Now when you press the key n and m, you should get in the Transcript the string 
’Left’ or ’Right’ printed.


**Moving the Batter.** Now the batter define methods to move left and right. We 
named them *moveLeft* and *moveRight*. Redefine the method *keyDown:* to call 
these methods (2.6) and propose a definition for the methods *moveLeft* and 
*moveRight*

The method *BatterMorph>>moveRight* method 2.7 effectively moves the batter but 
does not check whether it stays in the field


The method 2.7 proposes a first solution. It just changes the position of the 
batter by adding the speed converted as a point to the current position.

The method *BatterMorph»moveRight* method 2.7 effectively moves the batter but 
does not check whether it stays in the field as shown by the figure2. Experiment 
and propose a solution.

**Towards a Good moveRight method.** A solution is to check before moving the 
batter if it will stay in the field bounds as shown in the method the method 
2.8. Implement it to evaluate if you like it.


In fact the solution proposed in the method 2.8 has still a problem. When the 
batter has a significant speed such as 10 or 15 pixels, it may happen that we 
forbid it to move else it would exist the field but doing so we let some space 
where the ball could pass between the wall and batter which is really bad for 
the gameplay. This situation is shown in figure 2.2. Propose a solution to fix 
this problem.

The second version of the method *BatterMorph»moveRight* method 2.8 effectively 
keeps the batter in the field but sometimes leading to gameplay problem. Here 
the ball can still pass between the batter and the wall.

**A Good moveRight method.** Solving the problem enonced before is based on the 
following idea.  When the batter may end up outside of the field, it should not 
move by its speed but by the difference between the wall and the batter 
extremity.

We can reexpress the method 2.9 by seeing that we want to move the batter by the 
miminum between the speed and the difference between the batter extremity and 
the wall. The methods method 2.10 shows the final version where we split the 
method to have better readibility. Apply the same idea for moveLeft before 
looking at the solution we propose method 2.11).

### Batter and Ball Interaction

Now we want the ball to bounce on the batter. This brings an interesting issue: 
where do we describe the game logic? Right now the ball is checking that it is 
not going outside the field. But now we want to check whether the ball bumps 
into the batter and in the future we will have brick collision. We could 
continue this way but the ball would have to be in collaboration with the field, 
the batter and the bricks. This is not per se a problem but the field will also 
be in a such a situation due to the fact that it contains the other objects.

What you see is that there is a tradeoff between having objects with too much 
collaborators and objects having too much control of the others. There is no 
definite answer about the distribution of the logic game even if object-oriented 
programming favors distribution of the responsibilities.

We decide to move the behavior of the method *BallMorph»step* in the class 
*BreakOutField*.  To do so we define the method *BreakOutField»moveBall*


The code of the method *moveBall* is not really good. So we decide to cut it 
into pieces and to change the methods calculating if the ball will exit the 
field such as *BallMorph»isNextPositionVerticallyInside: aRectangle* to to take 
the next position as extra argument as shown by the method method 2.14. We let 
you transform the other related methods in the class BallMorph.

The method *moveBall* now looks as the definition method 2.15. The idea is that 
when the ball will bounce on the wall the method *ifBallNotBouncedOnWall:* takes 
care of making the ball bounces and forward. To avoid to move the ball twice, it 
returns false indicating that the ball does not have to be further controlled 
for this step. When the ball will not touch a wall or lost, the method 
*moveBall* checks whether the ball will bump into the batter. In such a case the 
ball bounces on it. Note that the collision between the batter and the ball is 
rudimentary and may lead to strange situations. We will you imagine other 
collision detection approaches taking into account the sides of the batter and 
the direction of the ball.

By the way you will see that this is boring to stop the game when you lose the 
ball. You could for example say to the ball to bounce
