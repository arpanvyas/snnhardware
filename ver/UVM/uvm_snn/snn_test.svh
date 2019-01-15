`ifndef SNN_BASE_TEST_SV
`define SNN_BASE_TEST_SV

//--------------------------------------------------------------
// Top level Test class that instantiates env, configures and starts stimulus
//--------------------------------------------------------------
class snn_base_test extends uvm_test;

    //Register with factory
    `uvm_component_utils(snn_base_test);

    snn_env env;
    snn_config cfg;
    virtual snn_if vif;

    function new(string name = "snn_base_test", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    //Build phase - construct the cfg and env class using factory
    //Get the virtual interface handle from Test and then set it config db for
    //the env component
    function void build_phase(uvm_phase phase);
        cfg = snn_config::type_id::create("cfg",this);
        env = snn_env::type_id::create("env",this);

        if(!uvm_config_db#(virtual snn_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal("SNN/DRV/NOVIF", "No virtual interface specified for this test instance")
        end
        uvm_config_db#(virtual snn_if)::set(this, "env", "vif", vif);
    endfunction

    //Run phase - Create an snn_sequence and start it on the snn_sequencer
    task run_phase( uvm_phase phase );
        snn_base_seq snn_seq;
        snn_seq = snn_base_seq::type_id::create("snn_seq");
        phase.raise_objection( this, "Starting snn_base_seq in main phase");
        $display("%t Starting sequence snn_seq run_phase", $time);
        snn_seq.start(env.agt.sqr);
        #100ns;
        phase.drop_objection( this, "Finished snn_seq in main phase" );
    endtask: run_phase



endclass
