module control(opcode, funct3, funct7, branch, memRW, ALUop, ALUsrc, regWrite, memToReg, jal, jalr);
input [6:0] opcode, funct7;
input [2:0] funct3;
output branch, memRW, ALUsrc, regWrite, memToReg, jal, jalr;
output reg [3:0] ALUop;
wire rflag, iflag, ldiflag, sflag, ujflag, beq, bne;
assign rflag = (opcode == 7'b0110011)? 1:0;
assign iflag = (opcode == 7'b0010011)? 1:0;
assign ldiflag = (opcode == 7'b0000011 && funct3 == 3'b011)? 1:0;
assign sflag = (opcode == 7'b0100011 && funct3 == 3'b010)? 1:0;
assign jalr = (opcode == 7'b1100111 && funct3 == 3'b000)? 1:0;
assign ujflag = (opcode == 7'b1101111)? 1:0;
assign beq = (branch == 1 && funct3 == 3'b000)? 1:0;
assign bne = (branch == 1 && funct3 == 3'b001)? 1:0;

assign branch = (opcode == 7'b1100011)? 1:0;
assign ALUsrc = ((rflag == 1)||(branch ==1))? 1:0;
assign regWrite = (branch == 0 && sflag == 0)? 1:0;
assign memRW = (ldiflag == 1)? 0:(sflag == 1)? 1:1'bx;
assign memToReg = (ldiflag == 1)? 1:0;
assign jal = ujflag;

always @(*) //ALU op control
begin
if({opcode, funct3, funct7} == 17'b0110011_000_0000000 || ((opcode == 7'b0010011) && funct3 == 3'b000) || sflag == 1 || ldiflag == 1)
    ALUop <= 4'b0001;
else if(jalr == 1)
    ALUop <= 4'b0001;
else if({opcode, funct3, funct7} == 17'b0110011_000_0100000)
    ALUop <= 4'b0010;
else if(((opcode == 7'b0010011) && funct3 == 3'b001))
    ALUop <= 4'b0101;
else if(((opcode == 7'b0010011) && funct3 == 3'b101 && funct7[6:1] == 6'b000000))
    ALUop <= 4'b0110;
else if(((opcode == 7'b0010011) && funct3 == 3'b101 && funct7[6:1] == 6'b010000))
    ALUop <= 4'b0111;
else if(((opcode == 7'b0010011) && funct3 == 3'b100))
    ALUop <= 4'b0000;
else if({opcode, funct3, funct7} == 17'b0110011_111_0000000 )
    ALUop <= 4'b0011;
else if({opcode, funct3, funct7} == 17'b0110011_110_0000000)
    ALUop <= 4'b0100;
else if(beq == 1)
    ALUop <= 4'b1000;
else if(bne == 1)
    ALUop <= 4'b1001;
end
endmodule