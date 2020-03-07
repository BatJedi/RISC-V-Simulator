module immGen(inst, imm);
input [31:0] inst;
output reg [63:0] imm;
wire [6:0] opcode, funct7;
wire [2:0] funct3;
assign opcode = inst[6:0];
assign funct7 = inst[31:25];
assign funct3 = inst[14:12];
always @(*)
begin
    if((opcode == 7'b0000011) || (opcode == 7'b0010011 &&(funct3 != 3'b001 && funct3 != 3'b101)) || opcode == 7'b1100111)
    begin
        imm[11:0] <= inst[31:20];
        if(imm[11] == 1'b1)
            imm[63:12] <= {52{1'b1}};
        else imm[63:12] <= {52{1'b0}};
    end
    else if(opcode == 7'b0100011)
    begin
        imm[11:0] <= {funct7, inst[11:7]};
        if(imm[11] == 1'b1)
            imm[63:12] <= {52{1'b1}};
        else imm[63:12] <= {52{1'b0}};
    end
    else if(opcode == 7'b1100011)
    begin
        imm[12:0] <= {inst[31], inst[7], inst[30:25], inst[11:8], 1'b0};
        if(imm[12] == 1'b1)
            imm[63:13] <= {51{1'b1}};
        else imm[63:13] <= {51{1'b0}};
    end
    else if(opcode == 7'b1101111)
    begin
        imm[20:0] <= {inst[31], inst[19:12], inst[20], inst[30:21], 1'b0};
        if(imm[20] == 1'b1)
            imm[63:21] <= {43{1'b1}};
        else imm[63:21] <= {43{1'b0}};
    end
    if(opcode == 7'b0010011 && (funct3 == 3'b001 || funct3 == 3'b101))
    begin
        imm[5:0] <= inst[25:20];
        imm[63:6] <= {58{1'b0}};
    end
end
endmodule