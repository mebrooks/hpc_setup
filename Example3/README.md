Simple makefile example
=======================

## Normal execution

Normal execution can be performed independent of HPC e.g. on your
laptop:

```shell
make
```

or in parallel (using 2 cores)

```shell
make -j2
```

## Submit via the `submit` command

We can also run it in parallel using the `submit` command. However,
this approach is limited to one compute node. We must request the
number of cores that are used by the parallel job:

```shell
MC_CORES=2 submit "make -j2"
```

Here the command `make -j2` is submitted as a single job hence we must
reserve the number of required cores for the job by passing `MC_CORES`
to `submit`.

## Submit via the `qmake` command

To take full advantage of all HPC nodes we can submit using
`qmake`. This is only relevant when using *many* cores:

```shell
submit "qmake -j50"
```

The `-j50` tells `qmake` to put no more than `50` simultaneous jobs in
the queue. Job reservations are made on demand hence using a high
value of `-j` does not waste resources. We do not need to explicitly
request the number of cores.

**Note** The targets may benefit from a parallel BLAS or extra cores
  (as in [Example 1](../Example1) and [Example 2](../Example2)). These
  resources can be requested from the `Makefile` by putting
  e.g. `export OMP_NUM_THREADS=8` at the top, see
  [Example 4](../Example4)). Reservations are automatically
  adjusted. However, note that the extra requested resources will
  apply to *all* targets.
