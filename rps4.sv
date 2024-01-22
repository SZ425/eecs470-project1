
module rps2 (
    input              sel,
    input        [1:0] req,
    input              en,

    output logic [1:0] gnt,
    output logic       req_up
);

    // P1 TODO: create a two-bit rotating priority selector using logic
assign gnt[1] = en & sel & req[1];
assign gnt[0] = en & ~sel & req[0];
assign req_up = req[1] | req[0]; 
endmodule


module rps4 (
    input              clock,
    input              reset,
    input        [3:0] req,
    input              en,

    output logic [3:0] gnt,
    output logic [1:0] count
);

    // P1 TODO: create a 4-bit rotating priority selector using rps2 modules
logic [1:0] en_tmp;
logic [1:0] req_up_tmp;
rps2 left (.req(req[3:2]), .en(en_tmp[1]), .gnt(gnt[3:2]), .sel(count[0]), .req_up(req_up_tmp[1]));
rps2 right (.req(req[1:0]), .en(en_tmp[0]), .gnt(gnt[1:0]), .sel(count[0]),.req_up(req_up_tmp[0]));
rps2 top (.req(req_up_tmp[1:0]), .en(en), .gnt(en_tmp[1:0]), .sel(count[1]));
    // P1 TODO: assign to the sequential counter, 'count', here
logic [1:0] count = 2'b00;
always_ff @(posedge clock) begin

     if (reset)begin
     count[1:0] <= 2'b00;
     end else if (!reset) begin 
     count[1:0] <= count[1:0] + 2'b01;
     end else if (count[1:0] == 2'b11) begin
     count[1:0] <= 2'b00;
     end else 
     count[1:0] <= count[1:0]+2'b01;
  
end

endmodule
