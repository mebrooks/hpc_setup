Advanced makefile example
=========================

This `Makefile` has some more interesting ingredients:

* 8 cores are allocated for all targets.
* The target runs cannot start until the common binary dependency has been generated.
* Job parameters `SCRIPT_INPUT` are passed as *a single environment variable* to `R`.

We can run it on our laptop by

`make`

or

`make -j2`

but this will generate a lot of heat.

## Run on HPC

```shell
submit "qmake -j10"
```

It takes roughly an hour to complete.
