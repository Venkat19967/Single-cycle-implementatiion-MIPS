module PC(pcwire);
output [31:0] pcwire;
reg [31:0] pc;
initial begin
  pc=32'b00000000000000000000000000000000;

  end
assign pcwire=pc;

endmodule






module instructionmem(pc,inst);
input [31:0] pc;
output [31:0] inst;
reg [31:0] memdata [127:0];

initial begin
        memdata[0] = 32'b00100010000100010000000000001010;
        memdata[1] = 32'b00000010000100010000000000001010;
        memdata[2] = 32'b00100010000110010000000000000000;
        memdata[3] = 32'b00000010000100010000000000000000;
        memdata[4] = 32'b00100010000100010000000000001010;
        memdata[5] = 32'b00100010000000000000000000001010;
        // more instructions need to be added. For simplicity only these many are typed

        end

assign inst=memdata[pc];
endmodule









module signextend(inst,extended);
input [31:0] inst;
output [31:0] extended;
	assign extended[31:16] = 1'b0;
	assign extended[15:0] = inst[15:0];

endmodule








module splitter(inst,rs,imm2);
input [31:0] inst;
output [4:0] rs;
reg [4:0] rt;
wire [15:0]imm;
output [31:0] imm2;

assign rs = inst[25:21];
//assign rt = inst[20:16];
assign imm = inst[25:21];

signextend in(inst,imm2);

endmodule





















module registerfile(rs,imm,out1,out2);
input [4:0] rs;
input [31:0] imm;
output [31:0] out1;
output [31:0] out2;
reg [31:0] regmem [31:0];

initial begin
	      regmem[0]  = 32'b00000000000000000000000000000010;
        regmem[1]  = 32'b00000000000000000000000000000001;
        regmem[2]  = 32'b00000000000000000000000000001000;
        regmem[3]  = 32'b00000000000000000000000000000110;
        regmem[4]  = 32'b00000000000000000000000001000000;
        regmem[5]  = 32'b00000000000000000000000000100000;
        regmem[6]  = 32'b00000000000000000000000000010000;
        regmem[7]  = 32'b00000000000000000000001000000000;
        regmem[8]  = 32'b00000000000000000000000010000000;
        regmem[9]  = 32'b00000000000000000000000000100000;
        regmem[10] = 32'b00000000000000000000010000000000;
        regmem[11] = 32'b00000000000000000000000100000000;
        regmem[12] = 32'b00000000000000000000000000010010;
        regmem[13] = 32'b00000000000000000000000010100000;
        regmem[14] = 32'b00000000000000000000000000111000;
        regmem[15] = 32'b00000000000000000000011001000000;
        regmem[16] = 32'b00000000000000000000000000001010;
        regmem[17] = 32'b00000000000000000000000000010000;
        regmem[18] = 32'b00000000000000000000000010100000;
        regmem[19] = 32'b00000000000000000000000001000000;
        regmem[20] = 32'b00000000000000000000000101000000;
        regmem[21] = 32'b00000011110000000010000000000000;
        regmem[22] = 32'b00000000000000000001000000000000;
        regmem[23] = 32'b00000000000000000000100000000000;
        regmem[24] = 32'b00000000000000001000000100000000;
        regmem[25] = 32'b00000000000000001100100000000000;
        regmem[26] = 32'b00000000000000000000000100000000;
        regmem[27] = 32'b00000000000000000100100000000000;
        regmem[28] = 32'b00000000000000000000100001000000;
        regmem[29] = 32'b00000000000000000000000100010000;
        regmem[30] = 32'b00000000000010100010000000000000;
        regmem[31] = 32'b00000000000000010000100101100000;

	end
  assign out1 = regmem[rs];
  assign out2 = imm;

  endmodule












  module onebitadder(x,y,sum,carryout,carryin);
  input x,y,carryin;
  output sum,carryout;

          //sum = x XOR y XOR z, where z is carry in
          //carryout = x XOR y multiplied by z plus xy

  xor XOR1(p,x,y);
  xor XOR2(sum,p,carryin);
          //At this stage, we have sum with us

  and ANDp(q,p,carryin);
  and ANDxy(r,x,y);
  or ORing(carryout,q,r);
          //At this stage, we have carryout also with us

  endmodule











  module thirtytwobitadder(a,b,carryout,s,carryin);

  input carryin;
  input [31:0] a;
  input [31:0] b;
  output carryout;
  output [31:0] s;

  onebitadder adder0(a[0],b[0],s[0],c1,carryin);
  onebitadder adder1(a[1],b[1],s[1],c2,c1);
  onebitadder adder2(a[2],b[2],s[2],c3,c2);
  onebitadder adder3(a[3],b[3],s[3],c4,c3);
  onebitadder adder4(a[4],b[4],s[4],c5,c4);
  onebitadder adder5(a[5],b[5],s[5],c6,c5);
  onebitadder adder6(a[6],b[6],s[6],c7,c6);
  onebitadder adder7(a[7],b[7],s[7],c8,c7);
  onebitadder adder8(a[8],b[8],s[8],c9,c8);
  onebitadder adder9(a[9],b[9],s[9],c10,c9);
  onebitadder adder10(a[10],b[10],s[10],c11,c10);
  onebitadder adder11(a[11],b[11],s[11],c12,c11);
  onebitadder adder12(a[12],b[12],s[12],c13,c12);
  onebitadder adder13(a[13],b[13],s[13],c14,c13);
  onebitadder adder14(a[14],b[14],s[14],c15,c14);
  onebitadder adder15(a[15],b[15],s[15],c16,c15);
  onebitadder adder16(a[16],b[16],s[16],c17,c16);
  onebitadder adder17(a[17],b[17],s[17],c18,c17);
  onebitadder adder18(a[18],b[18],s[18],c19,c18);
  onebitadder adder19(a[19],b[19],s[19],c20,c19);
  onebitadder adder20(a[20],b[20],s[20],c21,c20);
  onebitadder adder21(a[21],b[21],s[21],c22,c21);
  onebitadder adder22(a[22],b[22],s[22],c23,c22);
  onebitadder adder23(a[23],b[23],s[23],c24,c23);
  onebitadder adder24(a[24],b[24],s[24],c25,c24);
  onebitadder adder25(a[25],b[25],s[25],c26,c25);
  onebitadder adder26(a[26],b[26],s[26],c27,c26);
  onebitadder adder27(a[27],b[27],s[27],c28,c27);
  onebitadder adder28(a[28],b[28],s[28],c29,c28);
  onebitadder adder29(a[29],b[29],s[29],c30,c29);
  onebitadder adder30(a[30],b[30],s[30],c31,c30);
  onebitadder adder31(a[31],b[31],s[31],carryout,c31);

  endmodule









  module ALU(out1,out2,ans);
  input [31:0] out1;
  input [31:0] out2;
  output [31:0] ans;
  wire carryout;
  wire carryin;
  assign carryin=0;
  thirtytwobitadder hello(out1,out2,carryout,ans,carryin);
  endmodule



module addi(ans);
output [31:0] ans;

wire [31:0] pcwire;
wire [31:0] pc;
wire [31:0] inst;
wire [4:0] rs;
wire [31:0]imm;
wire [31:0] out1;
wire [31:0] out2;
wire [31:0] ans;


PC i1(pcwire);
instructionmem i2(pcwire,inst);
splitter i3(inst,rs,imm);
registerfile in4(rs,imm,out1,out2);
ALU in5(out1,out2,ans);
initial
    begin

      $monitor("\n---------------------------------------------------------------------\nADDI Instruction using single cycle implementation:\n\nrs value = %b\nSign extended immediate value = %b\nrt value = %b\n---------------------------------------------------------------------\n",out1,imm,ans);
      $finish ;
    end
endmodule
