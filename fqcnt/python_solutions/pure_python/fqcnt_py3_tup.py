"""
Python IO can be made faster using either os.read or the lower level io functions

"""
#!/usr/bin/env python

class CountData:
	__slots__ = 'name', 'seq', 'qual'
	def __init__(self) -> None:
		self.name = 0
		self.seq = 0
		self.qual = 0
	

def read4lfq(fp, tall_tup):
	seq = ""
	qual = ""
	for l in fp:
		if not l.startswith("@"): raise Exception("no fq header")
		#name = l[1:].partition(" ")[0] # Name is not needed anymore
		seq = fp.readline()[:-1]
		l = fp.readline()
		if not l.startswith("+"): raise Exception("no + line")
		qual = fp.readline()[:-1]
		len_qual = len(qual)
		len_seq = len(seq)
		if len_seq != len_qual: raise Exception("diff len")
		tall_tup.name += 1
		tall_tup.seq += len_seq
		tall_tup.qual += qual and len_qual or 0 # only took ~0.1 seconds off

if __name__ == "__main__":
	import sys, gzip
	if len(sys.argv) == 1:
		print("Usage: fqcnt.py <in.fq.gz>")
		sys.exit(0)
	fn = sys.argv[1]
	if fn[-2:] == "gz":
		fp = gzip.open(fn, 'rt')
	else:
		fp = open(fn, 'r', buffering=8192)
	tally = CountData()
	read4lfq(fp, tally)
	if tally.name == 5682010 and tally.seq == 568201000 and tally.qual == 568201000:
		print('{}\t{}\t{}'.format(tally.name, tally.seq, tally.qual))
	else:
		exit(-1)
