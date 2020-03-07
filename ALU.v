module ALU(a, b, out, op, ALUzero); 
input [63:0] a, b; 
output reg [63:0] out; 
output reg ALUzero;
input [3:0] op;   
always @(*)    
begin     
case(op)
(4'b0000): //XOR
    out <= a^b;       
(4'b0001): //ADD             
    out <= a + b;         
(4'b0010): //Subtract             
    out <= a - b;
(4'b0011): //AND
    out <= a&b;
(4'b0100): //OR
    out <= a|b;
(4'b0101): //shift a left by b
    out <= a << b;
(4'b0110): //shift right a by b
    out <= a >> b;
(4'b0111): //signed shift right
    out <= $signed(a) >>> b;
(4'b1000): //equality
    ALUzero = (a==b)? 1:0;
(4'b1001): //inequality
    ALUzero = (a!=b)? 1:0;
endcase
end
endmodule