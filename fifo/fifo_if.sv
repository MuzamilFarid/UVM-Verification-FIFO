interface fifo_if(input clk); 

// Plan is to generate reset in the sequence not in the testbench
logic rst;
logic wr;
logic rd;
logic [7:0] data_in;
logic [7:0] data_out;
logic full;
logic empty;


// Clocking blocks
// Industry recommended way is to include signals in the clocking block to avoid race problems
// Clocking block is used to synchronise the signals with respect to clock edge to sample and drive signals synchronously to clock 
// The clocking block is triggered on a clock , signals inside it are withrespect to TB not DUT

// All signals driven to DUT from TB
clocking cb_d @(posedge clk);
default input #1 output #1;
output wr;
output rst; 
output rd;
output data_in;
input data_out;
input full;
input empty;

endclocking


// Clocking block for Monitor, monitoring all signals coming from DUT as input to TB
clocking cb_m @(posedge clk);

default input #1 output #1;
input wr;
input rd;
// input rst;  // Dont include in clocking blocks, instead include it inside the modport
input data_in;
input data_out;
input full;
input empty;
endclocking




// Two modports
modport d_mp (input clk, rst, clocking cb_d);
modport m_mp (input clk, rst,  clocking cb_m);



endinterface