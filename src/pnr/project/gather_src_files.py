#!/usr/bin/python

import os
import os.path

types = {
	"vhd": "VHDL_FILE",
	"vhdl": "VHDL_FILE",
	"v": "VERILOG_FILE",
	"sv": "SYSTEMVERILOG_FILE"
}

command_prefix = "set_global_assignment -name "

def top_level_to_str(top):
	return "set_global_assignment -name TOP_LEVEL_ENTITY " + top + "\n"

def qip_to_str(qip):
	return "set_global_assignment -name QIP_FILE " + os.path.abspath(qip) + "\n"

def srcs_to_str(src_path):
	out = ""
	for root, _, files in os.walk(src_path):
		for f in files:
			path = os.path.abspath(os.path.join(root, f))
			extension = os.path.splitext(f)[-1]
			extension = extension[1 :]
			if extension in types.keys():
				out += command_prefix + types[extension] + " " + path + "\n"

	return out

def main(src_path, top, qsys=None, meminit=None, output_file="files.tcl"):
	out = top_level_to_str(top)
	if qsys is not None:
		out += qip_to_str(qsys)
	if meminit is not None:
		out += qip_to_str(meminit)
	out += srcs_to_str(src_path)

	with open(output_file, "w") as f:
		f.write(out)

if __name__ == "__main__":
	import argparse

	ap = argparse.ArgumentParser()
	ap.add_argument("src_path")
	ap.add_argument("-t, --top", required=True, dest="top")
	ap.add_argument("-q, --qsys-qip", required=False, dest="qsys")
	ap.add_argument("-m, --meminit-qip", required=False, dest="meminit")
	ap.add_argument("-o, --output-file", required=False, default="files.tcl", dest="output_file")
	args = ap.parse_args()

	main(args.src_path, args.top, args.qsys, args.meminit, args.output_file)
