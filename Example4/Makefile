## Use parallel BLAS for all runs
export OMP_NUM_THREADS=8

## Targets
results: $(shell grep '^results/.*:' Makefile | sed s/:.*//g)

## Get model
MODEL_FOLDER = length_based_index
$(MODEL_FOLDER):
	git clone https://github.com/DTUAqua/length_based_index.git

## Some abbreviations
COD='Gadus morhua'

## Run the model with inputs
RUN_MODEL = cd $(MODEL_FOLDER); SCRIPT_INPUT="{$(PARMS); OUTFILE='../$@'}" R --slave < model.R

## Build the model
MODEL_SRC = $(MODEL_FOLDER)/model.cpp
MODEL_BIN = $(MODEL_FOLDER)/model.so
$(MODEL_BIN) : $(MODEL_FOLDER) $(MODEL_SRC)
	echo "TMB:::compile('$(MODEL_SRC)', '-Ofast')" | R --slave

## Target 1
PARMS = { SPECIES=$(COD); QUARTER=4 }
results/cod-Q4.RData: $(MODEL_BIN)
	mkdir -p results
	$(RUN_MODEL)

## Target 2
PARMS = { SPECIES=$(COD); QUARTER=1 }
results/cod-Q1.RData: $(MODEL_BIN)
	mkdir -p results
	$(RUN_MODEL)

## Optional: Send mail when done + link to results
publish: results
	echo "Copy result files here..." > ~/public_html/results.txt
	chmod 755 ~/public_html/results.txt
	echo "Results are at www.student.dtu.dk/~"$$USER | mail -s "Results have been updated" $$USER@dtu.dk
