//A few flavours of snn sequences

`ifndef SNN_SEQUENCES_SV
`define SNN_SEQUENCS_SV


//----------------------------------------------
// Base SNN sequence derived from uvm_sequence and parameterized with sequence
// item of type snn_inp
//----------------------------------------------
class snn_base_seq extends uvm_sequence#(snn_inp);
    
    `uvm_object_utils(snn_base_seq)

    function new(string name = "");
        super.new(name);
    endfunction


    //Main Body method that gets executed once sequence is started
    task body();
        snn_inp inp_trans;
        //Create 10 constrained random SNN input transaction and send to
        //driver
        repeat(10) begin
            inp_trans = snn_inp::type_id::create(.name("inp_trans"),.contxt(get_full_name()));
            start_item(inp_trans);
            assert (inp_trans.randomize());
            finish_item(inp_trans);
        end
    endtask

endclass

`endif
