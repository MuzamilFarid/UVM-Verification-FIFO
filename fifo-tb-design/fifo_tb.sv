 `timescale 1ns/1ps
// Include all the uvm macros, uvm packages, classes package as done in D-FF UVM TB
`include "fifo_if.sv"

module fifo_tb;
import uvm_pkg::*;
import classes_pkg::*;

 bit clk ;
 
 initial begin
 clk <=0;
 end
 // Reset signal is already declared inside the interface and will be generated inside the driver via a sequence
 

 // Generation of clock

 always #10 clk = ~ clk;

 // Interface instance, clock is passed to interface as input

 fifo_if fif(clk); 


 // DUT instantation

 SYN_FIFO DUT(
      .clk (fif.clk),
      .reset (fif.rst),
      .data_in (fif.data_in),
      .data_out (fif.data_out),
      .wr     (fif.wr),
      .rd     (fif.rd),
      .full   (fif.full),
      .empty  (fif.empty)
);

initial begin
  // Setting the interface via UVM config db for the driver and monitor to have access, instead of null, uvm_root::get can also be used

// dumping variables
$dumpvars();
$dumpfile("dump.vcd");
end

initial begin
uvm_config_db#(virtual fifo_if)::set(null, "","vif",fif); 

end

// uvm run_test 
initial begin
run_test("fifo_test");
end


endmodule
