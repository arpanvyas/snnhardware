//------------------------------------------------------------------------------
// Top level Test Module
// Includes all env component and sequence files
//      (one could ideally create an env package and import that as well
//      instead of including)
//------------------------------------------------------------------------------

import uvm_pkg::*;
`include "uvm_macros.svh"

//Include all files
`include "snn_if.svh"
`include "snn_inp.svh"
`include "snn_driver_seq_mon.svh"
`include "snn_agent_env_config.svh"
`include "snn_sequences.svh"
`include "snn_test.svh"

//-------------------------------------------------------------------
// Top level module that instantiates physical snn insterface
// and SNN DUT
//-------------------------------------------------------------------

module test;

    logic           clk;

//    logic           rst;
//    logic           start_main;
//    logic [1:0]     train_test_classify;
//    logic [7:0]     test_label;
//    logic [31:0]    image_in;
//    logic           valid_image;
//    logic [31:0]    weight_in;
//    logic           ready;
//    logic [7:0]     image_label;
//    logic           start_core_img;
//    logic           valid_all;
    
    initial begin
        clk = 0;
    end

    //Generate a clock
    always begin
        #5 clk = ~clk;
    end

    //Instantiate a physical interface for SNN interface
    snn_if  snn_if(.clk(clk));

    train_test_classify DUT (
        .clk(snn_if.clk),
        .rst(snn_if.rst),
        .start_main(snn_if.start_main),
        .train_test_classify(snn_if.train_test_classify),
        .image_in(snn_if.image_in),
        .valid_image(snn_if.valid_image),
        .weight_in(snn_if.weight_in),
        .ready(snn_if.ready),
        .image_label(snn_if.image_label),
        .start_core_img(snn_if.start_core_img),
        .valid_all(snn_if.valid_all)
    );


    initial begin
        //Pass this physical interface to test top (which will further pass it
        //down to env->agent->drv/sqr/mon
        uvm_config_db#(virtual snn_if)::set( null, "uvm_test_top", "vif", snn_if);
        //Call the test - but passing run_test argument as test class name
        //Another option is to not pass any test argument and use +UVM_TEST no
        //command line to specify which test to run
        run_test("snn_base_test");

    end


    endmodule
