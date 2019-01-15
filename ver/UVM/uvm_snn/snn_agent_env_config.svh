//-------------------------------------------------------------------
// This file contains snn config, snn_agent and snn_env class components
// ------------------------------------------------------------------
`ifndef SNN_AGENT_ENV_CFG_SV
`define SNN_AGENT_ENV_CFG_SV

//---------------------------------------------
// SNN Config class
//  Can define some configuration in it
//---------------------------------------------
class snn_config extends uvm_object;

    `uvm_object_utils(snn_config)
    virtual snn_if vif;

    function new(string name="snn_config");
        super.new(name);
    endfunction

endclass

//--------------------------------------------
// SNN Agent class
//--------------------------------------------
class snn_agent extends uvm_agent;

    //Agent will have sequencer, driver and monitor components for SNN Module
    snn_sequencer sqr;
    snn_master_drv drv;
    snn_monitor mon;

    virtual snn_if vif;

    `uvm_component_utils_begin(snn_agent)
        `uvm_field_object(sqr, UVM_ALL_ON)
        `uvm_field_object(drv, UVM_ALL_ON)
        `uvm_field_object(mon, UVM_ALL_ON)
    `uvm_component_utils_end

    function new (string name="snn_agent")
        super.new(name,parent)
    endfunction

    //Build phase of agent - construct sequencer, driver and monitor
    //get handle to virtual interface from env (parent) config_db
    //and pass handle down to sqr/driver/monitor
    virtual function void build_phase(uvm_phase phase);
        sqr = snn_sequencer::type_id::create("sqr", this);
        drv = snn_master_drv::type_id::create("drv", this);
        mon = snn_monitor::type_id::create("mon", this);

        if(!uvm_config_db#(virtual snn_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal("SNN/AGT/NOVIF","No virtual interface specified for this agent instance")
        end

        uvm_config_db#(virtual snn_if)::set( this, "sqr", "vif", vif);
        uvm_config_db#(virtual snn_if)::set( this, "drv", "vif", vif);
        uvm_config_db#(virtual snn_if)::set( this, "mon", "vif", vif);
    endfunction: build_phase

    //Connect - driver and sequencer port to export
    virtual function void connect_phase(uvm_phase phase);
        drv.seq_item_port.connect(sqr.seq_item_export);
        uvm_report_info("snn_agent::","connect_phase, Connected driver to sequencer");
    endfunction
    
endclass: snn_agent


//--------------------------------------------------------
// SNN Env class
//--------------------------------------------------------
class snn_env extends uvm_env;

    `uvm_component_utils(snn_env);

    //SNN class will have agent as its sub component
    snn_agent agt;
    //virtual interface for SNN interface
    virtual snn_if vif;

    function new(string name, uvm_component parent = null);
        super.new(name,parent);
    endfunction

    //Build phase - Construct agent and get virtual interface handle from test
    //and pass it down to agent
    function void build_phase(uvm_phase phase);
        agt = snn_agent::type_id::create("agt", this);
        if (!uvm_component_db#(virtual snn_if)::get(this, "", "vif",vif)) begin
            `uvm_fatal("SNN/AGT/NOVIF", "No virtual interface specified for this env instance")
        end

        uvm_config_db#(virtual snn_if)::set(this, "agt", "vif", vif);
    endfunction: build_phase

endclass: snn_env




`endif

    


