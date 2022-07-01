# A new makefile to test times not to run builds
# all commands need to be run with hyperfine

TIMER=hyperfine
TIMER_FLAGS=--min-runs 10
PYPY=pypy3
PYTHON=python3
DATA=biofast-data-v1/M_abscessus_HiSeq.fq

all: python_normal pypy_normal go_fqcnt nim_fqcnt luajit_fqcnt

python_normal:
	$(TIMER) $(TIMER_FLAGS) '$(PYTHON) fqcnt/fqcnt_py1_4l.py $(DATA)'

pypy_normal:
	$(TIMER) $(TIMER_FLAGS) '$(PYPY) fqcnt/fqcnt_py1_4l.py $(DATA)'

go_fqcnt:
	$(TIMER) $(TIMER_FLAGS) 'fqcnt/fqcnt_go1 $(DATA)'

nim_fqcnt:
	$(TIMER) $(TIMER_FLAGS) 'fqcnt/fqcnt_nim1_klib $(DATA)'

luajit_fqcnt:
	$(TIMER) $(TIMER_FLAGS) 'fqcnt/fqcnt_lua2_4l.lua $(DATA)'

