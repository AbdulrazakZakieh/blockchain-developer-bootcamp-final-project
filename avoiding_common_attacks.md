To avoid some of the attacks, I did the followings:

1. tx.origin was never used
2. A specific pragma was used
3. Used modifiers to chech for critical conditions
4. State variables are not updated after any external call
