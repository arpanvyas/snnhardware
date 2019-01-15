//------------------------------------------------------------------
// This file contains the SNN Driver, Sequence and Monitor component class
// defined
// -----------------------------------------------------------------

`ifndef SNN_DRV_SEQ_MON_SV
`define SNN_DRV_SEQ_MON_SV

typedef snn_config;
typedef snn_agent;

//------------------------------------------------------------------
// SNN master driver Class
//------------------------------------------------------------------
class snn_master_drv extends uvm_driver#(snn_inp);

    `uvm_component_utils(snn_master_drv)

    virtual snn_if vif;
    snn_config cfg;

    function new(string name, uvm_component parent = null);
        super.new(name,parent);
    endfunction

    //Build Phase
    //Get the virtual interface handle from the agent (parent) or from
    //config_db
    function void build_phase(uvm_phase phase);
        snn_agent agent;
        super.build_phase(phase);
        if( $cast(agent, get_parent()) && agent != null) begin
            vif = agent.vif;
        end
        else begin
            if (!uvm_config_db#(virtual snn_if)::get(this, "", "vif", vif)) begin
                `uvm_fatal("SNN/DRV/NOVIF", "No virtual interface specified for this driver instance")
            end
        end
    endfunction

    //Run phase
    //Implement the Driver - Sequence API to get an item
    //Based on if it is Train/Test/Classify - drive on SNN interface the
    //corresponding pins
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        
    endtask: run_phase

endclass: snn_master_drv

//-----------------------------------------------------------
// SNN Sequencer Class
// Derive from uvm_sequencer and parameterize to snn_inp sequence item
//-----------------------------------------------------------
class snn_sequencer extends uvm_sequencer #(snn_inp);

    `uvm_component_utils(snn_sequencer)

    function new(input string name, uvm_component parent=null);
        super.new(name,parent);
    endfunction: new

endclass: snn_sequencer

class snn_monitor extends uvm_monitor;

    virtual snn_if.passive vif;

    //Analysis port - parameterized to snn_inp transaction
    //Monitor writes transaction objects to this port once detected on
    //interface
    uvm_analysis_port#(snn_inp) ap;

    //config class handle
    snn_config cfg;

    `uvm_component_utils(snn_monitor)

    function new(string name, uvm_component parent = null);
        super.new(name,parent);
        ap = new("ap", this);
    endfunction: new

    //Build Phase - Get handle to virtual if from agent/config_db
    virtual function void build_phase(uvm_phase phase);
        snn_agent agent;
        if( $cast(agent, get_parent()) && agent != null) begin
            vif = agent.vif;
        end
        else begin
            virtual snn_if tmp;
            if(!uvm_config_db#(virtual snn_if)::get(this, "", "snn_if", tmp)) begin
                `uvm_fatal("SNN/MON/NOVIF", "No virtual interface specified for this monitor instance")
            end
            vif = tmp;
        end
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            snn_inp tr;
            // Wait for a SETUP cycle
            do begin
                @ (this.vif.monitor_cb);
            end
        end
    endtask : run_phase

endclass: snn_monitor

`endif














