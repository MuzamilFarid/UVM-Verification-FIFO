class fifo_seq_item extends uvm_sequence_item;
// uvm_sequence_item is of object type
`uvm_object_utils(fifo_seq_item)


// declare the inputs to DUT as rand
  //declare rst also in sequence item because it will be a part of sequence
logic rst;
rand logic wr;
rand logic rd;
rand logic [7:0] data_in;
logic [7:0] data_out;
logic full;
logic empty;

// constraint that wr is not equal to rd
constraint wrrdchk  {wr != rd;}

// constructor function

function new(string name="fifo_seq_item");
super.new(name);
endfunction

endclass
