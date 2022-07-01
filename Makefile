# A new makefile to test times not to run builds
# all commands need to be run with hyperfine

TIMER=hyperfine
TIMER_FLAGS=--min-runs 10
PYPY=pypy3
PYTHON=python3
DATA=biofast-data-v1/M_abscessus_HiSeq.fq

all: jl_fqcnt c1_fqcnt python_normal pypy_normal go_fqcnt nim_fqcnt

python_normal:
	$(TIMER) $(TIMER_FLAGS) '$(PYTHON) fqcnt/fqcnt_py1_4l.py $(DATA)'

pypy_normal:
	$(TIMER) $(TIMER_FLAGS) '$(PYPY) fqcnt/fqcnt_py1_4l.py $(DATA)'

go_fqcnt:
	$(TIMER) $(TIMER_FLAGS) 'fqcnt/fqcnt_go1 $(DATA)'

nim_fqcnt:
	$(TIMER) $(TIMER_FLAGS) 'fqcnt/fqcnt_nim1_klib $(DATA)'

# Having luajit issues
#luajit_fqcnt:
#	$(TIMER) $(TIMER_FLAGS) 'fqcnt/fqcnt_lua2_4l.lua $(DATA)'

c1_fqcnt:
	$(TIMER) $(TIMER_FLAGS) 'fqcnt/fqcnt_c1_kseq $(DATA)'

# Added a prepare command to pre compile the julia file so compilation is not part of run time
jl_fqcnt:
	$(TIMER) $(TIMER_FLAGS) --prepare 'fqcnt/fqcnt_jl1_klib.jl' 'fqcnt/fqcnt_jl1_klib.jl $(DATA)'