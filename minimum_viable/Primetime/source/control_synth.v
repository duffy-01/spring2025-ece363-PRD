/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : W-2024.09-SP2
// Date      : Wed Apr  9 18:32:52 2025
/////////////////////////////////////////////////////////////


module control ( instruction, pc_src, mem_write, alu_control, alu_src, imm_src, 
        reg_write, result_src, atomic_flag, reserved_flag, clk);
  input [31:0] instruction;
  input clk;
  output [3:0] alu_control;
  output [1:0] imm_src;
  output pc_src, mem_write, alu_src, reg_write, result_src, atomic_flag,
         reserved_flag;
  wire   N119, N120, N121, N124, N125, n1, n2, n3, n4, n11, n12, n13, n15, n16,
         n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33,
         n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47,
         n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61,
         n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72;
  assign pc_src = 1'b0;
  assign alu_control[3] = 1'b0;

  DFF_X1 \alu_control_reg[0] ( .CK(clk), .D(N119), .Q(alu_control[0]) );
  DFF_X1 \alu_control_reg[1] ( .CK(clk), .D(N118), .Q(alu_control[1]) );
  DFF_X1 \alu_control_reg[2] ( .CK(clk), .D(N117), .Q(alu_control[2]) );
  DFF_X1 reserved_flag_reg   ( .CK(clk), .D(N116), .Q(reserved_flag) );
  NAND3_X1 U56 ( .A1(n51), .A2(n53), .A3(n27), .ZN(n26) );
  NAND3_X1 U57 ( .A1(n62), .A2(n15), .A3(n29), .ZN(n22) );
  NAND3_X1 U58 ( .A1(n15), .A2(n49), .A3(n30), .ZN(n21) );
  NAND3_X1 U59 ( .A1(instruction[0]), .A2(n16), .A3(instruction[1]), .ZN(n23)
         );
  NAND3_X1 U60 ( .A1(n70), .A2(n55), .A3(n41), .ZN(n40) );
  NAND3_X1 U61 ( .A1(n64), .A2(n31), .A3(n54), .ZN(n24) );
  NAND3_X1 U62 ( .A1(n55), .A2(n57), .A3(n69), .ZN(n37) );
  INV_X1 U63 ( .A(instruction[2]), .ZN(n49) );
  INV_X1 U64 ( .A(n49), .ZN(n50) );
  INV_X1 U65 ( .A(instruction[12]), .ZN(n51) );
  INV_X1 U66 ( .A(n51), .ZN(n52) );
  INV_X1 U67 ( .A(instruction[14]), .ZN(n53) );
  INV_X1 U68 ( .A(n53), .ZN(n54) );
  INV_X1 U69 ( .A(instruction[30]), .ZN(n55) );
  INV_X1 U70 ( .A(n55), .ZN(n56) );
  INV_X1 U71 ( .A(instruction[31]), .ZN(n57) );
  INV_X1 U72 ( .A(n57), .ZN(n58) );
  INV_X1 U73 ( .A(instruction[3]), .ZN(n59) );
  INV_X1 U74 ( .A(n59), .ZN(n60) );
  INV_X1 U75 ( .A(instruction[5]), .ZN(n61) );
  INV_X1 U76 ( .A(n61), .ZN(n62) );
  INV_X1 U77 ( .A(instruction[13]), .ZN(n63) );
  INV_X1 U78 ( .A(n63), .ZN(n64) );
  INV_X1 U79 ( .A(instruction[27]), .ZN(n65) );
  INV_X1 U80 ( .A(n65), .ZN(n66) );
  INV_X1 U81 ( .A(instruction[4]), .ZN(n67) );
  INV_X1 U82 ( .A(n67), .ZN(n68) );
  INV_X1 U83 ( .A(instruction[29]), .ZN(n69) );
  INV_X1 U84 ( .A(n69), .ZN(n70) );
  INV_X1 U85 ( .A(instruction[28]), .ZN(n71) );
  INV_X1 U86 ( .A(n71), .ZN(n72) );
  INV_X1 U87 ( .A(atomic_flag), .ZN(n12) );
  NAND2_X1 U88 ( .A1(n20), .A2(n11), .ZN(reg_write) );
  INV_X1 U89 ( .A(result_src), .ZN(n11) );
  OR2_X1 U90 ( .A1(imm_src[0]), .A2(imm_src[1]), .ZN(alu_src) );
  INV_X1 U91 ( .A(n37), .ZN(n4) );
  NOR2_X1 U92 ( .A1(n38), .A2(n23), .ZN(atomic_flag) );
  NAND2_X1 U93 ( .A1(n12), .A2(n21), .ZN(result_src) );
  INV_X1 U94 ( .A(n23), .ZN(n15) );
  NAND2_X1 U95 ( .A1(n22), .A2(n12), .ZN(mem_write) );
  NAND2_X1 U96 ( .A1(n20), .A2(n21), .ZN(imm_src[0]) );
  INV_X1 U97 ( .A(n22), .ZN(imm_src[1]) );
  NAND2_X1 U98 ( .A1(n31), .A2(n15), .ZN(n20) );
  OAI22_X1 U99 ( .A1(n43), .A2(n38), .B1(n24), .B2(n51), .ZN(N120) );
  NOR3_X1 U100 ( .A1(n44), .A2(n32), .A3(n45), .ZN(n43) );
  NOR3_X1 U101 ( .A1(n1), .A2(n69), .A3(n55), .ZN(n44) );
  AND2_X1 U102 ( .A1(n46), .A2(n69), .ZN(n32) );
  NOR2_X1 U103 ( .A1(n35), .A2(n1), .ZN(n33) );
  INV_X1 U104 ( .A(n41), .ZN(n1) );
  NOR2_X1 U105 ( .A1(n12), .A2(n36), .ZN(N124) );
  INV_X1 U106 ( .A(n34), .ZN(n2) );
  INV_X1 U107 ( .A(n36), .ZN(n3) );
  OR4_X1 U108 ( .A1(n61), .A2(n59), .A3(n49), .A4(n68), .ZN(n38) );
  NOR3_X1 U109 ( .A1(n60), .A2(n62), .A3(n68), .ZN(n30) );
  INV_X1 U110 ( .A(instruction[6]), .ZN(n16) );
  NOR3_X1 U111 ( .A1(n50), .A2(n68), .A3(n60), .ZN(n29) );
  AND4_X1 U112 ( .A1(n68), .A2(n49), .A3(n59), .A4(n61), .ZN(n31) );
  NOR4_X1 U113 ( .A1(n57), .A2(n66), .A3(n72), .A4(n56), .ZN(n46) );
  NOR3_X1 U114 ( .A1(n37), .A2(n72), .A3(n65), .ZN(n45) );
  NOR3_X1 U115 ( .A1(n42), .A2(n45), .A3(n47), .ZN(n34) );
  AND4_X1 U116 ( .A1(n35), .A2(n72), .A3(n65), .A4(n57), .ZN(n47) );
  OAI221_X1 U117 ( .B1(n23), .B2(n24), .C1(n25), .C2(n12), .A(n26), .ZN(N125)
         );
  NOR4_X1 U118 ( .A1(n32), .A2(n3), .A3(n33), .A4(n2), .ZN(n25) );
  NOR3_X1 U119 ( .A1(n72), .A2(n58), .A3(n66), .ZN(n41) );
  OAI22_X1 U120 ( .A1(n34), .A2(n38), .B1(n52), .B2(n24), .ZN(N119) );
  NOR2_X1 U121 ( .A1(n55), .A2(n70), .ZN(n35) );
  AOI21_X1 U122 ( .B1(n39), .B2(n40), .A(n38), .ZN(N121) );
  NOR2_X1 U123 ( .A1(n32), .A2(n42), .ZN(n39) );
  OAI21_X1 U124 ( .B1(n64), .B2(n20), .A(n28), .ZN(n27) );
  OAI21_X1 U125 ( .B1(n13), .B2(imm_src[1]), .A(n64), .ZN(n28) );
  INV_X1 U126 ( .A(n21), .ZN(n13) );
  NAND2_X1 U127 ( .A1(n72), .A2(n4), .ZN(n36) );
  AND2_X1 U128 ( .A1(n70), .A2(n46), .ZN(n42) );
  AND3_X1 U129 ( .A1(n72), .A2(n65), .A3(n4), .ZN(n48) );
endmodule

