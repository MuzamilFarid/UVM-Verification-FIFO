VLOG = vlog
VOPT = vopt 
VSIM = vsim 
TOP_MODULE = fifo_tb
OPTIMIZED_MODULE = fifo_opt
FILELIST = filelist.f

all: compile simulate
#The line which are shell syntax and are passed to shell for parsing, basically a shell command must begin with TAB, In this case vlog, vopt,vsim will execute inside the Questa shell
#The lines which are make syntax such as rules e.g -> compile:, optimize:, simulate: they can be indented with a space or a TAB
compile: 
	@echo "Running vlog to compile...."
	$(VLOG) -sv -f $(FILELIST)

optimize: 
	@echo "Running vopt to optimize to generate executable for the simulation...." 
	$(VOPT) +acc $(TOP_MODULE) -o $(OPTIMIZED_MODULE)	 

simulate: optimize
	@echo "Running vsim to load the simulator....." 
	$(VSIM) $(OPTIMIZED_MODULE)