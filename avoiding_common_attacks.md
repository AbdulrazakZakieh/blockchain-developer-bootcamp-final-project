To avoid some of the attacks, I did the followings:

1. tx.origin was never used
2. Using Specific Compiler Pragma
3. Use Modifiers Only for Validation
4. Checks-Effects-Interactions (Avoiding state changes after external calls)
5. Timestamp Dependence not used in critical places
6. Tx.Origin Authentication was never used
