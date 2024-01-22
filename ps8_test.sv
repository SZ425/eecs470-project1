
// P1 TODO: create the testbench. Use ps4_test as a starting point
 
module testbench;

    logic [7:0] req;
    logic       en;
    logic [7:0] gnt;
    logic [7:0] tb_gnt;
    logic       req_up;
    logic       correct;

   
    ps8 dut(
        .req (req),
        .en  (en),
        .gnt (gnt),
        .req_up(req_up)
    );

assign tb_gnt[7] = en & req[7];
assign tb_gnt[6] = en & req[6] & ~req[7];
assign tb_gnt[5] = en & req[5] & ~req[6] & ~req[7];
assign tb_gnt[4] = en & req[4] & ~req[5] & ~req[6] & ~req[7];
assign tb_gnt[3] = en & req[3] & ~req[4] & ~req[5] & ~req[6] & ~req[7];
assign tb_gnt[2] = en & req[2] & ~req[3] & ~req[4] & ~req[5] & ~req[6] & ~req[7];
assign tb_gnt[1] = en & req[1] & ~req[2] & ~req[3] & ~req[4] & ~req[5] & ~req[6] & ~req[7];
assign tb_gnt[0]=en & req[0] & ~req[1] & ~req[2] & ~req[3] & ~req[4] & ~req[5] & ~req[6]& ~req[7];

    assign correct = (tb_gnt === gnt);

    always @(correct) begin
        #2
        if (!correct) begin
            $display("@@@ Incorrect at time %4.0f", $time);
            $display("@@@ gnt=%b, en=%b, req=%b, req_up=%b" ,gnt, en, req, req_up);
            $display("@@@ expected result=%b", tb_gnt);
            $finish;
        end
    end

    initial begin
        $monitor("Time:%4.0f req:%b en:%b gnt:%b req_up:%b", $time, req, en, gnt, req_up);

        req = 8'b00000000;
        en = 1;

        #5 req = 8'b10000000;
        #5 req = 8'b01000000;
        #5 req = 8'b00100000;
        #5 req = 8'b00010000;
        #5 req = 8'b00001000;
        #5 req = 8'b00000100;
        #5 req = 8'b01011000;
        #5 req = 8'b10011010;
        #5 req = 8'b11111111;
        #5 en = 0;
        #5 req = 8'b01100110;
        #5

        $display("@@@ Passed");
        $finish;
    end

endmodule
