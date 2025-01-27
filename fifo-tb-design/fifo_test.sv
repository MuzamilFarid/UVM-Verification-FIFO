class fifo_test extends uvm_test;

// registering with uvm_component_util
`uvm_component_utils(fifo_test)

// constructor
function new(string name="fifo_test", uvm_component parent);
super.new(name, parent);
endfunction

// Environment handle

fifo_env env;

// Two methods in test class
// Build phase is used to build the environment 
virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  env = fifo_env::type_id::create("env", this);  // building an environment
endfunction


// Sequences can be executed in the run_phase
virtual task run_phase(uvm_phase phase);
// declare sequences
fifo_rst_sequence rst_seq;
fifo_wr_sequence wr_seq;
fifo_rd_sequence rd_seq;
fifo_wr_rd_sequence wr_rd_seq;

// Create sequences first, they can also be created inside the build_phase

rst_seq   = fifo_rst_sequence::type_id::create("fifo_rst_sequence", this);
wr_seq    = fifo_wr_sequence::type_id::create("fifo_wr_sequence", this);
rd_seq    = fifo_rd_sequence::type_id::create("fifo_rd_sequence", this);
wr_rd_seq = fifo_wr_rd_sequence::type_id::create("fifo_wr_rd_sequence", this);

phase.raise_objection(this);

// execute all sequences one by one
rst_seq.start(env.agent.sequencer);
wr_seq.start(env.agent.sequencer);
rd_seq.start(env.agent.sequencer);
wr_rd_seq.start(env.agent.sequencer);
#10;
phase.drop_objection(this);

endtask

endclass
