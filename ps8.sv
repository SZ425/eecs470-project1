
module ps2 (
    input        [1:0] req,
    input              en,
    output logic [1:0] gnt,
    output logic       req_up
);

    // P1 TODO: create a two-bit priority selector using if/else or assign statements

assign gnt[1] = en & req[1];
assign gnt[0] = en & req[0] & ~req[1];
assign req_up = req[1] | req[0]; 
endmodule


module ps4 (
    input        [3:0] req,
    input              en,
    output logic [3:0] gnt,
    output logic       req_up
);

    // P1 TODO: create a four-bit priority selector from three ps2 modules
    // see and4.sv for an example
    // do not use any glue logic: AND, OR, +, *, etc (indexing by bits is ok)
    // you can create new variables and index into them
    // ex:
    // ps2 my_ps2(.req(), .en(), .gnt(), .req_up());
logic [1:0] en_tmp;
logic [1:0] req_up_tmp;
ps2 left (.req(req[3:2]), .en(en_tmp[1]), .gnt(gnt[3:2]), .req_up(req_up_tmp[1]));
ps2 right (.req(req[1:0]), .en(en_tmp[0]), .gnt(gnt[1:0]), .req_up(req_up_tmp[0]));
ps2 top (.req(req_up_tmp[1:0]), .en(en), .gnt(en_tmp[1:0]), .req_up(req_up));

endmodule


// P1 TODO: declare and implement a ps8 module using a combination of ps4 and ps2 modules
module ps8 (
    // input/output declarations go here
    input        [7:0] req,
    input              en,
    output logic [7:0] gnt,
    output logic       req_up
);

    // implementation goes here (this should look very similar to ps4)
logic [1:0] en_tmp;
logic [1:0] req_up_tmp;
ps4 left (.req(req[7:4]), .en(en_tmp[1]), .gnt(gnt[7:4]), .req_up(req_up_tmp[1]));
ps4 right (.req(req[3:0]), .en(en_tmp[0]), .gnt(gnt[3:0]), .req_up(req_up_tmp[0]));
ps2 top (.req(req_up_tmp[1:0]), .en(en), .gnt(en_tmp[1:0]), .req_up(req_up));


endmodule
