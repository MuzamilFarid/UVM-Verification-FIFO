class fifo_env extends uvm_env;

// It extends from uvm_component
`uvm_component_utils(fifo_env)

// Instantiate agent and scoreboard in environment

fifo_agent agent;
fifo_scoreboard scoreboard;

// Constructor function

function new(string name="fifo_env", uvm_component parent);
   super.new(name,parent);
endfunction

// Two functions build phase and connect phase

// Build phase to build the components
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
agent=fifo_agent::type_id::create("agent", this);
scoreboard=fifo_scoreboard::type_id::create("scoreboard", this);
endfunction

// connect phase to connect driver to scoreboard & monitor to scoreboard together 

virtual function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
  //agent.driver.drv2scb.connect(scoreboard.item_captured);
  agent.monitor.mon2scb.connect(scoreboard.item_captured);
endfunction

endclass
