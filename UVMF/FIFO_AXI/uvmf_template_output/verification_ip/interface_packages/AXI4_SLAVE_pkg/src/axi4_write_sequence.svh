class axi4_slave_write_seq extends AXI4_SLAVE_sequence_base;
  `uvm_object_utils(axi4_slave_write_seq)
   AXI4_SLAVE_transaction   req;
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "axi4_slave_write_seq");
  extern task body();
endclass : axi4_slave_write_seq

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - axi4_slave_write_seq
//  intializes new memory for the object
//--------------------------------------------------------------------------------------------
function axi4_slave_write_seq::new(string name = "axi4_slave_write_seq");
  super.new(name);
endfunction : new

//-------------------------------------------------------
//Task : Body
//Creates the req of type slave transaction and randomises the req.
//-------------------------------------------------------
task axi4_slave_write_seq::body();
  req=AXI4_SLAVE_transaction::type_id::create("req");

  start_item(req);
  if(!req.randomize() with {req.bresp == WRITE_OKAY;}) begin
    `uvm_error(get_type_name(),"randomization failed");
  end
  req.print();
  finish_item(req);
endtask :body
