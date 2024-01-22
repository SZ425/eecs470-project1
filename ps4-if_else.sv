
module ps4 (
    input        [3:0] req,
    input              en,
    output logic [3:0] gnt
);

    // P1 TODO: use a chain of if/else statements to create the selector
    // do not use any assign statements
    // ex:
    // always_comb begin
    //     if (a) begin
    //         out = 16'hDEAD;
    //     end else if (b) begin
    //         out = 16'hBEEF;
    //     end else if (c || d) begin
    //         out = 16'hFACE;
    //     end else begin
    //         out = 16'hB00C;
    //     end
    // end
  always_comb begin 
          if (en == 1 && req [3] == 1 ) begin
               gnt[3:0] = 4'b1000;
          end else if (en == 1 && req [2] == 1) begin
               gnt[3:0] = 4'b0100;
          end else if (en == 1 && req [1] == 1) begin
               gnt[3:0] = 4'b0010;      
          end else if (en == 1 && req [0] == 1) begin
               gnt[3:0] = 4'b0001; 
          end else begin
               gnt[3:0] = 4'b0000;
         end 
  end 
endmodule
