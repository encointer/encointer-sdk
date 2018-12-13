# encointer contracts
How to develop PDO contracts

make sure you have env variable LD_LIBRARY_PATH pointing to the common/build folder
```
export LD_LIBRARY_PATH=<your repo folder>/common/build
```

then you can prepare your contracts and run

```
>make
>make debug
```

and test your contract with 

```
cd simple-token
tinyscheme _debug_simple-token.scm 
```
