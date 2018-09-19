# Automated Version Controlled NIOS Hello World

## Introduction
This project is based on the `hello_world_small` design example for the Intel Cyclone 10 LP development board kit that can be found [here](https://fpgacloud.intel.com/devstore/platform/17.0.0/Standard/cyclone-10-lp-nios-ii-hello-world-design/).

The main purpose of this project is to demonstrate a possible structure and workflow with 2 main advantages:

* All build products of all components are ignored by git. This includes:
	* Quartus project and outputs
	* QSys outputs
	* NIOS project and outputs
* In order to build everything from scratch, one has to only type `make` into his terminal. This is also sensitive to source code changes and is done in an incremental fashion.

## Environment
The environment used in the development of this project is as follows:

* Lubuntu 17.10
	* Over Windows 10 VirtualBox 5.2.0
	* __Note__: This might not work out of the box on Windows, since some Quartus command line tools didn't work as expected.
* Quartus 18.0 Lite
	* The PATH variable was updated with the following directories:
		* `{QUATUS_INSTALLATION_PATH}/quartus/bin`
		* `{QUATUS_INSTALLATION_PATH}/quartus/sopc_builder/bin`
		* `{QUATUS_INSTALLATION_PATH}/nios2eds/bin`
		* `{QUATUS_INSTALLATION_PATH}/nios2eds/sdk2/bin`
	* For burning the FPGA the USB blaster drivers have to be installed as well. This could be done following the instructions [here](http://www.fpga-dev.com/altera-usb-blaster-with-ubuntu/).
* GNU Make 4.1
* python 2.7.14

## Structure
The project is built in the following tree:
```
|-- build           - Non Version Controlled Files (Generated)
  |-- nios          - NIOS Projects (BSP + APP)
  |-- pnr           - Quartus Project
  |-- qsys          - QSys Generated Files
|-- src             - Version Controlled Files (Sources)
  |-- nios          - C Source Code
  |-- pnr           - Quartus Project Management
    |-- burning     - FPGA Burning Capability via Makefile
    |-- project     - TCL and python for project creation
  |-- qsys          - QSys Source
  |-- rtl           - RTL Source Files
|-- .gitignore      - .gitignore of the repository
|-- Makefile        - Main Makefile
|-- README.md       - This File
```

## Building the Project
In order to build the project, use the main Makefile in the root directory of the project. `make`, `make all` or `make compile` build everything from scratch, but don't burn to the FPGA. `make burn` makes sure the compilation is up to date and then burns the`.sof` file. `make burn_only` assumes the `.sof` file exists and is up to date.

Given below is the full list of targets. Some of them such as `qsys_gen` are "partial" targets, meaning they only preform part of the compilation process.

* `all`: Same as compile.
* `burn_only`: Burns the existing `.sof`.
* `burn`: Calls `compile` and burns the `.sof`.
* `compile`: Compiles the Quartus project.
* `quartus_proj`: Builds the Quartus project.
* `mem_init_generate`: Creates and compiles the NIOS `hello_world_small` design example.
* `qsys_gen`: Generates the QSys output files.
* `clean`: Cleans output files of all processes.
* `clean_all`: Removes the build directory.

### Inner Makefiles
Every folder under the `src` folder (except for `rtl`) has a Makefile of its own that is responsible for building its outputs. In this subsection a more extensive description of each Makefile action is given:

* NIOS Makefile:
	* Checks that QSys `.sopcinfo` file is up to date and calls QSys Makefile if not.
	* Creates the `hello_world_small` software example design BSP and APP projects.
	* Updates the APP project's Makefile to look for sources in the `src/nios` directory recursively.
	* Compiles the code and generates an `.elf` file that can be injected into the FPGA.
	* Compiles the code and generates a `.qip` file that can be compiled along with the RTL in the Quartus project.
		* __Note__: The project currently compiles the software with the RTL, and changing that reqires changing the QSys.
* QSys Makefile:
	* Generates QSys output files including the `.sopcinfo` and `.qip` files.
* PNR/Project Makefile:
	* Gathers RTL source files into a `.tcl` file.
	* Creates a Quartus project.
	* Imports settings using the `main.tcl` script.
		* Global settings
		* Pinout
		* Source files
	* Checks that QSys `.qip` file is up to date and calls QSys Makefile if not.
	* Checks that NIOS `.qip` file is up to date and calls NIOS Makefile if not.
	* Compiles the project.
* PNR/Burning Makefile:
	* Checks that the `.sof` file is up to date and calls PNR/Project Makefile if not.
	* Burns the `.sof` file to the FPGA.
		* There is a target called `fast_burn` that burns the image w/o rebuilding the `.sof`.
	* __Note__: This Makefile contains the explicit name of the cable as shown by running `jtagconfig` in the variable `PGM_FLAGS`. This value may change depending on the environment, and so the makefile should be updated accordingly.
```
jtagconfig
1) Cyclone 10 LP Evaluation Kit [1-1]
  020F30DD   10CL025(Y|Z)/EP3C25/EP4CE22
  020D10DD   VTAP10
```
