## DTU HPC setup

Setup R and relevant packages for a DTU HPC account ( http://www.hpc.dtu.dk ) .

### Get Started

Login to your account

```shell
ssh $USER@login.gbar.dtu.dk
qrsh
```

Clone this repo to your home folder and run the main script

```shell
git clone https://github.com/DTUAqua/hpc_setup
cd hpc_setup
export PATH=${HOME}/bin:$PATH
MAKE="make -j8" make all
```

### Submitting a script

Say we have an R script

```shell
echo "m <- diag(1e3)+1; system.time(for(i in 1:10) m%*%m)" > script.R
```

We can run the script the usual way by

```shell
R --vanilla < script.R
```

In order to submit this script to the queue replace the above line by

```shell
submit "R --vanilla < script.R"
```

On submission you'll see a list of default parameters attached to the job

```
Job parameters
==============

MAX_DURATION    = 08:00:00  (hh:mm:ss)
MAX_MEMORY      = 8gb
OMP_NUM_THREADS = 1
MC_CORES        = 1
```

These four environment variables can be passed to the `submit`
command. We'll see some examples in the following.

### Some real examples

* [Example 1](Example1) Speeding up a single model using the parallel BLAS.
* [Example 2](Example2) Speeding up residuals using the R package `parallel`.
* [Example 3](Example3) Submitting Makefiles to the queue: A toy example.
