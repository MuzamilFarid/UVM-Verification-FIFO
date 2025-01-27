class fifo_agent extends uvm_agent;

// registering with factory
`uvm_component_utils(fifo_agent);
// constructor
function new (string name="fifo_agent", uvm_component parent);
super.new(name, parent);
endfunction

// Declare sequencer, driver, monitor
fifo_sequencer sequencer;
fifo_driver    driver;
fifo_monitor   monitor;

// Two methods build_phase and connect_phase in agent

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
sequencer = fifo_sequencer::type_id::create("fifo_sequencer", this);
driver    = fifo_driver::type_id::create("fifo_driver", this);
monitor   = fifo_monitor::type_id::create("fifo_monitor", this);
endfunction

virtual function void connect_phase(uvm_phase phase);
// Connect sequencer to driver
driver.seq_item_port.connect(sequencer.seq_item_export);
endfunction

endclass
