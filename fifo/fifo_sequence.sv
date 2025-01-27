class fifo_rst_sequence extends uvm_sequence#(fifo_seq_item);

`uvm_object_utils(fifo_rst_sequence)

// Constructor
function new(string name="fifo_rst_sequence");
super.new(name);
endfunction

fifo_seq_item tr;
time start_time;
time end_time;
string time_elapse;

virtual task body();
// create a transaction item
tr = fifo_seq_item::type_id::create("tr");
 `uvm_info("1st RST Seq ", "Reset sequence starting ...", UVM_MEDIUM);
 
 start_time = $realtime; 
 start_item(tr);
 tr.rst     = 1;
 tr.wr      = 0;
 tr.rd      = 0;
 tr.data_in = 0;
 finish_item(tr);
 end_time = $realtime;
`uvm_info("1st RST Seq", " Reset sequence ending ..." , UVM_MEDIUM);
`uvm_info("Sequence_TIME", $sformatf("start time %0t & end time is %0t", start_time, end_time), UVM_MEDIUM);
endtask

endclass



class fifo_wr_sequence extends fifo_rst_sequence;
  // Registering with factory..
`uvm_object_utils(fifo_wr_sequence)

// Constrcutor function
function new(string name="fifo_wr_sequence");
super.new(name);
endfunction
// Run this sequence Loop times
int Loop=10;

fifo_seq_item tr;

virtual task body();
// create a transaction item and loop
   `uvm_info("2nd writing Seq ", "Writing into FIFO sequence starting ...", UVM_MEDIUM);
repeat(Loop) begin
tr = fifo_seq_item::type_id::create("tr");
   start_item(tr);
   assert(tr.randomize() with {wr==1;});  // keeping the write 1 and datain will be randomised
   tr.rst = 0;
   tr.rd      = 0;
   finish_item(tr);
end
   `uvm_info("2nd writing Seq ", "Writing into FIFO sequence ending ...", UVM_MEDIUM);

endtask

endclass


class fifo_rd_sequence extends fifo_rst_sequence;
  // Registering with factory..
`uvm_object_utils(fifo_rd_sequence)

// Constrcutor function
function new(string name="fifo_rd_sequence");
super.new(name);
endfunction
// Run this sequence Loop times
int Loop=10;

fifo_seq_item tr;

virtual task body();
// create a transaction item and loop
   `uvm_info("3rd Read Seq ", "Read sequence starting ...", UVM_MEDIUM);
repeat(Loop) begin
tr = fifo_seq_item::type_id::create("tr");
   start_item(tr);
   assert(tr.randomize() with {rd==1;});  // keeping the write 1 and datain will be randomised
   tr.rst = 0;
   tr.wr      = 0;
   finish_item(tr);
end
   `uvm_info("3rd Read Seq ", "Read sequence ending ...", UVM_MEDIUM);

endtask




endclass

class fifo_wr_rd_sequence extends fifo_rst_sequence;
  // Registering with factory..
`uvm_object_utils(fifo_wr_rd_sequence)

// Constrcutor function
function new(string name="fifo_wr_rd_sequence");
super.new(name);
endfunction
// Run this sequence Loop times
int Loop=10;

fifo_seq_item tr;

virtual task body();
// create a transaction item and loop
   `uvm_info("4th Write Read Seq ", "Write Read sequence starting ...", UVM_MEDIUM);
repeat(Loop) begin
tr = fifo_seq_item::type_id::create("tr");
   start_item(tr);
   assert(tr.randomize());
   tr.rst = 0;
   finish_item(tr);
end
   `uvm_info("4th Write Read Seq ", "Write Read sequence ending ...", UVM_MEDIUM);

endtask




endclass