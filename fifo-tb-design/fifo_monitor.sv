class fifo_monitor extends uvm_monitor;

`uvm_component_utils(fifo_monitor)

// constructor
function new(string name="fifo_monitor", uvm_component parent);
super.new(name,parent);
endfunction

//Virtual interface

virtual fifo_if fif;

uvm_analysis_port#(fifo_seq_item) mon2scb;


// Two methods, build_phase and run_phase

function void build_phase(uvm_phase phase);
super.build_phase(phase);

// Retrieve the interface from the top 
if (!(uvm_config_db#(virtual fifo_if)::get(this, "", "vif", fif))) begin
`uvm_fatal("Monitor-Error","Unable to get the interface ");
end

// create a analysis port handle
mon2scb = new("mon2scb", this);

endfunction


// capture data from DUT
 task run_phase(uvm_phase phase);
// creating a packet of sequence item
fifo_seq_item pkt = fifo_seq_item::type_id::create("pkt", this);

// This always run forever in both monitor and driver
forever begin
    // Task sample_dut
    sample_dut(pkt);
    mon2scb.write(pkt); // write function of scorebaord, after sampling data from DUT, scoreboard will do something in write  function..
end

endtask


task sample_dut(fifo_seq_item pkt);

fifo_seq_item t = fifo_seq_item::type_id::create("t", this);

@(fif.cb_m)
t.wr        = fif.cb_m.wr;
t.rd        = fif.cb_m.rd;
t.data_in   = fif.cb_m.data_in;
t.data_out  = fif.cb_m.data_out;
t.full      = fif.cb_m.full;
t.empty     = fif.cb_m.empty;
pkt         = t;
endtask


endclass
