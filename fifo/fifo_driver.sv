class fifo_driver extends uvm_driver#(fifo_seq_item);

// Register with factory
`uvm_component_utils(fifo_driver)

// Declaring uvm analysis port
uvm_analysis_port#(fifo_seq_item) drv2scb;

// Constructor
function new(string name="fifo_driver", uvm_component parent);
super.new(name,parent);
endfunction

// Declare the virtual interface to DUT
virtual interface fifo_if fif;

// Two methods build_phase and Run_phase

// In build phase get the interface via uvm_config_db
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
if (!(uvm_config_db#(virtual fifo_if)::get(this, "", "vif", fif))) begin
`uvm_fatal("DRIVER" ,"Unable to get the interface ");
end
drv2scb = new("drv2scb",this);
endfunction

virtual task run_phase(uvm_phase phase);

 // create a sequence item
 fifo_seq_item item = fifo_seq_item::type_id::create("item");
 // initialize task to initilise the DUT
 initialize();
 forever begin
  seq_item_port.get_next_item(item);
      drive_dut(item);    // drive the generated sequence items to DUT
     // drv2scb.write_drv(item);  // drive the same data to the scoreboard
      `uvm_info("DRIVETOSCB", "Data driven to SCB from driver write function", UVM_MEDIUM);
    seq_item_port.item_done();
 end

endtask

task initialize();
fif.rst     = 0;
fif.wr      =  0;
fif.rd      =  0;
fif.data_in = 0; 
endtask

// Two tasks main_wr & main_rd
// How about just one task driving the signals to DUT?

task drive_dut(fifo_seq_item item);
   @(fif.cb_d);
   fif.cb_d.rst     <= item.rst;
   fif.cb_d.wr      <= item.wr;
   fif.cb_d.rd      <= item.rd;
   fif.cb_d.data_in <= item.data_in;
   // The skew in clocking blocks will impact how signals are driven to DUT
endtask







endclass
