
`uvm_analysis_imp_decl( _drv)
`uvm_analysis_imp_decl( _mon)


class fifo_scoreboard extends uvm_scoreboard;

//
`uvm_component_utils(fifo_scoreboard)
//uvm analysis import, I will add 2 import ports, one for driver and one for monitor
//uvm_analysis_imp_mon#(fifo_seq_item, fifo_scoreboard) aport_mon;
//uvm_analysis_imp_drv#(fifo_seq_item, fifo_scoreboard) aport_drv;

uvm_analysis_imp#(fifo_seq_item, fifo_scoreboard) item_captured;

logic[7:0] driver_qeue[$];
logic[7:0] monitor_qeue[$];

// constructor function
function new (string name = "fifo_scoreboard", uvm_component parent);
super.new(name,parent);
`uvm_info("CONSTRUCTOR_SCB", "Constructor called", UVM_MEDIUM);
endfunction

// build_phase function

function void build_phase(uvm_phase phase);

super.build_phase(phase);
`uvm_info("SCB_BP", "Scoreboard build phase called", UVM_MEDIUM);
//aport_mon = new("aport_mon", this);
//aport_drv = new("aport_drv", this);
item_captured = new("item_captured", this);

endfunction

// Write function executed by driver, write the data_in into a qeue
// Just capture data from monitor via write function and use sequence item packet to compare in task runphase
/*
function void write_drv(fifo_seq_item tr);
`uvm_info("WR_DRV", "write drive function in scoreboard", UVM_DEBUG);
   driver_qeue.push_back(tr.data_in);
endfunction
*/

// a write function from the monitor will write sampled data_out to the qeue
function void write(fifo_seq_item tr);
`uvm_info("MON_SCB", "Data captured from monitor", UVM_MEDIUM);
//monitor_qeue.push_back(tr.data_out);
   if(tr.wr==1) begin
     driver_qeue.pushback(tr.data_in);
    end
   else if(tr.rd==1) begin
     monitor_qeue.pushback(tr.data_out);
   end

     

endfunction


task run_phase(uvm_phase phase);

/*
        if(driver_qeue.size() != monitor_qeue.size()) begin
               `uvm_info("SCB", "The Qeue sizes dont match......", UVM_MEDIUM);
        end
        else begin 
           foreach(driver_qeue[i]) begin
             if(driver_qeue[i] == monitor_qeue[i]) begin
                 `uvm_info("SCB", "DATA_IN matches DATA_OUT.....", UVM_MEDIUM);
            end
             else begin
             `uvm_info("SCB", "DATA_IN DOESNT MATCH DATA_OUT......", UVM_MEDIUM);
             end
           end
        end     

        */
      if()


   
endtask


endclass
