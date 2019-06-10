#!/bin/bash
import sys
import os


def main():
	if len(sys.argv) < 3:
		print('USAGE: ./collect_traces output_name num_traces')
		print('Note: Modify params.dat to change the benchmark parameters')
		print('Note: Make sure start_mongo.sh is running before collecting traces...')
		exit(0)

	file_name = sys.argv[1]
	num_traces = int(sys.argv[2])

	# Parse the args for num_traces
	for i in range(0, num_traces):
		dir_name = '%s%d' % (file_name, i)
		output_name = '%s%d' % (file_name, i)
		os.system('mkdir %s' % dir_name)

		print("\n\n\nStarting trace %s\n\n\n" % output_name)

		# Invoke Box of Pain
		os.system("cd YCSB && ./bin/box-of-pain/painbox -d -e './bin/ycsb,load,mongodb,-s,-P,../params.dat' -e './bin/ycsb,run,mongodb,-s,-P,../params.dat' -s %s.boprun > %s_results.txt" % (output_name, output_name))
		
		# Save the trace data 
		os.system("mv YCSB/%s.boprun* %s" % (output_name, dir_name))
		os.system("mv YCSB/%s_results.txt %s" % (output_name, dir_name))

		# Save a copy of the params
		os.system("cp params.dat %s" % dir_name)

		# Convert the trace to a pdf
		os.system("cd %s && m4 %s.boprun.m4 > %s.boprun.dot && dot -Tpdf -o %s.boprun.pdf %s.boprun.dot" % (dir_name, output_name, output_name, output_name, output_name))	




if __name__ == '__main__':
	main()