//---------------------------------------------------------------------------
// Basic SNN Input Image Transaction class definition
//     This transaction will be used by Sequences, Drivers and Monitors
//
//---------------------------------------------------------------------------
`ifdef SNN_INP_SV
 `define SNN_INP_SV


 import uvm::pkg*;

 class snn_inp extends uvm_sequence_item;

     //typedef for Train/Test/Classify transaction type
     typedef enum{TRAIN, TEST, CLASSIFY} kind_e;
     logic [783:0][7:0] image_inp;
     logic [1:0]  train_test_classify;
     logic [7:0]  test_label;
     kind_e       snn_cmd;

    //Register with factory for dyanmic creation
    `uvm_object_utils(snn_inp)

    function new (string name = "snn_inp");
        super.new(name);
    endfunction

    function string convert2string();
        return $psprintf("kind=%s", snn_cmd);
    endfunction

    function image_inp(string path);
        $readmemb(path,image_inp);
    endfunction

endclass: snn_if


`endif
    
