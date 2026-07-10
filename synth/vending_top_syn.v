/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : X-2025.06-SP2
// Date      : Fri Jul 10 00:14:00 2026
/////////////////////////////////////////////////////////////


module unidade_controle ( clk, rst, cancel, coin_in, confirm, can_sell, estado, 
        credit_load, reset_credit, mem_read, mem_write, dispense, error );
  input [1:0] coin_in;
  output [2:0] estado;
  input clk, rst, cancel, confirm, can_sell;
  output credit_load, reset_credit, mem_read, mem_write, dispense, error;
  wire   mem_write, n12, n13, n14, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10,
         n11, n15;
  assign dispense = mem_write;

  DFFX1_RVT \estado_atual_reg[0]  ( .D(n14), .CLK(clk), .Q(estado[0]), .QN(n15) );
  DFFX1_RVT \estado_atual_reg[2]  ( .D(n12), .CLK(clk), .Q(estado[2]), .QN(n11) );
  DFFX1_RVT \estado_atual_reg[1]  ( .D(n13), .CLK(clk), .Q(estado[1]), .QN(n10) );
  AND3X1_RVT U3 ( .A1(estado[1]), .A2(n15), .A3(n11), .Y(mem_read) );
  AND3X1_RVT U4 ( .A1(cancel), .A2(estado[0]), .A3(n10), .Y(reset_credit) );
  OR2X1_RVT U5 ( .A1(coin_in[0]), .A2(coin_in[1]), .Y(n3) );
  NAND4X0_RVT U6 ( .A1(n10), .A2(estado[0]), .A3(n3), .A4(n11), .Y(n2) );
  NAND3X0_RVT U7 ( .A1(n10), .A2(estado[2]), .A3(n15), .Y(n1) );
  NAND2X0_RVT U8 ( .A1(n2), .A2(n1), .Y(credit_load) );
  AND3X1_RVT U9 ( .A1(estado[0]), .A2(estado[2]), .A3(n10), .Y(error) );
  NOR2X0_RVT U10 ( .A1(rst), .A2(cancel), .Y(n9) );
  NAND2X0_RVT U11 ( .A1(n11), .A2(n3), .Y(n5) );
  NAND2X0_RVT U12 ( .A1(estado[0]), .A2(n10), .Y(n4) );
  OAI22X1_RVT U13 ( .A1(estado[0]), .A2(n5), .A3(confirm), .A4(n4), .Y(n6) );
  AO222X1_RVT U14 ( .A1(n9), .A2(error), .A3(n9), .A4(mem_read), .A5(n9), .A6(
        n6), .Y(n14) );
  AND4X1_RVT U15 ( .A1(estado[0]), .A2(confirm), .A3(n10), .A4(n11), .Y(n7) );
  OA221X1_RVT U16 ( .A1(n7), .A2(can_sell), .A3(n7), .A4(mem_read), .A5(n9), 
        .Y(n13) );
  AND3X1_RVT U17 ( .A1(estado[0]), .A2(estado[1]), .A3(n11), .Y(mem_write) );
  NOR3X0_RVT U18 ( .A1(estado[2]), .A2(can_sell), .A3(n10), .Y(n8) );
  AO222X1_RVT U19 ( .A1(n9), .A2(mem_write), .A3(n9), .A4(error), .A5(n9), 
        .A6(n8), .Y(n12) );
endmodule


module registrador_credito ( clk, rst, cancel, credit_load, coin_in, 
        reset_credit, credit );
  input [1:0] coin_in;
  output [7:0] credit;
  input clk, rst, cancel, credit_load, reset_credit;
  wire   n5, n6, n7, n8, n9, n10, n11, n12, n1, n2, n3, n4, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44,
         n45, n46, n47, n48, n49, n50, n51, n52, n53, n54;

  DFFX1_RVT \credit_reg[7]  ( .D(n5), .CLK(clk), .Q(credit[7]) );
  DFFX1_RVT \credit_reg[6]  ( .D(n6), .CLK(clk), .Q(credit[6]), .QN(n53) );
  DFFX1_RVT \credit_reg[5]  ( .D(n7), .CLK(clk), .Q(credit[5]), .QN(n49) );
  DFFX1_RVT \credit_reg[4]  ( .D(n8), .CLK(clk), .Q(credit[4]), .QN(n48) );
  DFFX1_RVT \credit_reg[3]  ( .D(n9), .CLK(clk), .Q(credit[3]), .QN(n52) );
  DFFX1_RVT \credit_reg[2]  ( .D(n10), .CLK(clk), .Q(credit[2]), .QN(n51) );
  DFFX1_RVT \credit_reg[1]  ( .D(n11), .CLK(clk), .Q(credit[1]), .QN(n54) );
  DFFX1_RVT \credit_reg[0]  ( .D(n12), .CLK(clk), .Q(credit[0]), .QN(n50) );
  AND2X1_RVT U3 ( .A1(n1), .A2(n2), .Y(n45) );
  AND2X1_RVT U4 ( .A1(credit_load), .A2(n44), .Y(n1) );
  NAND2X0_RVT U5 ( .A1(n43), .A2(n53), .Y(n2) );
  INVX0_RVT U6 ( .A(coin_in[1]), .Y(n39) );
  NAND2X0_RVT U7 ( .A1(coin_in[0]), .A2(n39), .Y(n25) );
  INVX0_RVT U8 ( .A(n25), .Y(n13) );
  NAND2X0_RVT U9 ( .A1(n13), .A2(credit_load), .Y(n3) );
  INVX0_RVT U10 ( .A(n3), .Y(n4) );
  NOR3X0_RVT U11 ( .A1(reset_credit), .A2(cancel), .A3(rst), .Y(n47) );
  OA221X1_RVT U12 ( .A1(credit[0]), .A2(n4), .A3(n50), .A4(n3), .A5(n47), .Y(
        n12) );
  INVX0_RVT U13 ( .A(coin_in[0]), .Y(n40) );
  AO22X1_RVT U14 ( .A1(coin_in[1]), .A2(n40), .A3(n13), .A4(credit[0]), .Y(n16) );
  NAND2X0_RVT U15 ( .A1(credit_load), .A2(n16), .Y(n14) );
  INVX0_RVT U16 ( .A(n14), .Y(n15) );
  OA221X1_RVT U17 ( .A1(credit[1]), .A2(n15), .A3(n54), .A4(n14), .A5(n47), 
        .Y(n11) );
  AO22X1_RVT U18 ( .A1(coin_in[1]), .A2(coin_in[0]), .A3(credit[1]), .A4(n16), 
        .Y(n19) );
  NAND2X0_RVT U19 ( .A1(credit_load), .A2(n19), .Y(n17) );
  INVX0_RVT U20 ( .A(n17), .Y(n18) );
  OA221X1_RVT U21 ( .A1(credit[2]), .A2(n18), .A3(n51), .A4(n17), .A5(n47), 
        .Y(n10) );
  NAND2X0_RVT U22 ( .A1(credit[2]), .A2(n19), .Y(n20) );
  NAND2X0_RVT U23 ( .A1(n25), .A2(n20), .Y(n23) );
  OR2X1_RVT U24 ( .A1(n25), .A2(n20), .Y(n24) );
  NAND3X0_RVT U25 ( .A1(credit_load), .A2(n23), .A3(n24), .Y(n21) );
  INVX0_RVT U26 ( .A(n21), .Y(n22) );
  OA221X1_RVT U27 ( .A1(credit[3]), .A2(n22), .A3(n52), .A4(n21), .A5(n47), 
        .Y(n9) );
  NAND2X0_RVT U28 ( .A1(credit[3]), .A2(n23), .Y(n26) );
  AO22X1_RVT U29 ( .A1(n25), .A2(coin_in[0]), .A3(n26), .A4(n24), .Y(n31) );
  OA21X1_RVT U30 ( .A1(coin_in[0]), .A2(n39), .A3(n25), .Y(n27) );
  NAND2X0_RVT U31 ( .A1(n27), .A2(n26), .Y(n30) );
  NAND3X0_RVT U32 ( .A1(credit_load), .A2(n31), .A3(n30), .Y(n28) );
  INVX0_RVT U33 ( .A(n28), .Y(n29) );
  OA221X1_RVT U34 ( .A1(credit[4]), .A2(n29), .A3(n48), .A4(n28), .A5(n47), 
        .Y(n8) );
  INVX0_RVT U35 ( .A(n30), .Y(n32) );
  OA21X1_RVT U36 ( .A1(n48), .A2(n32), .A3(n31), .Y(n36) );
  INVX0_RVT U37 ( .A(n36), .Y(n33) );
  OA221X1_RVT U38 ( .A1(coin_in[1]), .A2(n33), .A3(n39), .A4(n36), .A5(
        credit_load), .Y(n35) );
  INVX0_RVT U39 ( .A(n35), .Y(n34) );
  OA221X1_RVT U40 ( .A1(credit[5]), .A2(n35), .A3(n49), .A4(n34), .A5(n47), 
        .Y(n7) );
  OA222X1_RVT U41 ( .A1(n39), .A2(n49), .A3(n39), .A4(n36), .A5(n49), .A6(n36), 
        .Y(n38) );
  NAND2X0_RVT U42 ( .A1(coin_in[1]), .A2(coin_in[0]), .Y(n37) );
  NAND2X0_RVT U43 ( .A1(n38), .A2(n37), .Y(n44) );
  OR3X1_RVT U44 ( .A1(n40), .A2(n39), .A3(n38), .Y(n43) );
  NAND3X0_RVT U45 ( .A1(credit_load), .A2(n44), .A3(n43), .Y(n41) );
  INVX0_RVT U46 ( .A(n41), .Y(n42) );
  OA221X1_RVT U47 ( .A1(credit[6]), .A2(n42), .A3(n53), .A4(n41), .A5(n47), 
        .Y(n6) );
  HADDX1_RVT U48 ( .A0(credit[7]), .B0(n45), .SO(n46) );
  AND2X1_RVT U49 ( .A1(n47), .A2(n46), .Y(n5) );
endmodule


module memoria ( clk, rst, sel_item, mem_read, mem_write, price, stock );
  input [1:0] sel_item;
  output [7:0] price;
  output [7:0] stock;
  input clk, rst, mem_read, mem_write;
  wire   \mem[0][4] , \mem[0][3] , \mem[0][2] , \mem[0][1] , \mem[0][0] ,
         \mem[1][4] , \mem[1][3] , \mem[1][2] , \mem[1][1] , \mem[1][0] ,
         \mem[2][4] , \mem[2][3] , \mem[2][2] , \mem[2][1] , \mem[2][0] ,
         \mem[3][4] , \mem[3][3] , \mem[3][2] , \mem[3][1] , \mem[3][0] , n36,
         n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50,
         n51, n52, n53, n54, n55, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11,
         n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25,
         n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n56, n57, n58, n59,
         n60, n61;
  assign price[0] = price[3];

  DFFX1_RVT \mem_reg[3][0]  ( .D(n55), .CLK(clk), .Q(\mem[3][0] ) );
  DFFX1_RVT \mem_reg[3][2]  ( .D(n47), .CLK(clk), .Q(\mem[3][2] ) );
  DFFX1_RVT \mem_reg[3][1]  ( .D(n50), .CLK(clk), .Q(\mem[3][1] ) );
  DFFX1_RVT \mem_reg[3][3]  ( .D(n43), .CLK(clk), .Q(\mem[3][3] ) );
  DFFX1_RVT \mem_reg[3][4]  ( .D(n39), .CLK(clk), .Q(\mem[3][4] ) );
  DFFX1_RVT \mem_reg[0][0]  ( .D(n53), .CLK(clk), .Q(\mem[0][0] ) );
  DFFX1_RVT \mem_reg[0][2]  ( .D(n46), .CLK(clk), .Q(\mem[0][2] ) );
  DFFX1_RVT \mem_reg[0][1]  ( .D(n54), .CLK(clk), .Q(\mem[0][1] ) );
  DFFX1_RVT \mem_reg[0][3]  ( .D(n42), .CLK(clk), .Q(\mem[0][3] ) );
  DFFX1_RVT \mem_reg[0][4]  ( .D(n38), .CLK(clk), .Q(\mem[0][4] ) );
  DFFX1_RVT \mem_reg[1][0]  ( .D(n52), .CLK(clk), .Q(\mem[1][0] ) );
  DFFX1_RVT \mem_reg[1][2]  ( .D(n45), .CLK(clk), .Q(\mem[1][2] ) );
  DFFX1_RVT \mem_reg[1][1]  ( .D(n49), .CLK(clk), .Q(\mem[1][1] ) );
  DFFX1_RVT \mem_reg[1][3]  ( .D(n41), .CLK(clk), .Q(\mem[1][3] ) );
  DFFX1_RVT \mem_reg[1][4]  ( .D(n37), .CLK(clk), .Q(\mem[1][4] ) );
  DFFX1_RVT \mem_reg[2][0]  ( .D(n51), .CLK(clk), .Q(\mem[2][0] ) );
  DFFX1_RVT \mem_reg[2][2]  ( .D(n44), .CLK(clk), .Q(\mem[2][2] ) );
  DFFX1_RVT \mem_reg[2][1]  ( .D(n48), .CLK(clk), .Q(\mem[2][1] ) );
  DFFX1_RVT \mem_reg[2][3]  ( .D(n40), .CLK(clk), .Q(\mem[2][3] ) );
  DFFX1_RVT \mem_reg[2][4]  ( .D(n36), .CLK(clk), .Q(\mem[2][4] ) );
  INVX2_RVT U7 ( .A(sel_item[1]), .Y(n5) );
  INVX0_RVT U8 ( .A(rst), .Y(n14) );
  INVX0_RVT U9 ( .A(sel_item[0]), .Y(n4) );
  AND2X1_RVT U10 ( .A1(mem_read), .A2(n4), .Y(price[3]) );
  MUX41X1_RVT U11 ( .A1(\mem[3][0] ), .A3(\mem[1][0] ), .A2(\mem[2][0] ), .A4(
        \mem[0][0] ), .S0(n5), .S1(n4), .Y(n8) );
  AND2X1_RVT U12 ( .A1(mem_read), .A2(n8), .Y(stock[0]) );
  MUX41X1_RVT U13 ( .A1(\mem[2][1] ), .A3(\mem[0][1] ), .A2(\mem[3][1] ), .A4(
        \mem[1][1] ), .S0(n5), .S1(sel_item[0]), .Y(n9) );
  AND2X1_RVT U14 ( .A1(mem_read), .A2(n9), .Y(stock[1]) );
  MUX41X1_RVT U15 ( .A1(\mem[2][2] ), .A3(\mem[0][2] ), .A2(\mem[3][2] ), .A4(
        \mem[1][2] ), .S0(n5), .S1(sel_item[0]), .Y(n17) );
  AND2X1_RVT U16 ( .A1(mem_read), .A2(n17), .Y(stock[2]) );
  MUX41X1_RVT U17 ( .A1(\mem[2][3] ), .A3(\mem[0][3] ), .A2(\mem[3][3] ), .A4(
        \mem[1][3] ), .S0(n5), .S1(sel_item[0]), .Y(n25) );
  AND2X1_RVT U18 ( .A1(mem_read), .A2(n25), .Y(stock[3]) );
  MUX41X1_RVT U19 ( .A1(\mem[2][4] ), .A3(\mem[0][4] ), .A2(\mem[3][4] ), .A4(
        \mem[1][4] ), .S0(n5), .S1(sel_item[0]), .Y(n29) );
  AND2X1_RVT U20 ( .A1(mem_read), .A2(n29), .Y(stock[4]) );
  MUX41X1_RVT U21 ( .A1(1'b0), .A3(1'b0), .A2(1'b0), .A4(1'b0), .S0(n5), .S1(
        sel_item[0]), .Y(n33) );
  AND2X1_RVT U22 ( .A1(mem_read), .A2(n33), .Y(stock[5]) );
  AND2X1_RVT U23 ( .A1(sel_item[0]), .A2(n5), .Y(n10) );
  AND2X1_RVT U24 ( .A1(sel_item[1]), .A2(n4), .Y(n12) );
  OA21X1_RVT U25 ( .A1(n10), .A2(n12), .A3(mem_read), .Y(price[1]) );
  AND2X1_RVT U26 ( .A1(sel_item[0]), .A2(mem_read), .Y(price[5]) );
  AND2X1_RVT U27 ( .A1(sel_item[1]), .A2(sel_item[0]), .Y(n3) );
  AND2X1_RVT U28 ( .A1(n3), .A2(mem_read), .Y(price[2]) );
  AND2X1_RVT U29 ( .A1(mem_read), .A2(n5), .Y(price[4]) );
  AND2X1_RVT U30 ( .A1(sel_item[1]), .A2(mem_read), .Y(price[6]) );
  AND2X1_RVT U31 ( .A1(n14), .A2(mem_write), .Y(n2) );
  OR2X1_RVT U32 ( .A1(n9), .A2(n8), .Y(n18) );
  OR2X1_RVT U33 ( .A1(n18), .A2(n17), .Y(n26) );
  OR2X1_RVT U34 ( .A1(n26), .A2(n25), .Y(n30) );
  OR2X1_RVT U35 ( .A1(n30), .A2(n29), .Y(n32) );
  OR2X1_RVT U36 ( .A1(n32), .A2(n33), .Y(n1) );
  AND2X1_RVT U37 ( .A1(n2), .A2(n1), .Y(n11) );
  NAND2X0_RVT U38 ( .A1(n3), .A2(n11), .Y(n19) );
  INVX0_RVT U39 ( .A(n19), .Y(n34) );
  INVX0_RVT U40 ( .A(n8), .Y(n13) );
  AO221X1_RVT U41 ( .A1(n34), .A2(n13), .A3(n19), .A4(\mem[3][0] ), .A5(rst), 
        .Y(n55) );
  AND2X1_RVT U42 ( .A1(n5), .A2(n4), .Y(n6) );
  NAND2X0_RVT U43 ( .A1(n6), .A2(n11), .Y(n20) );
  AND2X1_RVT U44 ( .A1(n14), .A2(n20), .Y(n57) );
  INVX0_RVT U45 ( .A(n20), .Y(n56) );
  INVX0_RVT U46 ( .A(n18), .Y(n7) );
  AO21X1_RVT U47 ( .A1(n9), .A2(n8), .A3(n7), .Y(n15) );
  AO22X1_RVT U48 ( .A1(\mem[0][1] ), .A2(n57), .A3(n56), .A4(n15), .Y(n54) );
  AO221X1_RVT U49 ( .A1(n56), .A2(n13), .A3(n20), .A4(\mem[0][0] ), .A5(rst), 
        .Y(n53) );
  NAND2X0_RVT U50 ( .A1(n10), .A2(n11), .Y(n21) );
  INVX0_RVT U51 ( .A(n21), .Y(n58) );
  AO221X1_RVT U52 ( .A1(n58), .A2(n13), .A3(n21), .A4(\mem[1][0] ), .A5(rst), 
        .Y(n52) );
  NAND2X0_RVT U53 ( .A1(n12), .A2(n11), .Y(n22) );
  INVX0_RVT U54 ( .A(n22), .Y(n60) );
  AO221X1_RVT U55 ( .A1(n60), .A2(n13), .A3(n22), .A4(\mem[2][0] ), .A5(rst), 
        .Y(n51) );
  AND2X1_RVT U56 ( .A1(n14), .A2(n19), .Y(n35) );
  AO22X1_RVT U57 ( .A1(\mem[3][1] ), .A2(n35), .A3(n34), .A4(n15), .Y(n50) );
  AND2X1_RVT U58 ( .A1(n14), .A2(n21), .Y(n59) );
  AO22X1_RVT U59 ( .A1(\mem[1][1] ), .A2(n59), .A3(n58), .A4(n15), .Y(n49) );
  AND2X1_RVT U60 ( .A1(n14), .A2(n22), .Y(n61) );
  AO22X1_RVT U61 ( .A1(\mem[2][1] ), .A2(n61), .A3(n60), .A4(n15), .Y(n48) );
  INVX0_RVT U62 ( .A(n26), .Y(n16) );
  AO21X1_RVT U63 ( .A1(n18), .A2(n17), .A3(n16), .Y(n23) );
  AO221X1_RVT U64 ( .A1(n34), .A2(n23), .A3(n19), .A4(\mem[3][2] ), .A5(rst), 
        .Y(n47) );
  AO221X1_RVT U65 ( .A1(n56), .A2(n23), .A3(n20), .A4(\mem[0][2] ), .A5(rst), 
        .Y(n46) );
  AO221X1_RVT U66 ( .A1(n58), .A2(n23), .A3(n21), .A4(\mem[1][2] ), .A5(rst), 
        .Y(n45) );
  AO221X1_RVT U67 ( .A1(n60), .A2(n23), .A3(n22), .A4(\mem[2][2] ), .A5(rst), 
        .Y(n44) );
  INVX0_RVT U68 ( .A(n30), .Y(n24) );
  AO21X1_RVT U69 ( .A1(n26), .A2(n25), .A3(n24), .Y(n27) );
  AO22X1_RVT U70 ( .A1(\mem[3][3] ), .A2(n35), .A3(n34), .A4(n27), .Y(n43) );
  AO22X1_RVT U71 ( .A1(\mem[0][3] ), .A2(n57), .A3(n56), .A4(n27), .Y(n42) );
  AO22X1_RVT U72 ( .A1(\mem[1][3] ), .A2(n59), .A3(n58), .A4(n27), .Y(n41) );
  AO22X1_RVT U73 ( .A1(\mem[2][3] ), .A2(n61), .A3(n60), .A4(n27), .Y(n40) );
  INVX0_RVT U74 ( .A(n32), .Y(n28) );
  AO21X1_RVT U75 ( .A1(n30), .A2(n29), .A3(n28), .Y(n31) );
  AO22X1_RVT U76 ( .A1(\mem[3][4] ), .A2(n35), .A3(n34), .A4(n31), .Y(n39) );
  AO22X1_RVT U77 ( .A1(\mem[0][4] ), .A2(n57), .A3(n56), .A4(n31), .Y(n38) );
  AO22X1_RVT U78 ( .A1(\mem[1][4] ), .A2(n59), .A3(n58), .A4(n31), .Y(n37) );
  AO22X1_RVT U79 ( .A1(\mem[2][4] ), .A2(n61), .A3(n60), .A4(n31), .Y(n36) );
endmodule


module comparador ( credit, price, stock, can_sell );
  input [7:0] credit;
  input [7:0] price;
  input [7:0] stock;
  output can_sell;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17;

  NAND2X0_RVT U2 ( .A1(n14), .A2(n13), .Y(n16) );
  INVX0_RVT U3 ( .A(price[1]), .Y(n2) );
  INVX0_RVT U4 ( .A(price[3]), .Y(n5) );
  OA22X1_RVT U5 ( .A1(credit[1]), .A2(n2), .A3(n5), .A4(credit[0]), .Y(n1) );
  AO21X1_RVT U6 ( .A1(n2), .A2(credit[1]), .A3(n1), .Y(n4) );
  INVX0_RVT U7 ( .A(price[2]), .Y(n3) );
  AO222X1_RVT U8 ( .A1(credit[2]), .A2(n4), .A3(credit[2]), .A4(n3), .A5(n4), 
        .A6(n3), .Y(n6) );
  AO222X1_RVT U9 ( .A1(credit[3]), .A2(n6), .A3(credit[3]), .A4(n5), .A5(n6), 
        .A6(n5), .Y(n8) );
  INVX0_RVT U10 ( .A(price[4]), .Y(n7) );
  AO222X1_RVT U11 ( .A1(credit[4]), .A2(n8), .A3(credit[4]), .A4(n7), .A5(n8), 
        .A6(n7), .Y(n10) );
  INVX0_RVT U12 ( .A(price[5]), .Y(n9) );
  AO222X1_RVT U13 ( .A1(credit[5]), .A2(n10), .A3(credit[5]), .A4(n9), .A5(n10), .A6(n9), .Y(n12) );
  INVX0_RVT U14 ( .A(price[6]), .Y(n11) );
  AO222X1_RVT U15 ( .A1(credit[6]), .A2(n12), .A3(credit[6]), .A4(n11), .A5(
        n12), .A6(n11), .Y(n17) );
  INVX0_RVT U16 ( .A(stock[5]), .Y(n14) );
  INVX0_RVT U17 ( .A(stock[4]), .Y(n13) );
  OR4X1_RVT U18 ( .A1(stock[3]), .A2(stock[2]), .A3(stock[1]), .A4(stock[0]), 
        .Y(n15) );
  OA22X1_RVT U19 ( .A1(credit[7]), .A2(n17), .A3(n16), .A4(n15), .Y(can_sell)
         );
endmodule


module subtrator ( credit, price, change );
  input [7:0] credit;
  input [7:0] price;
  output [7:0] change;
  wire   \intadd_0/B[5] , \intadd_0/B[4] , \intadd_0/B[3] , \intadd_0/B[2] ,
         \intadd_0/B[1] , \intadd_0/B[0] , \intadd_0/CI , \intadd_0/SUM[5] ,
         \intadd_0/SUM[4] , \intadd_0/SUM[3] , \intadd_0/SUM[2] ,
         \intadd_0/SUM[1] , \intadd_0/SUM[0] , \intadd_0/n6 , \intadd_0/n5 ,
         \intadd_0/n4 , \intadd_0/n3 , \intadd_0/n2 , \intadd_0/n1 , n1;

  FADDX1_RVT \intadd_0/U7  ( .A(\intadd_0/B[0] ), .B(price[1]), .CI(
        \intadd_0/CI ), .CO(\intadd_0/n6 ), .S(\intadd_0/SUM[0] ) );
  FADDX1_RVT \intadd_0/U6  ( .A(\intadd_0/B[1] ), .B(price[2]), .CI(
        \intadd_0/n6 ), .CO(\intadd_0/n5 ), .S(\intadd_0/SUM[1] ) );
  FADDX1_RVT \intadd_0/U5  ( .A(\intadd_0/B[2] ), .B(price[0]), .CI(
        \intadd_0/n5 ), .CO(\intadd_0/n4 ), .S(\intadd_0/SUM[2] ) );
  FADDX1_RVT \intadd_0/U4  ( .A(\intadd_0/B[3] ), .B(price[4]), .CI(
        \intadd_0/n4 ), .CO(\intadd_0/n3 ), .S(\intadd_0/SUM[3] ) );
  FADDX1_RVT \intadd_0/U3  ( .A(\intadd_0/B[4] ), .B(price[5]), .CI(
        \intadd_0/n3 ), .CO(\intadd_0/n2 ), .S(\intadd_0/SUM[4] ) );
  FADDX1_RVT \intadd_0/U2  ( .A(\intadd_0/B[5] ), .B(price[6]), .CI(
        \intadd_0/n2 ), .CO(\intadd_0/n1 ), .S(\intadd_0/SUM[5] ) );
  INVX0_RVT U1 ( .A(\intadd_0/SUM[0] ), .Y(change[1]) );
  INVX0_RVT U2 ( .A(\intadd_0/SUM[1] ), .Y(change[2]) );
  INVX0_RVT U3 ( .A(\intadd_0/SUM[2] ), .Y(change[3]) );
  INVX0_RVT U4 ( .A(\intadd_0/SUM[3] ), .Y(change[4]) );
  INVX0_RVT U5 ( .A(\intadd_0/SUM[4] ), .Y(change[5]) );
  INVX0_RVT U6 ( .A(\intadd_0/SUM[5] ), .Y(change[6]) );
  XOR2X1_RVT U7 ( .A1(\intadd_0/n1 ), .A2(credit[7]), .Y(change[7]) );
  INVX0_RVT U8 ( .A(price[0]), .Y(n1) );
  NOR2X0_RVT U9 ( .A1(n1), .A2(credit[0]), .Y(\intadd_0/CI ) );
  INVX0_RVT U10 ( .A(credit[4]), .Y(\intadd_0/B[3] ) );
  INVX0_RVT U11 ( .A(credit[5]), .Y(\intadd_0/B[4] ) );
  INVX0_RVT U12 ( .A(credit[6]), .Y(\intadd_0/B[5] ) );
  INVX0_RVT U13 ( .A(credit[1]), .Y(\intadd_0/B[0] ) );
  INVX0_RVT U14 ( .A(credit[3]), .Y(\intadd_0/B[2] ) );
  INVX0_RVT U15 ( .A(credit[2]), .Y(\intadd_0/B[1] ) );
  AO21X1_RVT U16 ( .A1(credit[0]), .A2(n1), .A3(\intadd_0/CI ), .Y(change[0])
         );
endmodule


module vending_top ( coin_in, sel_item, confirm, cancel, clk, rst, dispense, 
        change_out, error, display, state_out );
  input [1:0] coin_in;
  input [1:0] sel_item;
  output [7:0] change_out;
  output [7:0] display;
  output [2:0] state_out;
  input confirm, cancel, clk, rst;
  output dispense, error;
  wire   w_can_sell, w_credit_load, w_reset_credit, w_mem_read, w_mem_write,
         n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, net1096, net1097,
         net1098, net1099;
  wire   [2:1] w_estado;
  wire   [7:0] w_price;
  wire   [7:0] w_stock;
  wire   [7:0] w_change;
  wire   SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2;
  assign state_out[1] = 1'b0;
  assign state_out[2] = 1'b0;

  unidade_controle fsm_inst ( .clk(clk), .rst(rst), .cancel(cancel), .coin_in(
        coin_in), .confirm(confirm), .can_sell(w_can_sell), .estado({w_estado, 
        state_out[0]}), .credit_load(w_credit_load), .reset_credit(
        w_reset_credit), .mem_read(w_mem_read), .mem_write(w_mem_write), 
        .dispense(dispense), .error(error) );
  registrador_credito credit_inst ( .clk(clk), .rst(rst), .cancel(cancel), 
        .credit_load(w_credit_load), .coin_in(coin_in), .reset_credit(
        w_reset_credit), .credit(display) );
  memoria mem_inst ( .clk(clk), .rst(rst), .sel_item(sel_item), .mem_read(
        w_mem_read), .mem_write(w_mem_write), .price({SYNOPSYS_UNCONNECTED__0, 
        w_price[6:0]}), .stock({SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, w_stock[5:0]}) );
  comparador comp_inst ( .credit(display), .price({net1097, w_price[6:0]}), 
        .stock({net1098, net1099, w_stock[5:0]}), .can_sell(w_can_sell) );
  subtrator sub_inst ( .credit(display), .price({net1096, w_price[6:0]}), 
        .change(w_change) );
  DFFX1_RVT \change_out_reg[7]  ( .D(n11), .CLK(clk), .Q(change_out[7]) );
  DFFX1_RVT \change_out_reg[6]  ( .D(n10), .CLK(clk), .Q(change_out[6]) );
  DFFX1_RVT \change_out_reg[5]  ( .D(n9), .CLK(clk), .Q(change_out[5]) );
  DFFX1_RVT \change_out_reg[4]  ( .D(n8), .CLK(clk), .Q(change_out[4]) );
  DFFX1_RVT \change_out_reg[3]  ( .D(n7), .CLK(clk), .Q(change_out[3]) );
  DFFX1_RVT \change_out_reg[2]  ( .D(n6), .CLK(clk), .Q(change_out[2]) );
  DFFX1_RVT \change_out_reg[1]  ( .D(n5), .CLK(clk), .Q(change_out[1]) );
  DFFX1_RVT \change_out_reg[0]  ( .D(n4), .CLK(clk), .Q(change_out[0]) );
  NOR4X1_RVT U16 ( .A1(rst), .A2(cancel), .A3(state_out[0]), .A4(w_estado[1]), 
        .Y(n12) );
  AND2X1_RVT U17 ( .A1(w_estado[2]), .A2(n12), .Y(n14) );
  NOR3X0_RVT U18 ( .A1(rst), .A2(cancel), .A3(n14), .Y(n13) );
  AO22X1_RVT U19 ( .A1(n14), .A2(w_change[7]), .A3(n13), .A4(change_out[7]), 
        .Y(n11) );
  AO22X1_RVT U20 ( .A1(n14), .A2(w_change[6]), .A3(n13), .A4(change_out[6]), 
        .Y(n10) );
  AO22X1_RVT U21 ( .A1(n14), .A2(w_change[5]), .A3(n13), .A4(change_out[5]), 
        .Y(n9) );
  AO22X1_RVT U22 ( .A1(n14), .A2(w_change[4]), .A3(n13), .A4(change_out[4]), 
        .Y(n8) );
  AO22X1_RVT U23 ( .A1(n14), .A2(w_change[3]), .A3(n13), .A4(change_out[3]), 
        .Y(n7) );
  AO22X1_RVT U24 ( .A1(n14), .A2(w_change[2]), .A3(n13), .A4(change_out[2]), 
        .Y(n6) );
  AO22X1_RVT U25 ( .A1(n14), .A2(w_change[1]), .A3(n13), .A4(change_out[1]), 
        .Y(n5) );
  AO22X1_RVT U26 ( .A1(n14), .A2(w_change[0]), .A3(n13), .A4(change_out[0]), 
        .Y(n4) );
endmodule

