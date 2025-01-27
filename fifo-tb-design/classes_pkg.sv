`ifndef CLASSES_PKG
`define CLASSES_PKG

`include "uvm_macros.svh"

package classes_pkg;

 import uvm_pkg::*;

 `include "fifo_seq_item.sv"        // transaction class
 `include "fifo_sequence.sv"             // sequence class
 `include "fifo_sequencer.sv"            // sequencer class
 `include "fifo_driver.sv"               // driver class
 `include "fifo_monitor.sv"              // monitor class
 `include "fifo_agent.sv"                // agent class  
 `include "fifo_scoreboard.sv"           // scoreboard class
 `include "fifo_env.sv"                  // environment class

 `include "fifo_test.sv"                         // test1

endpackage

`endif