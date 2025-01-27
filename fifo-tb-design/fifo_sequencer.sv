class fifo_sequencer extends uvm_sequencer#(fifo_seq_item);
// uvm_sequencer inherits from uvm_component so use `uvm_component_utils()

// only constructor and registering with factory in fifo_sequencer, all the critical code is taken from uvm_sequencer
`uvm_component_utils(fifo_sequencer)

// Constructor 
function new(string name = "fifo_sequencer", uvm_component parent);
super.new(name,parent);
endfunction

endclass
