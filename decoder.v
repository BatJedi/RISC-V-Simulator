module decoder(inst, opcode, funct7, funct3, rs1, rs2, rd);
input [31:0] inst;
output [6:0] opcode, funct7;
output[2:0] funct3;
output [4:0] rs1, rs2, rd;
assign opcode = inst[6:0];
assign funct7 = inst[31:25];
assign funct3 = inst[14:12];
assign rs1 = inst[19:15];
assign rs2 = inst[24:20];
assign rd = inst[11:7];
endmodule