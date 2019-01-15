//--------------------------------------------------
//SNN Interface
//
//--------------------------------------------------

`ifndef SNN_IF_SV
`define SNN_IF_SV

interface snn_if(wire bit clk);
    wire        rst;
    wire        start_main;
    wire [1:0]  train_test_classify;
    wire [7:0]  test_label;
    wire [31:0] image_in;
    wire        valid_image;
    wire [31:0] weight_in;
    wire        ready;
    wire [7:0]  image_label;
    wire        start_core_img;
    wire        valid_all;


    //Master Clocking block - for Drivers
    clocking master_cb @(posedge clk);
        output rst, start_main, train_test_classify, test_label;
        output image_in, valid_image, weight_in;
        input ready, image_label, start_core_img, valid_all;
    endclocking: master_cb

    //Slave Clocking block - for any slave BFMs
    clocking slave_cb @(posedge clk);
        input rst, start_main, train_test_classify, test_label;
        input image_in, valid_image, weight_in;
        output ready, image_label, start_core_img, valid_all;
    endclocking: slave_cb

    //Monitor Clocking Block - For sampling by monitor components
    clocking monitor_cb @(posedge clk);
        input rst, start_main, train_test_classify, test_label;
        input image_in, valid_image, weight_in;
    endclocking: monitor_cb

    modport master(clocking master_cb);
    modport slave(clocking slave_cb);
    modport passive(clocking monitor_cb);


endinterface: snn_if
        
`endif SNN_IF_SV
